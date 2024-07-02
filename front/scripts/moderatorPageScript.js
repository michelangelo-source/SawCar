async function addCarFetch(carData){
    const res =await fetch("http://localhost:8080/moderator/addCar",{
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
     body: JSON.stringify(carData)
    })
   }


function addCar(){
    carData={
    brand:document.getElementById("brand").value,
    model:document.getElementById("model").value,
    generation:document.getElementById("generation").value,
    start_year:document.getElementById("start_year").value,
    end_year:document.getElementById("end_year").value
}
addCarFetch(carData).then(()=>{
  window.location.replace("./mainPage.html")
  })

}