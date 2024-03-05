package com.sawcar.sawcarback.seen;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping(path = "/follow")
public class FollowController {
    private final FollowService followService;
@Autowired
    public FollowController(FollowService followService) {
        this.followService = followService;
    }

    @PostMapping
    @CrossOrigin
    public void followUser(@RequestBody Follow follow){
        followService.follow(follow);
    }
    @DeleteMapping("{UserId}/{UnFollowedUserid}")
    @CrossOrigin
    public void unfollow(){};
}
