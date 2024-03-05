package com.sawcar.sawcarback.user;

public class LoginResponse {
    private String token;
    private long id;
    private String emial;
    private String nickname;
    private String name;
    private String surname;
    private boolean can_be_found;

    public LoginResponse() {
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getEmial() {
        return emial;
    }

    public void setEmial(String emial) {
        this.emial = emial;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public boolean isCan_be_found() {
        return can_be_found;
    }

    public void setCan_be_found(boolean can_be_found) {
        this.can_be_found = can_be_found;
    }
}
