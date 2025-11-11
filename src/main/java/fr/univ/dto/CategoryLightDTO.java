package fr.univ.dto;

import java.time.Instant;

/**
 * DTO pour Category avec projection légère
 */
public class CategoryLightDTO {
    private Long id;
    private String code;
    private String name;
    private Instant updatedAt;

    public CategoryLightDTO() {}

    public CategoryLightDTO(Long id, String code, String name, Instant updatedAt) {
        this.id = id;
        this.code = code;
        this.name = name;
        this.updatedAt = updatedAt;
    }

    // getters/setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getCode() { return code; }
    public void setCode(String code) { this.code = code; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public Instant getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Instant updatedAt) { this.updatedAt = updatedAt; }
}

