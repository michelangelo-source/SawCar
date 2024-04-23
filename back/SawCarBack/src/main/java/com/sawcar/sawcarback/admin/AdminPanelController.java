package com.sawcar.sawcarback.admin;

import com.sawcar.sawcarback.user.User;
import com.sawcar.sawcarback.user.UserService;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@AllArgsConstructor
@RestController
@PreAuthorize("hasRole('ADMIN')")
@RequestMapping(path = "/admin")
public class AdminPanelController {
    private final UserService userService;
    @CrossOrigin
    @GetMapping("/users")
    @PreAuthorize("hasAuthority('admin:read')")
    public List<User> getUsers(){
        return userService.getUsers();
    }
}
