package com.sawcar.sawcarback.cars;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import java.time.Year;
@Entity
@Table(name="car_generation")
public class Generation {
    @Id
    private long id;
    private long brandId;
    private long modelId;

    private long generation;
    private Year start_year;
    private Year end_year;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getBrandId() {
        return brandId;
    }

    public void setBrandId(long brandId) {
        this.brandId = brandId;
    }

    public long getModelId() {
        return modelId;
    }

    public void setModelId(long modelId) {
        this.modelId = modelId;
    }

    public long getGeneration() {
        return generation;
    }

    public void setGeneration(long generation) {
        this.generation = generation;
    }

    public Year getStart_year() {
        return start_year;
    }

    public void setStart_year(Year start_year) {
        this.start_year = start_year;
    }

    public Year getEnd_year() {
        return end_year;
    }

    public void setEnd_year(Year end_year) {
        this.end_year = end_year;
    }
}
