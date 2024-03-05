package com.sawcar.sawcarback.user;

import com.sawcar.sawcarback.security.JWTService;
import lombok.AllArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@AllArgsConstructor
public class UserService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final JWTService jwtService;
    private final AuthenticationManager authenticationManager;

    public List<User> getUsers() {
        return userRepository.findAll();
    }

    public void addUser(RegisterRequest request) {
        var user = User.builder()
                .nickname(request.getNickname())
                .name(request.getName())
                .surname(request.getSurname())
                .password(passwordEncoder.encode(request.getPassword()))
                .email(request.getEmail())
                .type(Type.USER)
                .canBeFound(true)
                .build();
        userRepository.save(user);

    }

    public LoginResponse loginUser(LoginRequest request) {

         var user= (User) userRepository.findByEmail(request.getEmail()).orElseThrow();
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        user.getUsername(),

                        request.getPassword()
                )
        );

        LoginResponse loginResponse=new LoginResponse();
        loginResponse.setToken(jwtService.generateToken(user));
        loginResponse.setNickname(user.getUsername());
        loginResponse.setEmial(user.getEmail());
        loginResponse.setId(user.getId());
        loginResponse.setCan_be_found(user.isCanBeFound());
        loginResponse.setSurname(user.getSurname());
        loginResponse.setName(user.getName());

        return loginResponse;
    }

    public Optional<User> findbyNickname(String name) {
        return userRepository.findByNickname(name);
    }

    public String canBeFollow(String name) {
        String nameFinal=userRepository.CanBeFollow(name);
        System.out.println(nameFinal);
        return  nameFinal;
    }
}
