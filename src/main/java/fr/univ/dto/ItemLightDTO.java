package fr.univ.dto;

import java.math.BigDecimal;
import java.time.Instant;

/**
 * DTO pour Item avec projection légère (sans category pour éviter les N+1)
 */
public class ItemLightDTO {
    private Long id;
    private String sku;
    private String name;
    private BigDecimal price;
    private Integer stock;
    private Instant updatedAt;

    public ItemLightDTO() {}

    public ItemLightDTO(Long id, String sku, String name, BigDecimal price, Integer stock, Instant updatedAt) {
        this.id = id;
        this.sku = sku;
        this.name = name;
        this.price = price;
        this.stock = stock;
        this.updatedAt = updatedAt;
    }

    // getters/setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getSku() { return sku; }
    public void setSku(String sku) { this.sku = sku; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }

    public Integer getStock() { return stock; }
    public void setStock(Integer stock) { this.stock = stock; }

    public Instant getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Instant updatedAt) { this.updatedAt = updatedAt; }
}

