package com.sawcar.sawcarback.seen;

import com.sawcar.sawcarback.cars.Car;
import com.sawcar.sawcarback.user.UserRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor
public class FollowService {
    UserRepository userRepository;
    FollowRepository followRepository;
    public void follow(FollowRequest followRequest) {
        Follow follow= new Follow(userRepository.getUserId(followRequest.getUser()),userRepository.getUserId(followRequest.getFollowedUser()));
        followRepository.save(follow);
    }
    public void unfollow(FollowRequest followRequest) {
        followRepository.unfollow(userRepository.getUserId(followRequest.getUser()),userRepository.getUserId(followRequest.getFollowedUser()));
    }
    public long alreadyFollow(Follow follow){
       return followRepository.isAlreadyFollowed(follow.getUserId(),follow.getWhoUserFollowsId());
    }

    public void addCar(Car car) {
        System.out.println(car.getBrand()+" "+car.getModel()+" "+car.getGeneration()+" "+car.getStart_year()+" "+car.getEnd_year());
        followRepository.addcar(car.getBrand(), car.getModel(), car.getGeneration(),car.getStart_year(),car.getEnd_year());
    }
}
