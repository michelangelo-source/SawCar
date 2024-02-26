package com.sawcar.sawcarback.login;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

@Configuration
public class LoginConfig {
    private final LoginRepository loginRepository;

    public LoginConfig(LoginRepository loginRepository) {
        this.loginRepository = loginRepository;
    }

    @Bean
    public UserDetailsService userDetailsService() {
        return username -> loginRepository.findbyEmail(username).orElseThrow(()->new UsernameNotFoundException("Ni ma"));
    }
}


