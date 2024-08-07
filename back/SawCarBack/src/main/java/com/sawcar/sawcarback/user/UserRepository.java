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
    @Query("SELECT u FROM User u WHERE u.canBeFound=true and u.nickname=?1")
    Optional<User> CanBeFollow(String name);
    @Query("SELECT u.id FROM User u WHERE u.nickname=?1")
    Long getUserId(String nickname);
    @Query("SELECT u.nickname FROM User u WHERE u.id=?1")
    String getUserNicknameById(long id);
}

