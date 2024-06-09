package com.sawcar.sawcarback.storage;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

import java.nio.file.Paths;

@Configuration
public class StorageProperties {


   private String location = "SawCarBack\\src\\usersPhotos";


    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

}