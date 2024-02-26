package com.sawcar.sawcarback.login;

import com.sawcar.sawcarback.user.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface LoginRepository extends JpaRepository<User, Long> {
Optional<User> findbyEmail(String email);
}
