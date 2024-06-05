package com.sawcar.sawcarback.seen;

import com.sawcar.sawcarback.cars.Brand;
import com.sawcar.sawcarback.cars.Generation;
import com.sawcar.sawcarback.cars.Model;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class SeenService {
    private final SeenRepository seenRepository;

    public SeenService(SeenRepository seenRepository) {
        this.seenRepository = seenRepository;
    }

    public List<Brand> getBrands(){
        return seenRepository.getBrands();
    };

    public List<Model> getModels(long brandId) {
        return  seenRepository.getModels(brandId);
    }

    public List<Generation> getGenerations(long modelId) {
        return seenRepository.getGenerations(modelId);
    }
}
