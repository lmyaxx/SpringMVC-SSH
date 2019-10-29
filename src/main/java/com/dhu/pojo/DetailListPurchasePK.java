package com.dhu.pojo;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;

public class DetailListPurchasePK implements Serializable {
    private int id;
    private int productId;

    @Column(name = "id", nullable = false)
    @Id
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Column(name = "product_id", nullable = false)
    @Id
    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        DetailListPurchasePK that = (DetailListPurchasePK) o;

        if (id != that.id) return false;
        if (productId != that.productId) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + productId;
        return result;
    }
}
