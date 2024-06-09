package com.sawcar.sawcarback.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

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
    public SearchResponse CanBefFollow(@PathVariable("name")String name, @PathVariable("userid") long id ){
        return userService.canBeFollow(name,id);
    }
}
