package com.sawcar.sawcarback.seen;

import com.sawcar.sawcarback.cars.Brand;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping(path = "/seen")
public class SeenController {
    private final SeenService seenService;
    @Autowired
    public SeenController(SeenService seenService) {
        this.seenService = seenService;
    }
    @GetMapping("/brand")
    @CrossOrigin
    public List<Brand> getBrands(){

     return seenService.getBrands();
    }


}
