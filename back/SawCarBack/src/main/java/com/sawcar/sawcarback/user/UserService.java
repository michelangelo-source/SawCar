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
    public RegisterInfo addUser(User user){
        RegisterInfo registerInfo = new RegisterInfo();
        //haszowanie hasła tutaj dorobic!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        Optional<User>userIsAdded= userRepository.findByEmailAndNickname(user.getEmail(),user.getNickname());
        if(userIsAdded.isPresent()){
            registerInfo.setAdded(false);
            registerInfo.setComment("email or nickname taken");
            return registerInfo;
        }
        userRepository.save(user);
        registerInfo.setAdded(true);
        registerInfo.setComment("succeed");
        return registerInfo;
    }
}
