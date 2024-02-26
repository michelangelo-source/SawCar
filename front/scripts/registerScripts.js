
  
 async function postData(){
     const res =await fetch("http://localhost:8080/users/notoken/register",{
      method: "POST", // *GET, POST, PUT, DELETE, etc.
      mode: "cors", // no-cors, *cors, same-origin
      cache: "no-cache", // *default, no-cache, reload, force-cache, only-if-cached
      credentials: "same-origin", // include, *same-origin, omit
      headers: {
        "Content-Type": "application/json",
        // 'Content-Type': 'application/x-www-form-urlencoded',
      },
      redirect: "follow", // manual, *follow, error
      referrerPolicy: "no-referrer", // no-referrer, *no-referrer-when-downgrade, origin, origin-when-cross-origin, same-origin, strict-origin, strict-origin-when-cross-origin, unsafe-url
      body: JSON.stringify(RegisterData), // body data type must match "Content-Type" header
    })
    return res.json();
    }



    function registerUser(){
      //walidacja danych
      RegisterData={
        "name":document.getElementById("Name").value,
        "surname":document.getElementById("Surname").value,
        "nickname":document.getElementById("Nickname").value,
        "email":document.getElementById("Email").value,
        "password":document.getElementById("Password").value
      }
      postData().then((data)=>{
      console.log(data)
      });
    }