
  
 async function postData(){
     await fetch("http://localhost:8080/users/notoken/register",{
      method: "POST", 
      mode: "cors", 
      cache: "no-cache", 
      credentials: "same-origin", 
      headers: {
        "Content-Type": "application/json",

      },
      redirect: "follow", 
      referrerPolicy: "no-referrer", 
      body: JSON.stringify(RegisterData), 
    })
    }



    function registerUser(){
      RegisterData={
        "name":document.getElementById("Name").value,
        "surname":document.getElementById("Surname").value,
        "nickname":document.getElementById("Nickname").value,
        "email":document.getElementById("Email").value,
        "password":document.getElementById("Password").value
      }
      postData().then(()=>{
        window.location.replace("./index.html")
      });
    }