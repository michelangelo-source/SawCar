package com.sawcar.sawcarback.login;


import com.sawcar.sawcarback.user.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping(path = "/login")
public class LoginController {
    private final LoginService loginService;
    @Autowired
    public LoginController(LoginService loginService){this.loginService=loginService;}
    @PostMapping
    @CrossOrigin
    public  void checkUser(@RequestBody User user){

    }
}


