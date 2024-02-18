package com.sawcar.sawcarback.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UserService {
    private final UserRepository userRepository;
    @Autowired
    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public List<User> getUsers(){
        return userRepository.findAll();
    }
    public void addUser(User user){
        System.out.println("user");
        System.out.println(user.getEmail());
        System.out.println(user.getNickname());
        System.out.println("After");
        Optional<User>userIsAdded= userRepository.findByEmailAndNickname(user.getEmail(),user.getNickname());
        if(userIsAdded.isPresent()){
            throw new IllegalStateException("email or nickname taken");
        }
        userRepository.save(user);
        System.out.println(user);
    }
}
