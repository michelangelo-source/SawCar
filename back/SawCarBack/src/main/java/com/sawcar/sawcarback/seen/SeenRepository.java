package com.sawcar.sawcarback.seen;

import com.sawcar.sawcarback.cars.Brand;
import com.sawcar.sawcarback.cars.Generation;
import com.sawcar.sawcarback.cars.Model;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
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
}
