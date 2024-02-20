package com.sawcar.sawcarback.user;

public class RegisterInfo {
    private boolean added;
    private String comment;

    public RegisterInfo(boolean added, String comment) {
        this.added = added;
        this.comment = comment;
    }

    public RegisterInfo() {
    }

    public boolean isAdded() {
        return added;
    }

    public String getComment() {
        return comment;
    }

    public void setAdded(boolean added) {
        this.added = added;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }
}
