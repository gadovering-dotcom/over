from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
import sqlite3, hashlib

router = APIRouter(prefix="/auth")
DB = "routine.db"

class User(BaseModel):
    username: str
    password: str

def hash_password(p):
    return hashlib.sha256(p.encode()).hexdigest()

@router.post("/register")
def register(user: User):
    conn = sqlite3.connect(DB)
    cur = conn.cursor()
    cur.execute("CREATE TABLE IF NOT EXISTS users(id INTEGER PRIMARY KEY, username TEXT UNIQUE, password TEXT)")
    try:
        cur.execute("INSERT INTO users(username,password) VALUES(?,?)", (user.username, hash_password(user.password)))
        conn.commit()
    except:
        raise HTTPException(400, "User exists")
    finally:
        conn.close()
    return {"created": True}

@router.post("/login")
def login(user: User):
    conn = sqlite3.connect(DB)
    cur = conn.cursor()
    cur.execute("SELECT id FROM users WHERE username=? AND password=?", (user.username, hash_password(user.password)))
    result = cur.fetchone()
    conn.close()
    if not result:
        raise HTTPException(401, "Invalid login")
    return {"login": True, "user_id": result[0]}
