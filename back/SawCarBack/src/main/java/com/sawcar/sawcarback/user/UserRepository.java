package com.sawcar.sawcarback.user;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    @Query("SELECT u FROM User u WHERE u.Email=?1 or u.Nickname=?2")
    Optional<User>findByEmailAndNickname(String email,String nickname);
}
