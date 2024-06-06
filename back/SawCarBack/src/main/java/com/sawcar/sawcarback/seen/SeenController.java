package com.sawcar.sawcarback.seen;

import com.sawcar.sawcarback.cars.Brand;
import com.sawcar.sawcarback.cars.Generation;
import com.sawcar.sawcarback.cars.Model;
import com.sawcar.sawcarback.storage.StorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;


import java.util.List;

@RestController
@RequestMapping(path = "/seen")
public class SeenController {
    private static int photoCounter=0;
    private final StorageService storageService;
     private final SeenService seenService;
    @Autowired
    public SeenController(StorageService storageService, SeenService seenService) {
        this.storageService = storageService;
        this.seenService = seenService;
    }
    @GetMapping("/{filename}")
    @CrossOrigin
    public ResponseEntity<Resource> getFile(@PathVariable String filename) {
        Resource file = storageService.loadAsResource(filename);
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + file.getFilename() + "\"")
                .body(file);
    }
    @GetMapping("/getSeen/{user_id}")
    @CrossOrigin
    public List<SeenRespond> getSeens(@PathVariable("user_id")long userId){
        return seenService.getSeens(userId);
    }

    @PostMapping("/addSeen")
    @CrossOrigin
    public void addSeen(@RequestParam("file") MultipartFile file,
                        @RequestParam("Text")String seenTxt,
                        @RequestParam("UserId")long userid,
                        @RequestParam("BrandId")long brandId,
                        @RequestParam("ModelId")long modelId,
                        @RequestParam("GenerationId")long generationId){

        photoCounter++;
        String[] extension=file.getOriginalFilename().split("\\.");
        String filename=photoCounter+"."+ extension[1];
        storageService.store(file, filename);
        seenService.saveSeen(userid,seenTxt,filename,brandId,modelId,generationId);

    }
    @GetMapping("/brand")
    @CrossOrigin
    public List<Brand> getBrands(){

     return seenService.getBrands();
    }

    @GetMapping("/model/{brandId}")
    @CrossOrigin
    public List<Model> getModels(@PathVariable("brandId")long brandId){
        return seenService.getModels(brandId);
    }
    @GetMapping("/generation/{modelId}")
    @CrossOrigin
    public List<Generation> getGenerations(@PathVariable("modelId")long modelId){
        return seenService.getGenerations(modelId);
    }


}
