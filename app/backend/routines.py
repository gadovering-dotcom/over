from fastapi import APIRouter
from pydantic import BaseModel
from database import DB
import sqlite3

router = APIRouter(prefix="/tasks")

class Task(BaseModel):
    title: str

@router.get("")
def list_tasks():
    conn = sqlite3.connect(DB)
    cur = conn.cursor()
    cur.execute("SELECT id,title,completed FROM tasks")
    rows = cur.fetchall()
    conn.close()
    return [{"id":r[0],"title":r[1],"completed":bool(r[2])} for r in rows]

@router.post("")
def add_task(task: Task):
    conn = sqlite3.connect(DB)
    cur = conn.cursor()
    cur.execute("INSERT INTO tasks(title) VALUES(?)", (task.title,))
    conn.commit()
    conn.close()
    return {"created": True}

@router.delete("/{task_id}")
def delete_task(task_id:int):
    conn = sqlite3.connect(DB)
    cur = conn.cursor()
    cur.execute("DELETE FROM tasks WHERE id=?", (task_id,))
    conn.commit()
    conn.close()
    return {"deleted": True}
