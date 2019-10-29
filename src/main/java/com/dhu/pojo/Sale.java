package com.dhu.pojo;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.Collection;

@Entity
public class Sale {
    private int id;
    private Integer warehouseKeeperId;
    private int salerId;
    private int customerId;
    private double totalPrice;
    private String state;
    private Timestamp time;
    private Collection<DetailListSale> detailListSalesById;
    private Staff staffByWarehouseKeeperId;
    private Staff staffBySalerId;
    private Customer customerByCustomerId;

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
    @Column(name = "warehouse_keeper_id", nullable = true)
    public Integer getWarehouseKeeperId() {
        return warehouseKeeperId;
    }

    public void setWarehouseKeeperId(Integer warehouseKeeperId) {
        this.warehouseKeeperId = warehouseKeeperId;
    }

    @Basic
    @Column(name = "saler_id", nullable = false)
    public int getSalerId() {
        return salerId;
    }

    public void setSalerId(int salerId) {
        this.salerId = salerId;
    }

    @Basic
    @Column(name = "customer_id", nullable = false)
    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    @Basic
    @Column(name = "total_price", nullable = false, precision = 0)
    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    @Basic
    @Column(name = "state", nullable = false, length = 1)
    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    @Basic
    @Column(name = "time", nullable = false)
    public Timestamp getTime() {
        return time;
    }

    public void setTime(Timestamp time) {
        this.time = time;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Sale sale = (Sale) o;

        if (id != sale.id) return false;
        if (salerId != sale.salerId) return false;
        if (customerId != sale.customerId) return false;
        if (Double.compare(sale.totalPrice, totalPrice) != 0) return false;
        if (warehouseKeeperId != null ? !warehouseKeeperId.equals(sale.warehouseKeeperId) : sale.warehouseKeeperId != null)
            return false;
        if (state != null ? !state.equals(sale.state) : sale.state != null) return false;
        if (time != null ? !time.equals(sale.time) : sale.time != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result;
        long temp;
        result = id;
        result = 31 * result + (warehouseKeeperId != null ? warehouseKeeperId.hashCode() : 0);
        result = 31 * result + salerId;
        result = 31 * result + customerId;
        temp = Double.doubleToLongBits(totalPrice);
        result = 31 * result + (int) (temp ^ (temp >>> 32));
        result = 31 * result + (state != null ? state.hashCode() : 0);
        result = 31 * result + (time != null ? time.hashCode() : 0);
        return result;
    }

    @OneToMany(mappedBy = "saleById")
    public Collection<DetailListSale> getDetailListSalesById() {
        return detailListSalesById;
    }

    public void setDetailListSalesById(Collection<DetailListSale> detailListSalesById) {
        this.detailListSalesById = detailListSalesById;
    }

    @ManyToOne
    @JoinColumn(name = "warehouse_keeper_id", referencedColumnName = "id",insertable = false,updatable = false)
    public Staff getStaffByWarehouseKeeperId() {
        return staffByWarehouseKeeperId;
    }

    public void setStaffByWarehouseKeeperId(Staff staffByWarehouseKeeperId) {
        this.staffByWarehouseKeeperId = staffByWarehouseKeeperId;
    }

    @ManyToOne
    @JoinColumn(name = "saler_id", referencedColumnName = "id", nullable = false,insertable = false,updatable = false)
    public Staff getStaffBySalerId() {
        return staffBySalerId;
    }

    public void setStaffBySalerId(Staff staffBySalerId) {
        this.staffBySalerId = staffBySalerId;
    }

    @ManyToOne
    @JoinColumn(name = "customer_id", referencedColumnName = "id", nullable = false,insertable = false,updatable = false)
    public Customer getCustomerByCustomerId() {
        return customerByCustomerId;
    }

    public void setCustomerByCustomerId(Customer customerByCustomerId) {
        this.customerByCustomerId = customerByCustomerId;
    }
}
