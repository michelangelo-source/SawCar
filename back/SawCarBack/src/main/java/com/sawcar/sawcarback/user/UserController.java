package com.sawcar.sawcarback.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping(path = "/users")
public class UserController {
    private final UserService userService;
    @Autowired
    public UserController(UserService userService) {
        this.userService = userService;
    }
    @CrossOrigin
    @GetMapping
    public List<User> getUsers(  ){
        return userService.getUsers();}
    @PostMapping
    public void addUser(@RequestBody User user){
        userService.addUser(user);
    }
}
