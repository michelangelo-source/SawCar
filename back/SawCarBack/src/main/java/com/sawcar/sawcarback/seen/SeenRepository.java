package com.sawcar.sawcarback.seen;

import com.sawcar.sawcarback.cars.Brand;
import com.sawcar.sawcarback.cars.Generation;
import com.sawcar.sawcarback.cars.Model;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SeenRepository extends JpaRepository<Seen,Long> {

    @Query("SELECT b from Brand b")
    List<Brand> getBrands();

    @Query("SELECT m from Model m where m.brandId=?1")
    List<Model> getModels(long brandId);
    @Query("SELECT g from Generation  g where g.modelId=?1")
    List<Generation> getGenerations(long modelId);

    @Procedure(procedureName = "SPAddCar")
    void addcar(String brand,String model,int generation,int start_year,int end_year);
    @Query("SELECT g.generation from Generation  g where g.id=?1")
    int getGenerationById(long generationId);
    @Query("SELECT m.Model from Model  m where m.id=?1")
    String getModelByid(long modelId);
    @Query("SELECT b.brand from Brand  b where b.id=?1")
    String getBrandById(long brandId);
    @Query("SELECT s FROM Seen s,Follow f WHERE s.userId =f.WhoUserFollowsId and f.UserId=?1")
    List<Seen> getSeensForUser(long userId);
}
