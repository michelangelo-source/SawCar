package com.sawcar.sawcarback.user;

import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class UserConfig {
    @Bean
    CommandLineRunner commandLineRunner(UserRepository userRepository){
        return args -> {
            User Admin=new User(2,"Admin","Admin@sawcar.pl","qq","Administrator");
            userRepository.save(Admin);
        };
    }
}
