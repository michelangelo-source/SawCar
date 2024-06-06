package com.sawcar.sawcarback.seen;

import com.sawcar.sawcarback.cars.Brand;
import com.sawcar.sawcarback.cars.Car;
import com.sawcar.sawcarback.cars.Generation;
import com.sawcar.sawcarback.cars.Model;
import com.sawcar.sawcarback.storage.StorageService;
import com.sawcar.sawcarback.user.UserRepository;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
@Service
public class SeenService {
    private final SeenRepository seenRepository;
    private final UserRepository userRepository;
    private final StorageService storageService;

    public SeenService(SeenRepository seenRepository, UserRepository userRepository, StorageService storageService) {
        this.seenRepository = seenRepository;
        this.userRepository = userRepository;
        this.storageService = storageService;
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
    public void addCar(Car car) {
        System.out.println(car.getBrand()+" "+car.getModel()+" "+car.getGeneration()+" "+car.getStart_year()+" "+car.getEnd_year());
        seenRepository.addcar(car.getBrand(), car.getModel(), car.getGeneration(),car.getStart_year(),car.getEnd_year());
    }


    public List<SeenRespond> getSeens(long userId) {
        List<Seen>list =seenRepository.getSeensForUser(userId);
        List<SeenRespond> respondList= new ArrayList<>();
        for(Seen seen:list){
            SeenRespond respond=new SeenRespond();
            respond.setNickname(userRepository.getUserNicknameById(seen.getUserId()));
            respond.setCarBrand(seenRepository.getBrandById(seen.getBrandId()));
            respond.setCarModel(seenRepository.getModelByid(seen.getModelId()));
            respond.setCarGeneration(seenRepository.getGenerationById(seen.getGenerationId()));
            respond.setDate(seen.getDate());
            respond.setText(seen.getText());
            Resource file = storageService.loadAsResource(seen.getFilename());
            String imageUrl = "/seen/" + file.getFilename();
            respond.setImageUrl(imageUrl);
            respondList.add(respond);
        }
        System.out.println(respondList.get(0).getCarBrand());
        return respondList;
    }
}
