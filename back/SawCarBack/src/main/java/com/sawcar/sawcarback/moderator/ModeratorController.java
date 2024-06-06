package com.sawcar.sawcarback.moderator;

import com.sawcar.sawcarback.cars.Car;
import com.sawcar.sawcarback.seen.SeenService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

@RestController
@PreAuthorize("hasRole('MODERATOR')")
@RequestMapping(path = "/moderator")
public class ModeratorController {
    private final SeenService seenService;

    public ModeratorController(SeenService seenService) {
        this.seenService = seenService;
    }
    @GetMapping("/access")
    @CrossOrigin
    @PreAuthorize("hasAuthority('moderator:read')")
    public String access(){
        return "{\"access\":\"granted\"}";
    };
    @PostMapping("/addCar")
    @CrossOrigin
    @PreAuthorize("hasAuthority('moderator:create')")
    public void addCar(@RequestBody Car car){
       seenService.addCar(car);
    }
}
