package com.sawcar.sawcarback.user;

import jakarta.persistence.*;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;
import java.util.List;

@Entity
@Table(name = "users")
public class User implements UserDetails {
    @Id
    private long id;
    private String nickname;
    private String email;
    private String password;
    @Enumerated(EnumType.STRING)
    private Type type;
    private String name;
    private String surname;


    @Override
    public String getUsername() {
        return this.nickname;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return List.of(new SimpleGrantedAuthority(type.name()));
    }

    public User(String nickname, String email, String password, String name, String surname) {
        nickname = nickname;
        email = email;
        password = password;
        name = name;
        surname = surname;
    }

    public User(long id, String nickname, String email, String password, String type, String name, String surname) {
        id = id;
        nickname = nickname;
        email = email;
        password = password;
        type = type;
        name = name;
        surname = surname;
    }

    public User(long Id, String Nickname, String email, String password) {
        this.id = Id;
        this.nickname = Nickname;
        this.email = email;
        this.password = password;
    }

    public User() {
    }


    public void setName(String name) {
        name = name;
    }

    public void setSurname(String surname) {
        surname = surname;
    }


    public String getName() {
        return name;
    }

    public String getSurname() {
        return surname;
    }


    public long getId() {
        return id;
    }

    public String getNickname() {
        return nickname;
    }

    public String getEmail() {
        return email;
    }


    public String getPassword() {
        return password;
    }



    public void setId(long id) {
        id = id;
    }

    public void setNickname(String nickname) {
        nickname = nickname;
    }

    public void setEmail(String email) {
        email = email;
    }

    public void setPassword(String password) {
        password = password;
    }

    public void setType(String type) {
        type = type;
    }


}
