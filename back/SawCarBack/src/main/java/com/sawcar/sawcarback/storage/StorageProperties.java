package com.sawcar.sawcarback.storage;


import org.springframework.context.annotation.Configuration;



@Configuration
public class StorageProperties {


   private String location = "src\\usersPhotos";


    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

}