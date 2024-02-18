package com.sawcar.sawcarback.user;

import jakarta.persistence.*;

@Entity
@Table(name = "users")
public class User {
    @Id
    private long Id;
    private String Nickname;
    private String Email;
    private String Password;

    private String Type;
    private String Name;
    private String Surname;

    public User(String nickname, String email, String password, String name, String surname) {
        Nickname = nickname;
        Email = email;
        Password = password;
        Name = name;
        Surname = surname;
    }

    public User(long id, String nickname, String email, String password, String type, String name, String surname) {
        Id = id;
        Nickname = nickname;
        Email = email;
        Password = password;
        Type = type;
        Name = name;
        Surname = surname;
    }

    public User(long Id, String Nickname, String email, String password, String type) {
        this.Id = Id;
        this.Nickname = Nickname;
        this.Email = email;
        this.Password = password;
        this.Type = type;
    }

    public User() {
    }


    public void setName(String name) {
        Name = name;
    }

    public void setSurname(String surname) {
        Surname = surname;
    }


    public String getName() {
        return Name;
    }

    public String getSurname() {
        return Surname;
    }


    public long getId() {
        return Id;
    }

    public String getNickname() {
        return Nickname;
    }

    public String getEmail() {
        return Email;
    }

    public String getPassword() {
        return Password;
    }

    public String getType() {
        return Type;
    }

    public void setId(long id) {
        Id = id;
    }

    public void setNickname(String nickname) {
        Nickname = nickname;
    }

    public void setEmail(String email) {
        Email = email;
    }

    public void setPassword(String password) {
        Password = password;
    }

    public void setType(String type) {
        Type = type;
    }


}
