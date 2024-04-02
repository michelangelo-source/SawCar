package com.sawcar.sawcarback.security;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;


import java.util.Date;

@Entity
@Table(name="tokens")
public class Token {
    @Id
    private long Id;
    @Column(name = "userID")
    private long userId;
    private String token;
    private Date generate_date;
    private boolean isActive;

    public Token(long userId, String token, Date generate_date, boolean isActive) {
        this.userId = userId;
        this.token = token;
        this.generate_date = generate_date;
        this.isActive = isActive;
    }

    public Token() {

    }

    public long getUserId() {
        return userId;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public Date getGenerate_date() {
        return generate_date;
    }

    public void setGenerate_date(Date generate_date) {
        this.generate_date = generate_date;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }
}
