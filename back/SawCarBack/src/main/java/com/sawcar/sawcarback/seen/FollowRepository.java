package com.sawcar.sawcarback.seen;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface FollowRepository extends JpaRepository<Follow,Long> {
@Query("SELECT count(f.id) FROM Follow f WHERE f.UserId=?1 and f.WhoUserFollowsId=?2 ")
    long isAlreadyFollowed(long userId, long FollowedUser);
}
