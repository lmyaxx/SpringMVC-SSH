package com.dhu.pojo;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.Collection;

@Entity
public class Purchase {
    private int id;
    private int warehouseKeeperId;
    private Integer buyerId;
    private Double totalPrice;
    private String state;
    private Timestamp releaseTime;
    private Timestamp submitTime;
    private Collection<DetailListPurchase> detailListPurchasesById;
    private Staff staffByWarehouseKeeperId;
    private Staff staffByBuyerId;

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
    @Column(name = "warehouse_keeper_id", nullable = false)
    public int getWarehouseKeeperId() {
        return warehouseKeeperId;
    }

    public void setWarehouseKeeperId(int warehouseKeeperId) {
        this.warehouseKeeperId = warehouseKeeperId;
    }

    @Basic
    @Column(name = "buyer_id", nullable = true)
    public Integer getBuyerId() {
        return buyerId;
    }

    public void setBuyerId(Integer buyerId) {
        this.buyerId = buyerId;
    }

    @Basic
    @Column(name = "total_price", nullable = true, precision = 0)
    public Double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(Double totalPrice) {
        this.totalPrice = totalPrice;
    }

    @Basic
    @Column(name = "state", nullable = true, length = 1)
    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    @Basic
    @Column(name = "release_time", nullable = false)
    public Timestamp getReleaseTime() {
        return releaseTime;
    }

    public void setReleaseTime(Timestamp releaseTime) {
        this.releaseTime = releaseTime;
    }

    @Basic
    @Column(name = "submit_time", nullable = true)
    public Timestamp getSubmitTime() {
        return submitTime;
    }

    public void setSubmitTime(Timestamp submitTime) {
        this.submitTime = submitTime;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Purchase purchase = (Purchase) o;

        if (id != purchase.id) return false;
        if (warehouseKeeperId != purchase.warehouseKeeperId) return false;
        if (buyerId != null ? !buyerId.equals(purchase.buyerId) : purchase.buyerId != null) return false;
        if (totalPrice != null ? !totalPrice.equals(purchase.totalPrice) : purchase.totalPrice != null) return false;
        if (state != null ? !state.equals(purchase.state) : purchase.state != null) return false;
        if (releaseTime != null ? !releaseTime.equals(purchase.releaseTime) : purchase.releaseTime != null)
            return false;
        if (submitTime != null ? !submitTime.equals(purchase.submitTime) : purchase.submitTime != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + warehouseKeeperId;
        result = 31 * result + (buyerId != null ? buyerId.hashCode() : 0);
        result = 31 * result + (totalPrice != null ? totalPrice.hashCode() : 0);
        result = 31 * result + (state != null ? state.hashCode() : 0);
        result = 31 * result + (releaseTime != null ? releaseTime.hashCode() : 0);
        result = 31 * result + (submitTime != null ? submitTime.hashCode() : 0);
        return result;
    }

    @OneToMany(mappedBy = "purchaseById")
    public Collection<DetailListPurchase> getDetailListPurchasesById() {
        return detailListPurchasesById;
    }

    public void setDetailListPurchasesById(Collection<DetailListPurchase> detailListPurchasesById) {
        this.detailListPurchasesById = detailListPurchasesById;
    }

    @ManyToOne
    @JoinColumn(name = "warehouse_keeper_id", referencedColumnName = "id", nullable = false,insertable = false,updatable = false)
    public Staff getStaffByWarehouseKeeperId() {
        return staffByWarehouseKeeperId;
    }

    public void setStaffByWarehouseKeeperId(Staff staffByWarehouseKeeperId) {
        this.staffByWarehouseKeeperId = staffByWarehouseKeeperId;
    }

    @ManyToOne
    @JoinColumn(name = "buyer_id", referencedColumnName = "id",insertable = false,updatable = false)
    public Staff getStaffByBuyerId() {
        return staffByBuyerId;
    }

    public void setStaffByBuyerId(Staff staffByBuyerId) {
        this.staffByBuyerId = staffByBuyerId;
    }
}
