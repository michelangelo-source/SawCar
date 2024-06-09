async function getList(url){
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


window.addEventListener("load", async () => {
    url="http://localhost:8080/seen/brand"
    options=await getList(url)
    option=document.createElement("option")
    option.autofocus=true
    option.innerHTML="..."
    document.getElementById("Brand").appendChild(option)
    options.forEach(element => {
      option=document.createElement("option")
      option.value=element.id
      option.innerHTML=element.brand
      document.getElementById("Brand").appendChild(option)
    });

  });
 


function choseBrand(){
  url="http://localhost:8080/seen/model/"+document.getElementById("Brand").value
  getList(url).then((res)=>{
    if(document.getElementById("Model")){
      document.getElementById("Model").remove()
    }
    if(document.getElementById("Generation")){
      document.getElementById("Generation").remove()
    }
    if(document.getElementById("addSeenBtn")){
      document.getElementById("addSeenBtn").remove()
    }
    select=document.createElement("select")
    select.name="Model"
    select.id="Model"
    select.addEventListener("change",choseModel)
    document.getElementById("content").appendChild(select)
    option=document.createElement("option")
    // option.disabled=true
     option.autofocus=true
     option.innerHTML="..."
     select.appendChild(option)
    res.forEach(element => {
      option=document.createElement("option")
      option.value=element.id
      option.innerHTML=element.model
      select.appendChild(option)
    });
    console.log(res)
  })

}
function choseModel(){
  url="http://localhost:8080/seen/generation/"+document.getElementById("Model").value
  getList(url).then((res)=>{
    if(document.getElementById("Generation")){
      document.getElementById("Generation").remove()
    }
    if(document.getElementById("addSeenBtn")){
      document.getElementById("addSeenBtn").remove()
    }
    select=document.createElement("select")
    select.name="Generation"
    select.id="Generation"
    select.addEventListener("change",choseGeneration)
    document.getElementById("content").appendChild(select)
    option=document.createElement("option")

     option.autofocus=true
     option.innerHTML="..."
     select.appendChild(option)
    res.forEach(element => {
      option=document.createElement("option")
      option.value=element.id
      option.innerHTML=element.generation
      select.appendChild(option)
    });
    console.log(res)
  })

}
function choseGeneration(){
  if(document.getElementById("addSeenBtn")){
    document.getElementById("addSeenBtn").remove()
  }
  btnDiv=document.createElement("div")
  btnDiv.id="addSeenBtn"
  btnDiv.classList.add("stdBtn")
  btnDiv.innerHTML="Dodaj"
  btnDiv.addEventListener("click",submit)
  document.getElementById("content").appendChild(btnDiv)
}







function addedPhoto(){
  document.getElementById("PreView").src=URL.createObjectURL(document.getElementById("carPhoto").files[0])
}
function submit(){
  const formData = new FormData();
  formData.append("file", document.getElementById("carPhoto").files[0]);
  formData.append("Text", document.getElementById("SeenDescription").value);
  formData.append("UserId", sessionStorage.getItem("id"));
  formData.append("BrandId", document.getElementById("Brand").value);
  formData.append("ModelId", document.getElementById("Model").value);
  formData.append("GenerationId", document.getElementById("Generation").value);
  addSeenPost(formData).then(()=>{
  window.location.replace("./mainPage.html")
  }).catch(()=>{
    alert("nie udalo sie dodac posta")
  })
}

async function addSeenPost(formData){
  const res =await fetch("http://localhost:8080/seen/addSeen",{
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
    body:formData
   })
}


 


 