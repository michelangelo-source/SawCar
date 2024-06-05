package com.sawcar.sawcarback.moderator;

import com.sawcar.sawcarback.cars.Car;
import com.sawcar.sawcarback.seen.FollowService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

@RestController
@PreAuthorize("hasRole('MODERATOR')")
@RequestMapping(path = "/moderator")
public class ModeratorController {
    private final FollowService followService;

    public ModeratorController(FollowService followService) {
        this.followService = followService;
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
        followService.addCar(car);
    }
}
