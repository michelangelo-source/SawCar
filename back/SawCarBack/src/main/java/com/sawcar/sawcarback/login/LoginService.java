package com.sawcar.sawcarback.login;

import com.sawcar.sawcarback.user.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

@Service
public class LoginService {
    private final LoginRepository loginRepository;
    @Autowired
    LoginService(LoginRepository loginRepository){this.loginRepository=loginRepository;}

}
