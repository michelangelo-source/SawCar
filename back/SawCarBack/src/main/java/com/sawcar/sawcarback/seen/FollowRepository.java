package com.sawcar.sawcarback.seen;

import com.sawcar.sawcarback.cars.Car;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.stereotype.Repository;

@Repository
public interface FollowRepository extends JpaRepository<Follow,Long> {
@Query("SELECT count(f.id) FROM Follow f WHERE f.UserId=?1 and f.WhoUserFollowsId=?2 ")
    long isAlreadyFollowed(long userId, long FollowedUser);
    @Modifying
    @Transactional
@Query("DELETE FROM Follow f WHERE f.UserId=?1 and f.WhoUserFollowsId=?2")
    void unfollow(long userid,long unfolloweduser);
    @Procedure(procedureName = "SPAddCar")
    void addcar(String brand,String model,int generaion,int start_year,int end_year);


}
