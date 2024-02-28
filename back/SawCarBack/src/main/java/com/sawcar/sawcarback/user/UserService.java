package com.sawcar.sawcarback.user;

import com.sawcar.sawcarback.security.AuthenticationResponse;
import com.sawcar.sawcarback.security.JWTService;
import lombok.AllArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

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

    public AuthenticationResponse addUser(RegisterRequest request) {
        var user = User.builder()
                .nickname(request.getNickname())
                .name(request.getName())
                .surname(request.getSurname())
                .password(passwordEncoder.encode(request.getPassword()))
                .email(request.getEmail())
                .type(Type.USER)
                .build();
        userRepository.save(user);
        var jwtToken = jwtService.generateToken(user);
        System.out.println(jwtToken);
        return AuthenticationResponse.builder().token(jwtToken).build();
    }

    public AuthenticationResponse loginUser(LoginRequest request) {
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        request.getEmail(),
                        request.getPassword()
                )
        );
        var user = userRepository.findByEmail(request.getEmail()).orElseThrow();
        System.out.println(user.getAuthorities());
        var jwtToken = jwtService.generateToken(user);
        return AuthenticationResponse.builder().token(jwtToken).build();

    }
}
