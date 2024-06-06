package com.sawcar.sawcarback.storage;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Configuration
public class StorageProperties {


    private String location = "C:\\Users\\gacek\\Desktop\\SawCar\\SawCar\\back\\SawCarBack\\src\\usersPhotos";

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

}