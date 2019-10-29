package com.dhu.pojo;

import javax.persistence.*;

@Entity
@Table(name = "detail_list_purchase", schema = "javaee")
@IdClass(DetailListPurchasePK.class)
public class DetailListPurchase {
    private int id;
    private int productId;
    private int quantity;
    private Double bid;
    private Purchase purchaseById;
    private Product productByProductId;

    @Id
    @Column(name = "id", nullable = false)
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Id
    @Column(name = "product_id", nullable = false)
    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    @Basic
    @Column(name = "quantity", nullable = false)
    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    @Basic
    @Column(name = "bid", nullable = true, precision = 0)
    public Double getBid() {
        return bid;
    }

    public void setBid(Double bid) {
        this.bid = bid;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        DetailListPurchase that = (DetailListPurchase) o;

        if (id != that.id) return false;
        if (productId != that.productId) return false;
        if (quantity != that.quantity) return false;
        if (bid != null ? !bid.equals(that.bid) : that.bid != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + productId;
        result = 31 * result + quantity;
        result = 31 * result + (bid != null ? bid.hashCode() : 0);
        return result;
    }

    @ManyToOne
    @JoinColumn(name = "id", referencedColumnName = "id", nullable = false,insertable = false,updatable = false)
    public Purchase getPurchaseById() {
        return purchaseById;
    }

    public void setPurchaseById(Purchase purchaseById) {
        this.purchaseById = purchaseById;
    }

    @ManyToOne
    @JoinColumn(name = "product_id", referencedColumnName = "id", nullable = false,insertable = false,updatable = false )
    public Product getProductByProductId() {
        return productByProductId;
    }

    public void setProductByProductId(Product productByProductId) {
        this.productByProductId = productByProductId;
    }
}
