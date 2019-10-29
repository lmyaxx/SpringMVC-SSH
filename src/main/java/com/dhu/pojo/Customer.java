package com.dhu.pojo;

import javax.persistence.*;
import java.util.Collection;
import java.util.Objects;

@Entity
public class Customer {
    private int id;
    private String name;
    private String phone;
    private String addr;
    private Integer vip;
    private String state;
    private String password;
    private String picId;
    private String email;
    private Collection<Sale> salesById;

    @Id
    @Column(name = "id", nullable = false)
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "name", nullable = false, length = 16)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Basic
    @Column(name = "phone", nullable = true, length = 16)
    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    @Basic
    @Column(name = "addr", nullable = true, length = 100)
    public String getAddr() {
        return addr;
    }

    public void setAddr(String addr) {
        this.addr = addr;
    }

    @Basic
    @Column(name = "vip", nullable = true)
    public Integer getVip() {
        return vip;
    }

    public void setVip(Integer vip) {
        this.vip = vip;
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
    @Column(name = "password", nullable = false, length = 50)
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Basic
    @Column(name = "pic_id", nullable = true, length = 50)
    public String getPicId() {
        return picId;
    }

    public void setPicId(String picId) {
        this.picId = picId;
    }

    @Basic
    @Column(name = "email", nullable = false, length = 255)
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Customer customer = (Customer) o;
        return id == customer.id &&
                Objects.equals(name, customer.name) &&
                Objects.equals(phone, customer.phone) &&
                Objects.equals(addr, customer.addr) &&
                Objects.equals(vip, customer.vip) &&
                Objects.equals(state, customer.state) &&
                Objects.equals(password, customer.password) &&
                Objects.equals(picId, customer.picId) &&
                Objects.equals(email, customer.email);
    }

    @Override
    public int hashCode() {

        return Objects.hash(id, name, phone, addr, vip, state, password, picId, email);
    }

    @OneToMany(mappedBy = "customerByCustomerId")
    public Collection<Sale> getSalesById() {
        return salesById;
    }

    public void setSalesById(Collection<Sale> salesById) {
        this.salesById = salesById;
    }
}
