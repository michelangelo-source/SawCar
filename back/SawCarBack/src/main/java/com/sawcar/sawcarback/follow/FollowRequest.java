package com.sawcar.sawcarback.follow;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class FollowRequest {
    private long id;
    private String user;
    private String followedUser;


    public FollowRequest(String user, String followedUser) {
        this.user = user;
        this.followedUser = followedUser;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public String getFollowedUser() {
        return followedUser;
    }

    public void setFollowedUser(String followedUser) {
        this.followedUser = followedUser;
    }
}
