from fastapi import FastAPI, Request
from pydantic import BaseModel
from transformers import T5ForConditionalGeneration, T5Tokenizer
import torch
import re
from fastapi.templating import Jinja2Templates 
from fastapi.responses import HTMLResponse
from fastapi.staticfiles import StaticFiles

#inititalize our fastapi app

app = FastAPI(title = "Grammar Correction App", description = "Grammar correctiob by T5", version = "1.0")

#model & tokenizer
test_tokenizer = T5Tokenizer.from_pretrained("./saved_gec_model4", use_fast = False)
test_model = T5ForConditionalGeneration.from_pretrained("./saved_gec_model4")

#templating
templates = Jinja2Templates(directory = ".")

#Input schema for text => string
class wrong_text(BaseModel):
    wrong_text:str

def correct_my_grammar(wrong_text:str):
    input_text = "gec: " + wrong_text
    inputs = test_tokenizer(input_text, padding = "longest", return_tensors = "pt")
    outputs = test_model.generate(**inputs, max_length = 128)
    corrected_text = test_tokenizer.decode(outputs, skip_special_tokens = True)
    return corrected_text

#API Endpoints

@app.post("/correct")
async def correct_text(wrong_Text:wrong_text):
    corrected_result = correct_my_grammar(wrong_Text.wrong_text)
    return {"correct": corrected_result}

@app.get("/", response_class = HTMLResponse)
async def home(request:Request):
    return templates.TemplateResponse(request=request, name = "index.html")