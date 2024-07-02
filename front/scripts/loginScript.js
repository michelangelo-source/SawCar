

async function postData(){
    const res =await fetch("http://localhost:8080/users/notoken/login",{
     method: "POST", 
     mode: "cors", 
     cache: "no-cache", 
     credentials: "same-origin", 
     headers: {
       "Content-Type": "application/json",
  
     },
     redirect: "follow", 
     referrerPolicy: "no-referrer",
     body: JSON.stringify(loginData), 
   })
   return res.json();
   }

   function loginFun(){
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
      window.location.replace("./mainPage.html");
      }).catch(()=>{
        alert("zle haslo lub login")
      });

}