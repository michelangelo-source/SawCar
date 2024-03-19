package com.sawcar.sawcarback.user;

import com.sawcar.sawcarback.security.AuthenticationResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequestMapping(path = "/users")
public class UserController {
    private final UserService userService;
    @Autowired
    public UserController(UserService userService) {
        this.userService = userService;
    }

    @PostMapping("/notoken/register")
    @CrossOrigin
    public void addUser(@RequestBody RegisterRequest request){
        userService.addUser(request);
    }
    @PostMapping("/notoken/login")
    @CrossOrigin
    public LoginResponse  loginUser(@RequestBody LoginRequest request){
        return userService.loginUser(request);
    }
    @GetMapping("{name}/{userid}")
    @CrossOrigin
    public SearchRespone CanBefFollow(@PathVariable("name")String name,@PathVariable("userid") long id ){
        return userService.canBeFollow(name,id);
    }
}
