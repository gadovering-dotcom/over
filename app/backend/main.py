from fastapi import FastAPI
from backend.database import init_db
from backend.routines import router as routines_router

app = FastAPI(title="Over Daily Routine")

@app.on_event("startup")
def startup():
    init_db()

app.include_router(routines_router)

@app.get("/")
def home():
    return {"name": "Over", "status": "running"}

@app.get("/health")
def health():
    return {"ok": True}
