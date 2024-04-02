async function getUser(url){
  const res =await fetch(url,{
   method: "GET", // *GET, POST, PUT, DELETE, etc.
   mode: "cors", // no-cors, *cors, same-origin
   cache: "no-cache", // *default, no-cache, reload, force-cache, only-if-cached
   credentials: "same-origin", // include, *same-origin, omit
   headers: {
     "Authorization":sessionStorage.getItem("token") //////////////
     // 'Content-Type': 'application/x-www-form-urlencoded',
   },
   redirect: "follow", // manual, *follow, error
   referrerPolicy: "no-referrer", // no-referrer, *no-referrer-when-downgrade, origin, origin-when-cross-origin, same-origin, strict-origin, strict-origin-when-cross-origin, unsafe-url
   
  })
 return res.json();
 }


    function find(){
      url="http://localhost:8080/users/"+document.getElementById("Nickname").value+"/"+sessionStorage.getItem("id")
  getUser(url).then((data)=>{
    console.log(data)
  }).catch(()=>{
    alert("Nie ma takiego uzytkownika")

  });
}
