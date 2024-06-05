package com.sawcar.sawcarback.seen;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

import java.nio.file.Path;
import java.util.Date;
@Entity
@AllArgsConstructor
@NoArgsConstructor
@Table(name="Seen")
public class Seen {
    @Id
    private long id;
    private long userId;
    private String text;
    private String path;
    private Date date;
    private long brandId;
    private long modelId;
    private long generationId;

}
