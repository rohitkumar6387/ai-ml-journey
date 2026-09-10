from agno.agent import Agent
from agno.models.groq import Groq
from dotenv import load_dotenv
from agno.tools.websearch import WebSearchTools
import os

load_dotenv()
api_key = os.getenv("API_KEY_GROQ")

def build_agent():
    return Agent(
        model = Groq(id = "qwen/qwen3.6-27b", api_key=api_key, max_tokens=800),
        tools = [WebSearchTools(backend = "yandex")],
        markdown = True,
        instructions = "You are a helpful and expert teacher. Never include specific years like 2026 in the search query",
        
    )

agent = build_agent()
agent.print_response("Who was the Defence Minister of India in 2018?")