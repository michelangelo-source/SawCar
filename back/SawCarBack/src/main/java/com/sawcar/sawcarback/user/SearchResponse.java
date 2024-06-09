package com.sawcar.sawcarback.user;

public class SearchResponse {
    private boolean alreadyFollow;
    private String nickname;

    public SearchResponse() {
    }

    public SearchResponse(boolean alreadyFollow, String nickname) {
        this.alreadyFollow = alreadyFollow;
        this.nickname = nickname;
    }

    public boolean isAlreadyFollow() {
        return alreadyFollow;
    }

    public void setAlreadyFollow(boolean alreadyFollow) {
        this.alreadyFollow = alreadyFollow;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }
}
