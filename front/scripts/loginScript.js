

async function postData(){
    const res =await fetch("http://localhost:8080/users/notoken/login",{
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
     body: JSON.stringify(loginData), // body data type must match "Content-Type" header
   })
   return res.json();
   }

   function loginFun(){
    loginData={
        "email":document.getElementById("inputEmail").value,
        "password":document.getElementById("inputPassword").value
      }
      postData().then((data)=>{
      console.log(data)
      ciasto="Bearer "+data.token

      document.cookie =ciasto
      console.log(data.token)
      });



    console.log(document.getElementById("inputEmail").value)
    console.log(document.getElementById("inputPassword").value)
}