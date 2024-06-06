package com.sawcar.sawcarback.seen;

import com.sawcar.sawcarback.cars.Brand;
import com.sawcar.sawcarback.cars.Generation;
import com.sawcar.sawcarback.cars.Model;
import org.springframework.stereotype.Service;

import java.util.Date;
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

    public void saveSeen(long userid, String seenTxt, String filename, long brandId, long modelId, long generationId) {
        Seen seen =new Seen(userid, seenTxt, filename, new Date(), brandId,  modelId,  generationId);
        seenRepository.save(seen);
    }
}
