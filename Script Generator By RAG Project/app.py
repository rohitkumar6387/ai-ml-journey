from fastapi import FastAPI,Request
from pydantic import BaseModel
from transformers import T5ForConditionalGeneration,T5Tokenizer
import torch
import re
from fastapi.templating import Jinja2Templates 
from fastapi.responses import HTMLResponse
from fastapi.staticfiles import StaticFiles

app = FastAPI(title="Script Generator App", desccription="Script Generation using T5", version="1.0")

#model & tokenizer

model = T5ForConditionalGeneration.from_pretrained("google/flan-t5-base")
tokenizer = T5Tokenizer.from_pretrained("google/flan-t5-base")

templates = Jinja2Templates(directory =".")

#Input schema
class ScriptGenerate(BaseModel):
    text:str

def Generate_script(text:str):
    
    inputs = tokenizer(text, return_tensors = "pt", padding = True)
    outputs = model.generate(**inputs, max_length = 256)
    correct_output = tokenizer.decode(outputs, skip_special_tokens = True)
    return correct_output

#------API Endpoints------

@app.post("/generate")
async def perform_generation(request_data:ScriptGenerate):
    generated_result = Generate_script(request_data.text)
    return {"generated_text":generated_result}

@app.get("/",response_class=HTMLResponse)
async def home(request:Request):
    return templates.TemplateResponse(request=request ,name = "index.html")
