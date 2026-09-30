from flask import Flask, render_template, request, jsonify, url_for
import os
from dotenv import load_dotenv
from langchain_groq import ChatGroq
from langchain_core.documents import Document
from langchain_community.document_loaders.text import TextLoader
from langchain_community.document_loaders.pdf import PyPDFLoader
from langchain_text_splitters import RecursiveCharacterTextSplitter
from sentence_transformers import SentenceTransformer
import chromadb
import uuid

loader = TextLoader("data/history.txt",encoding="utf-8")
pdf_loader = PyPDFLoader("data/history.pdf")

def load_all_pdfs():
    folder_path = "data/pdfs"
    num_docs = 0
    all_docs = []
    for filename in os.listdir(folder_path):
        if filename.lower().endswith(".pdf"):
            pdf_path = os.path.join(folder_path,filename)
            loader = PyPDFLoader(pdf_path)
            doc = loader.load()
            all_docs.extend(doc)
            num_docs += 1
    print("total pdfs:", num_docs)
    print("total pages:",len(all_docs))
    return all_docs

all_pdf_documents = load_all_pdfs()
type(all_pdf_documents[1])

def split_docs(documents, chunk_size = 500, chunk_overlap = 50):
    text_splitter = RecursiveCharacterTextSplitter(
        chunk_size = chunk_size,
        chunk_overlap = chunk_overlap
    )
    chunked_docs = text_splitter.split_documents(documents)
    return chunked_docs

chunks = split_docs(all_pdf_documents)


class EmbeddingManager:
    def __init__(self, model_name = "all-MiniLM-L6-v2"):
        self.model_name = model_name
        self.model = SentenceTransformer(self.model_name)

    def generate_embeddings(self,text):
        embeddings = self.model.encode(text, show_progress_bar = True)
        print("embedding shape:",embeddings.shape)
        return embeddings

embedding_manager = EmbeddingManager()   

class VectorStoreManager:
    def __init__(self,persist_directory = "data/vector_store", collection_name = "pdf_documents"):
        self.collection_name = collection_name
        self.persist_directory = persist_directory
        self.collection = None
        
        self._initialize_store()

    def _initialize_store(self):
        os.makedirs(self.persist_directory, exist_ok = True)

        #create a client
        self.client = chromadb.PersistentClient(path = self.persist_directory)

        #create the collection
        self.collection = self.client.get_or_create_collection(
            name = self.collection_name,
            metadata = {"description":"vector store collection for pdf embeddings in RAG"}
        )

        print("initialized the vector store with collection:", self.collection_name)
        print("docs in collection:", self.collection.count())

    def add_documents(self, documents, embeddings):
        if len(documents)!= len(embeddings):
            raise ValueError("num of documents docs not match num of embeddings")

        ids = []
        all_metadata = []
        documents_content = []
        embeddings_list = []

        for i, (doc, embedding) in enumerate(zip(documents,embeddings)):
            doc_id = f"doc{uuid.uuid4()}"
            ids.append(doc_id)

            metadata = dict(doc.metadata)
            metadata["doc_index"] = i
            metadata["content_length"] = len(doc.page_content)
            all_metadata.append(metadata)

            documents_content.append(doc.page_content)
            embeddings_list.append(embedding.tolist())

            self.collection.add(
                ids = ids,
                metadatas = all_metadata,
                documents = documents_content,
                embeddings = embeddings_list
            )

        print("total document added in vector store = ", len(documents_content))
        print("docs in collection:", self.collection.count())

vector_store = VectorStoreManager() 

texts = [doc.page_content for doc in chunks]

embedding = embedding_manager.generate_embeddings(texts)

vector_store.add_documents(chunks,embedding)

class RAGRetriever:
    def __init__(self, embedding_manager, vector_store):
        self.embedding_manager = embedding_manager
        self.vector_store = vector_store

    def retrieve(self, query, top_k = 5, score_threshold = 0.0):
        #query => embedding
        query_embeddings = self.embedding_manager.generate_embeddings([query])[0]

        #semantic search
        results = self.vector_store.collection.query(
            query_embeddings = [query_embeddings.tolist()],
            n_results = top_k
        )

        #cosine simliarity
        retrieved_docs = []
        if results["documents"] and results["documents"][0]:
            ids = results["ids"][0]
            metadatas = results["metadatas"][0]
            documents = results["documents"][0]
            distances = results["distances"][0]

            for i, (doc_id, metadata, document, distance) in enumerate(zip(ids, metadatas, documents, distances)):
                similarity_score = 1-distance 

                if similarity_score >= score_threshold:
                    retrieved_docs.append({
                        "id":doc_id,
                        "document":document,
                        "metadata":metadata,
                        "distance":distance,
                        "similarity_score":similarity_score,
                        "rank": i+1
                    })

        else:
            print("no documents found")

        return retrieved_docs

rag_retriever = RAGRetriever(embedding_manager, vector_store)

app = Flask(__name__)

load_dotenv()
api_key = os.getenv("API_KEY_GROQ")

llm = ChatGroq(
    groq_api_key = api_key,
    model = "qwen/qwen3.6-27b",
    temperature = 0.1,
    max_tokens = 1024
)


@app.route("/")
def hello_world():
    return render_template("index.html")

@app.route("/ask",methods=["POST"])
def ask():
    top_k=3
    question = request.form.get("question")
    results = rag_retriever.retrieve(question,top_k)

    context = "\n".join([doc["document"] for doc in results]) if results else ""

    prompt = f"""use given contxt to generate the answer for thr query
        context:{context}
        Query:{question}"""
    response = llm.invoke([prompt.format(context = context, query = question)])
    answer = response.content
    return jsonify({"response":answer})

if __name__ == "__main__":
    app.run(debug=True)