

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
    //walidacja danych
    loginData={
        "email":document.getElementById("inputEmail").value,
        "password":document.getElementById("inputPassword").value
      }
      postData().then((data)=>{
      tokenFull="Bearer "+data.token
      sessionStorage.setItem("token",tokenFull);
      sessionStorage.setItem("id",data.id);
      sessionStorage.setItem("emial",data.emial);
      sessionStorage.setItem("nickname",data.nickname);
      sessionStorage.setItem("name",data.name);
      sessionStorage.setItem("surname",data.surname);
      sessionStorage.setItem("CBF",data.can_be_found);
      window.location.replace("http://127.0.0.1:5500/front/pages/mainPage.html");
      }).catch(()=>{
        alert("zle haslo lub login")
      });

}