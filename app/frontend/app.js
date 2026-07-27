const API='/tasks';

async function loadTasks(){
 const res=await fetch(API);
 const tasks=await res.json();
 document.getElementById('tasks').innerHTML=tasks.map(t=>`<li>${t.title}</li>`).join('');
}

async function addTask(){
 const title=document.getElementById('task').value;
 await fetch(API,{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({title})});
 loadTasks();
}

loadTasks();
