function createFollowDiv(data){
  followDiv=document.createElement("div")
  followDiv.id="followDiv"


  nicknameDiv=document.createElement("div")
  nicknameDiv.innerText=data.nickname
  nicknameDiv.id="nicknameDiv"



followBtn=document.createElement("button")
followBtn.classList.add("stdBtn")

if(data.alreadyFollow){
  followBtn.innerText="Przestan obserwowac"
  followBtn.addEventListener("click",unfollow)

}else{
  followBtn.innerText="obserwuj"
  followBtn.addEventListener("click",follow)
}



followDiv.appendChild(nicknameDiv)
followDiv.appendChild(followBtn)
document.getElementById("content").innerHTML=""
document.getElementById("content").appendChild(followDiv)
}

async function followRequest(followData){
  const res =await fetch("http://localhost:8080/follow",{
   method: "POST", // *GET, POST, PUT, DELETE, etc.
   mode: "cors", // no-cors, *cors, same-origin
   cache: "no-cache", // *default, no-cache, reload, force-cache, only-if-cached
   credentials: "same-origin", // include, *same-origin, omit
   headers: {
     "Authorization":sessionStorage.getItem("token"), //////////////
     "Content-Type": "application/json",
   },
   redirect: "follow", // manual, *follow, error
   referrerPolicy: "no-referrer", // no-referrer, *no-referrer-when-downgrade, origin, origin-when-cross-origin, same-origin, strict-origin, strict-origin-when-cross-origin, unsafe-url
   body: JSON.stringify(followData)
  })
 }


 async function unfollowRequest(followData){
  const res =await fetch("http://localhost:8080/follow/"+sessionStorage.getItem("nickname")+"/"+document.getElementById("nicknameDiv").innerText,{
   method: "DELETE", // *GET, POST, PUT, DELETE, etc.
   mode: "cors", // no-cors, *cors, same-origin
   cache: "no-cache", // *default, no-cache, reload, force-cache, only-if-cached
   credentials: "same-origin", // include, *same-origin, omit
   headers: {
     "Authorization":sessionStorage.getItem("token"), //////////////

   },
   redirect: "follow", // manual, *follow, error
   referrerPolicy: "no-referrer", // no-referrer, *no-referrer-when-downgrade, origin, origin-when-cross-origin, same-origin, strict-origin, strict-origin-when-cross-origin, unsafe-url
  })
 }

function follow(){
  followData= {
    "user":sessionStorage.getItem("nickname"),
    "followedUser":document.getElementById("nicknameDiv").innerText
  }
  followRequest(followData).then(()=>{
    data={alreadyFollow:true,nickname:document.getElementById("nicknameDiv").innerText}
    createFollowDiv(data)
  })
  
}

function unfollow(){
  unfollowRequest().then(()=>{
    data={alreadyFollow:false,nickname:document.getElementById("nicknameDiv").innerText}
    createFollowDiv(data)
  })
}

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
    
      createFollowDiv(data)
    
  }).catch(()=>{
    alert("Nie ma takiego uzytkownika")

  });
}




async function destroyToken(){
  const res =await fetch("http://localhost:8080/token/"+sessionStorage.getItem("nickname"),{
   method: "DELETE", // *GET, POST, PUT, DELETE, etc.
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
 }
function logout(){
  
  destroyToken().then(()=>{
    window.location.replace("./index.html");
  })
  
}





async function renewSession(){
  const res =await fetch("http://localhost:8080/token",{
   method: "POST", // *GET, POST, PUT, DELETE, etc.
   mode: "cors", // no-cors, *cors, same-origin
   cache: "no-cache", // *default, no-cache, reload, force-cache, only-if-cached
   credentials: "same-origin", // include, *same-origin, omit
   headers: {
     "Authorization":sessionStorage.getItem("token") //////////////
     // 'Content-Type': 'application/x-www-form-urlencoded',
   },
   redirect: "follow", // manual, *follow, error
   referrerPolicy: "no-referrer", // no-referrer, *no-referrer-when-downgrade, origin, origin-when-cross-origin, same-origin, strict-origin, strict-origin-when-cross-origin, unsafe-url
   body: sessionStorage.getItem("nickname")
  })
  return res.json();
 }
function renewToken(){
  renewSession().then((data)=>{
    tokenFull="Bearer "+data.token
      sessionStorage.setItem("token",tokenFull);
  })
  
}
function moderatorPage(){
  window.location.replace("./moderatorPage.html");
}