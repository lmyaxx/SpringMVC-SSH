package com.dhu.pojo;

import javax.persistence.*;
import java.util.Collection;

@Entity
public class Product {
    private int id;
    private String name;
    private int supplierId;
    private Double bid;
    private Double price;
    private int quantity;
    private String unit;
    private int alertline;
    private String picId;
    private Collection<DetailListPurchase> detailListPurchasesById;
    private Collection<DetailListSale> detailListSalesById;
    private Supplier supplierBySupplierId;

    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "name", nullable = false, length = 50)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Basic
    @Column(name = "supplier_id", nullable = false)
    public int getSupplierId() {
        return supplierId;
    }

    public void setSupplierId(int supplierId) {
        this.supplierId = supplierId;
    }

    @Basic
    @Column(name = "bid", nullable = false, precision = 0)
    public Double getBid() {
        return bid;
    }

    public void setBid(Double bid) {
        this.bid = bid;
    }

    @Basic
    @Column(name = "price", nullable = false, precision = 0)
    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
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
    @Column(name = "unit", nullable = true, length = 8)
    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    @Basic
    @Column(name = "alertline", nullable = false)
    public int getAlertline() {
        return alertline;
    }

    public void setAlertline(int alertline) {
        this.alertline = alertline;
    }

    @Basic
    @Column(name = "pic_id", nullable = true, length = 50)
    public String getPicId() {
        return picId;
    }

    public void setPicId(String picId) {
        this.picId = picId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Product product = (Product) o;

        if (id != product.id) return false;
        if (supplierId != product.supplierId) return false;
        if (quantity != product.quantity) return false;
        if (alertline != product.alertline) return false;
        if (name != null ? !name.equals(product.name) : product.name != null) return false;
        if (bid != null ? !bid.equals(product.bid) : product.bid != null) return false;
        if (price != null ? !price.equals(product.price) : product.price != null) return false;
        if (unit != null ? !unit.equals(product.unit) : product.unit != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + supplierId;
        result = 31 * result + (bid != null ? bid.hashCode() : 0);
        result = 31 * result + (price != null ? price.hashCode() : 0);
        result = 31 * result + quantity;
        result = 31 * result + (unit != null ? unit.hashCode() : 0);
        result = 31 * result + alertline;
        return result;
    }

    @OneToMany(mappedBy = "productByProductId")
    public Collection<DetailListPurchase> getDetailListPurchasesById() {
        return detailListPurchasesById;
    }

    public void setDetailListPurchasesById(Collection<DetailListPurchase> detailListPurchasesById) {
        this.detailListPurchasesById = detailListPurchasesById;
    }

    @OneToMany(mappedBy = "productByProductId")
    public Collection<DetailListSale> getDetailListSalesById() {
        return detailListSalesById;
    }

    public void setDetailListSalesById(Collection<DetailListSale> detailListSalesById) {
        this.detailListSalesById = detailListSalesById;
    }

    @ManyToOne
    @JoinColumn(name = "supplier_id", referencedColumnName = "id", nullable = false,insertable = false,updatable = false)
    public Supplier getSupplierBySupplierId() {
        return supplierBySupplierId;
    }

    public void setSupplierBySupplierId(Supplier supplierBySupplierId) {
        this.supplierBySupplierId = supplierBySupplierId;
    }
}
