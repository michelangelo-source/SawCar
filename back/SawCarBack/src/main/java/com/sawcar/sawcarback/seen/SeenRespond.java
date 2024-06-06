package com.sawcar.sawcarback.seen;

import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;

import java.util.Date;
import java.util.Optional;

public class SeenRespond {
    private String text;
    private String nickname;
    private String carModel;
    private String carBrand;
    private int carGeneration;
    private Date date;
    private String imageUrl;

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getCarModel() {
        return carModel;
    }

    public void setCarModel(String carModel) {
        this.carModel = carModel;
    }

    public String getCarBrand() {
        return carBrand;
    }

    public void setCarBrand(String carBrand) {
        this.carBrand = carBrand;
    }

    public int getCarGeneration() {
        return carGeneration;
    }

    public void setCarGeneration(int carGeneration) {
        this.carGeneration = carGeneration;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }
}
