package com.sawcar.sawcarback.seen;

import com.sawcar.sawcarback.cars.Brand;
import com.sawcar.sawcarback.cars.Generation;
import com.sawcar.sawcarback.cars.Model;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

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
    @GetMapping("/model/{brandId}")
    @CrossOrigin
    public List<Model> getModels(@PathVariable("brandId")long brandId){
        return seenService.getModels(brandId);
    }
    @GetMapping("/generation/{modelId}")
    @CrossOrigin
    public List<Generation> getGenerations(@PathVariable("modelId")long modelId){
        return seenService.getGenerations(modelId);
    }


}
