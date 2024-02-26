package com.sawcar.sawcarback.seen;

public class Car {
    private String model;
    private String marka;

    public Car(String model, String marka) {
        this.model = model;
        this.marka = marka;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public void setMarka(String marka) {
        this.marka = marka;
    }

    public String getModel() {
        return model;
    }

    public String getMarka() {
        return marka;
    }
}
