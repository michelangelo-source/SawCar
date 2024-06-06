package com.sawcar.sawcarback.seen;

import jakarta.persistence.Column;
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
    private String filename;
    private Date date;
    private long brandId;
    private long modelId;
    private long generationId;

    public Seen(long userId, String text, String filename, Date date, long brandId, long modelId, long generationId) {
        this.userId = userId;
        this.text = text;
        this.filename = filename;
        this.date = date;
        this.brandId = brandId;
        this.modelId = modelId;
        this.generationId = generationId;
    }

    public long getUserId() {
        return userId;
    }

    public String getText() {
        return text;
    }

    public String getFilename() {
        return filename;
    }

    public Date getDate() {
        return date;
    }

    public long getBrandId() {
        return brandId;
    }

    public long getModelId() {
        return modelId;
    }

    public long getGenerationId() {
        return generationId;
    }
}
