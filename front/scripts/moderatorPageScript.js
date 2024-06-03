async function addCarFetch(carData){
    const res =await fetch("http://localhost:8080/follow/addCar",{
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
  console.log("dodano")
  console.log(carData)
  })

}