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
    public String renewToken(@RequestBody String token){
        return jwtService.renewToken(token);
    }
    @DeleteMapping("{nickname}")
    @CrossOrigin
    public void deactiveToken(@PathVariable("nickname")String nickname){
        jwtService.deactivateTokens(nickname);
    }
}
