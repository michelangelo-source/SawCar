async function getList(url){
  const res =await fetch(url,{
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
     option.autofocus=true
     option.innerHTML="..."
     select.appendChild(option)
    res.forEach(element => {
      option=document.createElement("option")
      option.value=element.id
      option.innerHTML=element.model
      select.appendChild(option)
    });

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
    method: "POST", 
    mode: "cors", 
    cache: "no-cache",
    credentials: "same-origin", 
    headers: {
      "Authorization":sessionStorage.getItem("token") 
    },
    redirect: "follow", 
    referrerPolicy: "no-referrer", 
    body:formData
   })
}


 


 