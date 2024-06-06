package com.sawcar.sawcarback.security;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping(path = "/token")
public class TokenController {
    private final JWTService jwtService;
@Autowired
    public TokenController(JWTService jwtService) {
        this.jwtService = jwtService;
    }

    @PostMapping
    @CrossOrigin
    public String renewToken(@RequestBody String nickname){
        System.out.println(nickname);
        return jwtService.renewToken(nickname);
    }

    @DeleteMapping("{nickname}")
    @CrossOrigin
    public void deactivateToken(@PathVariable("nickname")String nickname){
        jwtService.deactivateTokens(nickname);
    }
}
