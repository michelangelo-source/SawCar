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

    @PostMapping()
    @CrossOrigin
    public void followUser(@RequestBody FollowRequest followRequest){
       followService.follow(followRequest);
    }
    @DeleteMapping("{User}/{UnFollowedUser}")
    @CrossOrigin
    public void unfollow(@PathVariable("User")String user,@PathVariable("UnFollowedUser") String unfollwedUser){
        FollowRequest followRequest = new FollowRequest(user,unfollwedUser);
        followService.unfollow(followRequest);
    }
}
