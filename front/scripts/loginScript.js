
 function loginFun(){
    console.log(document.getElementById("inputEmail").value)
    console.log(document.getElementById("inputPassword").value)
    fetch("http://localhost:8080/users")
.then(res => res.json())
.then(data => console.log(data))
}
