package com.sawcar.sawcarback.seen;

import com.sawcar.sawcarback.user.User;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
@RestController
@RequestMapping(path = "/seen")
public class SeenController {
    @CrossOrigin
    @GetMapping
    public Car getSeen(){
        Car car =new Car("Ford","GT");
        return car;}
}
