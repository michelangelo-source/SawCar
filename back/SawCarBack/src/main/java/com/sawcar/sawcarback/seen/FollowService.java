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
}
