package com.dhu.pojo;

import javax.persistence.*;
import java.util.Collection;

@Entity
public class Supplier {
    private int id;
    private String name;
    private String phone;
    private String addr;
    private String state;
    private String linkman;
    private String label;
    private Collection<Product> productsById;

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
    @Column(name = "name", nullable = false, length = 45)
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
    @Column(name = "state", nullable = false, length = 2)
    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    @Basic
    @Column(name = "linkman", nullable = true, length = 16)
    public String getLinkman() {
        return linkman;
    }

    public void setLinkman(String linkman) {
        this.linkman = linkman;
    }

    @Basic
    @Column(name = "label", nullable = true, length = 20)
    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Supplier supplier = (Supplier) o;

        if (id != supplier.id) return false;
        if (name != null ? !name.equals(supplier.name) : supplier.name != null) return false;
        if (phone != null ? !phone.equals(supplier.phone) : supplier.phone != null) return false;
        if (addr != null ? !addr.equals(supplier.addr) : supplier.addr != null) return false;
        if (state != null ? !state.equals(supplier.state) : supplier.state != null) return false;
        if (linkman != null ? !linkman.equals(supplier.linkman) : supplier.linkman != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (phone != null ? phone.hashCode() : 0);
        result = 31 * result + (addr != null ? addr.hashCode() : 0);
        result = 31 * result + (state != null ? state.hashCode() : 0);
        result = 31 * result + (linkman != null ? linkman.hashCode() : 0);
        return result;
    }

    @OneToMany(mappedBy = "supplierBySupplierId")
    public Collection<Product> getProductsById() {
        return productsById;
    }

    public void setProductsById(Collection<Product> productsById) {
        this.productsById = productsById;
    }
}
