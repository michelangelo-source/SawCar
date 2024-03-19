package com.sawcar.sawcarback.seen;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor
public class FollowService {
    FollowRepository followRepository;
    public void follow(Follow follow) {
        followRepository.save(follow);
    }
    public long alreadyFollow(Follow follow){
       return followRepository.isAlreadyFollowed(follow.getUserId(),follow.getWhoUserFollowsId());
    }
}
