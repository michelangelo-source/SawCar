package com.sawcar.sawcarback.user;

import com.sawcar.sawcarback.security.AuthenticationResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
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
    public ResponseEntity<AuthenticationResponse>  addUser(@RequestBody RegisterRequest request){
        return ResponseEntity.ok(userService.addUser(request));
    }
    @PostMapping("/notoken/login")
    @CrossOrigin
    public ResponseEntity<AuthenticationResponse>  loginUser(@RequestBody LoginRequest request){
        return ResponseEntity.ok(userService.loginUser(request));
    }
}
