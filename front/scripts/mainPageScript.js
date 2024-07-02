window.addEventListener("load", async () => {
  await getSeens().then(async res=>{

    document.getElementById("content").appendChild(document.createElement("br"))
   for(i=res.length-1;i>=0;i--){
   seenDiv=document.createElement("div")
   seenDiv.classList.add("seen")
   seenDiv.innerText=res[i].carBrand+" "+res[i].carModel+" "+res[i].carGeneration+"\n"+res[i].nickname+"\n"+res[i].date.substr(0,10)+"\n"+res[i].text
  
   seenDiv.appendChild(document.createElement("br"))
   photo=document.createElement("img")
    await getPhoto(res[i].imageUrl).then((response) => {
      const reader = response.body.getReader();
      return new ReadableStream({
        start(controller) {
          return pump();
          function pump() {
            return reader.read().then(({ done, value }) => {
              if (done) {
                controller.close();
                return;
              }
              controller.enqueue(value);
              return pump();
            });
          }
        },
      });
    })
    .then((stream) => new Response(stream))
    .then((response) => response.blob())
    .then((blob) => URL.createObjectURL(blob))
    .then((url) => {photo.src=url})
    .catch((err) => console.error(err));
   seenDiv.appendChild(photo) 
   seenDiv.appendChild(document.createElement("br"))
   document.getElementById("content").appendChild(seenDiv) 
   document.getElementById("content").appendChild(document.createElement("br"))
  }
  })
  

  
  result= await moderatorPageAccess()
  if(result.access){
    moderDiv=document.createElement("div")
    moderDiv.id="moderPage"
    moderDiv.innerHTML="StronaModera"
    moderDiv.addEventListener("click",moderatorPage)
    document.getElementById("footer").appendChild(moderDiv)
  }


});
async function getPhoto(url){
  const res =await fetch("http://localhost:8080"+url,{
    method: "GET", 
    mode: "cors", 
    cache: "no-cache", 
    credentials: "same-origin", 
    headers: {
      "Authorization":sessionStorage.getItem("token") 

    },
    redirect: "follow", 
    referrerPolicy: "no-referrer", 
    
   })
  return res;
}


async function getSeens(){
  const res =await fetch("http://localhost:8080/seen/getSeen/"+sessionStorage.getItem("id"),{
    method: "GET", 
    mode: "cors", 
    cache: "no-cache", 
    credentials: "same-origin", 
    headers: {
      "Authorization":sessionStorage.getItem("token") 

    },
    redirect: "follow", 
    referrerPolicy: "no-referrer", 
    
   })
  return res.json();
}

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
   method: "POST", 
   mode: "cors", 
   cache: "no-cache", 
   credentials: "same-origin", 
   headers: {
     "Authorization":sessionStorage.getItem("token"), 
     "Content-Type": "application/json",
   },
   redirect: "follow", 
   referrerPolicy: "no-referrer", 
   body: JSON.stringify(followData)
  })
 }


 async function unfollowRequest(followData){
  const res =await fetch("http://localhost:8080/follow/"+sessionStorage.getItem("nickname")+"/"+document.getElementById("nicknameDiv").innerText,{
   method: "DELETE", 
   mode: "cors", 
   cache: "no-cache", 
   credentials: "same-origin", 
   headers: {
     "Authorization":sessionStorage.getItem("token"), 

   },
   redirect: "follow", 
   referrerPolicy: "no-referrer", 
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
    location.reload()
  })
  
}

function unfollow(){
  unfollowRequest().then(()=>{
    data={alreadyFollow:false,nickname:document.getElementById("nicknameDiv").innerText}
    createFollowDiv(data)
    location.reload()
  })
}


async function getUser(url){
  const res =await fetch(url,{
   method: "GET", 
   mode: "cors", 
   cache: "no-cache", 
   credentials: "same-origin", 
   headers: {
     "Authorization":sessionStorage.getItem("token") 
     // 'Content-Type': 'application/x-www-form-urlencoded',
   },
   redirect: "follow", 
   referrerPolicy: "no-referrer", 
   
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
   method: "DELETE", 
   mode: "cors",
   cache: "no-cache", 
   credentials: "same-origin",
   headers: {
     "Authorization":sessionStorage.getItem("token") 

   },
   redirect: "follow", 
   referrerPolicy: "no-referrer", 
   
  })
 }
function logout(){
  
  destroyToken().then(()=>{
    window.location.replace("./index.html");
  })
  
}





async function renewSession(){
  const res =await fetch("http://localhost:8080/token",{
   method: "POST", 
   mode: "cors", 
   cache: "no-cache", 
   credentials: "same-origin", 
   headers: {
     "Authorization":sessionStorage.getItem("token") 

   },
   redirect: "follow", 
   referrerPolicy: "no-referrer", 
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


async function moderatorPageAccess(){
  const res =await fetch("http://localhost:8080/moderator/access",{
   method: "GET",
   mode: "cors", 
   cache: "no-cache", 
   credentials: "same-origin", 
   headers: {
     "Authorization":sessionStorage.getItem("token") 
   },
   redirect: "follow", 
   referrerPolicy: "no-referrer",
   
  })
 return res.json();
 }
 function moderatorPage(){
  moderatorPageAccess().then(()=>{
    window.location.replace("./moderatorPage.html");
    return true
  }).catch((err)=>{
    console.log(err)
    alert("Brak dostepu")
  })
 
}
function moderatorDiv(){
  moderatorPageAccess().then(()=>{
    return true
  }).catch(()=>{
   return false
  })
 
}



function addSeenPage(){
  window.location.replace("./addSeen.html");
}