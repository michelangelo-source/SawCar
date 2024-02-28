package com.sawcar.sawcarback.user;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    @Query("SELECT u FROM User u WHERE u.nickname=?1")
    Optional<User> findByNickname(String nickname);

    @Query("SELECT u FROM User u WHERE u.email=?1")
    Optional<Object> findByEmail(String email);
}

