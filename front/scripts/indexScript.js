token="Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTcwOTEzMzM3MywiZXhwIjoxNzA5MTM0ODEzfQ.CSM6jKD_Nb8HAW1uS2bsxUE2VXax45UJ3z55wqiqlcw"
async function getData(){
    const res =await fetch("http://localhost:8080/seen",{
     method: "GET", // *GET, POST, PUT, DELETE, etc.
     mode: "cors", // no-cors, *cors, same-origin
     cache: "no-cache", // *default, no-cache, reload, force-cache, only-if-cached
     credentials: "same-origin", // include, *same-origin, omit
     headers: {
       "Authorization":document.cookie //////////////
       // 'Content-Type': 'application/x-www-form-urlencoded',
     },
     redirect: "follow", // manual, *follow, error
     referrerPolicy: "no-referrer", // no-referrer, *no-referrer-when-downgrade, origin, origin-when-cross-origin, same-origin, strict-origin, strict-origin-when-cross-origin, unsafe-url
   })
   return res.json();
   }
   async function getAdminData(){
    const res =await fetch("http://localhost:8080/admin/users",{
     method: "GET", // *GET, POST, PUT, DELETE, etc.
     mode: "cors", // no-cors, *cors, same-origin
     cache: "no-cache", // *default, no-cache, reload, force-cache, only-if-cached
     credentials: "same-origin", // include, *same-origin, omit
     headers: {
       "Authorization": document.cookie//////////////
       // 'Content-Type': 'application/x-www-form-urlencoded',
     },
     redirect: "follow", // manual, *follow, error
     referrerPolicy: "no-referrer", // no-referrer, *no-referrer-when-downgrade, origin, origin-when-cross-origin, same-origin, strict-origin, strict-origin-when-cross-origin, unsafe-url
   })
   return res.json();
   }
   function test(){
          getData().then((data)=>{
      console.log(data)
      });
    }
    function test2(){
      getAdminData().then((data)=>{
  console.log(data)
  });
}
function ciastko(){
  console.log(document.cookie)
}
