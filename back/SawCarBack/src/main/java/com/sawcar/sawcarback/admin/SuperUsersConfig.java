package com.sawcar.sawcarback.admin;

import com.sawcar.sawcarback.user.User;
import com.sawcar.sawcarback.user.UserRepository;
import lombok.AllArgsConstructor;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.password.PasswordEncoder;

import static com.sawcar.sawcarback.user.Type.ADMIN;
import static com.sawcar.sawcarback.user.Type.MODERATOR;

@AllArgsConstructor
public class SuperUsersConfig {
    private final PasswordEncoder passwordEncoder;
    private final UserRepository userRepository;

    @Bean
    public CommandLineRunner commandLineRunner() {
        return args -> {
            var admin = User.builder()
                    .nickname("admin")
                    .name("admin")
                    .surname("admin")
                    .password(passwordEncoder.encode("qq"))
                    .email("admin@sawcar.pl")
                    .type(ADMIN)
                    .build();

            var moderator = User.builder()
                    .nickname("moderator")
                    .name("moderator")
                    .surname("moderator")
                    .password(passwordEncoder.encode("qq"))
                    .email("moderator@sawcar.pl")
                    .type(MODERATOR)
                    .build();
            userRepository.save(admin);
            userRepository.save(moderator);
        };
    }
}
