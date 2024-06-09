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
      console.log(res[i])
      const reader = response.body.getReader();
      return new ReadableStream({
        start(controller) {
          return pump();
          function pump() {
            return reader.read().then(({ done, value }) => {
              // When no more data needs to be consumed, close the stream
              if (done) {
                controller.close();
                return;
              }
              // Enqueue the next data chunk into our target stream
              controller.enqueue(value);
              return pump();
            });
          }
        },
      });
    })
    // Create a new response out of the stream
    .then((stream) => new Response(stream))
    // Create an object URL for the response
    .then((response) => response.blob())
    .then((blob) => URL.createObjectURL(blob))
    // Update image
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
  return res;
}


async function getSeens(){
  const res =await fetch("http://localhost:8080/seen/getSeen/"+sessionStorage.getItem("id"),{
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


async function moderatorPageAccess(){
  const res =await fetch("http://localhost:8080/moderator/access",{
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