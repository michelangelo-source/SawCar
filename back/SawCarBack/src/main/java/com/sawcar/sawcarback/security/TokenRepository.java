package com.sawcar.sawcarback.security;


import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface TokenRepository extends JpaRepository<Token,Long> {
    @Modifying
    @Transactional
    @Query("UPDATE Token t  SET t.isActive = false WHERE t.userId=?1 and t.isActive=true ")
    void deactivateAll(Long id);
    @Query("SELECT t.isActive from Token t where t.token=?1")
    boolean isValid(String token);
}
