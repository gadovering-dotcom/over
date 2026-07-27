from fastapi import FastAPI
from backend.database import init_db

app = FastAPI(title="Over Daily Routine")

@app.on_event("startup")
def startup():
    init_db()

@app.get("/")
def home():
    return {"name": "Over", "status": "running"}

@app.get("/health")
def health():
    return {"ok": True}
