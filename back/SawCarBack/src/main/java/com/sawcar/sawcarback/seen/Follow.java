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
    private long UserId;
    private long WhoUserFollowsId;
}
