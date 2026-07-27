async function send(path){
 const username=document.getElementById('username').value;
 const password=document.getElementById('password').value;
 const r=await fetch('/auth/'+path,{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({username,password})});
 alert(await r.text());
}
function login(){send('login')}
function register(){send('register')}
