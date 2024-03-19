package com.sawcar.sawcarback.seen;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Table(name="Follows")
public class Follow {
    @Id
    private long id;
    @Column(name="UserID")
    private long UserId;
    @Column(name="FollowedUserdID")
    private long WhoUserFollowsId;

    public Follow(long userId, long whoUserFollowsId) {
        UserId = userId;
        WhoUserFollowsId = whoUserFollowsId;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getUserId() {
        return UserId;
    }

    public void setUserId(long userId) {
        UserId = userId;
    }

    public long getWhoUserFollowsId() {
        return WhoUserFollowsId;
    }

    public void setWhoUserFollowsId(long whoUserFollowsId) {
        WhoUserFollowsId = whoUserFollowsId;
    }


}
