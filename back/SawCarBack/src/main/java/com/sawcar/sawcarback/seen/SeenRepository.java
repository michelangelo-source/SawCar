package com.sawcar.sawcarback.seen;

import com.sawcar.sawcarback.cars.Brand;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SeenRepository extends JpaRepository<Seen,Long> {
    @Transactional
    @Query("SELECT c from Brand c")
    List<Brand> getBrands();


}
