package com.sawcar.sawcarback.seen;

import com.sawcar.sawcarback.cars.Brand;
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
}
