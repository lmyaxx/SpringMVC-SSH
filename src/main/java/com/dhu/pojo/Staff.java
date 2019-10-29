package com.dhu.pojo;

import javax.persistence.*;
import java.util.Collection;

@Entity
public class Staff {
    private String picId;
    private int id;
    private String name;
    private String job;
    private String pw;
    private String phone;
    private String sex;
    private String addr;
    private Collection<Purchase> purchasesById;

    private Collection<Sale> salesById;


    @Basic
    @Column(name = "pic_id", nullable = true, length = 50)
    public String getPicId() {
        return picId;
    }

    public void setPicId(String picId) {
        this.picId = picId;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
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
    @Column(name = "job", nullable = false, length = 1)
    public String getJob() {
        return job;
    }

    public void setJob(String job) {
        this.job = job;
    }

    @Basic
    @Column(name = "pw", nullable = false, length = 16)
    public String getPw() {
        return pw;
    }

    public void setPw(String pw) {
        this.pw = pw;
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
    @Column(name = "sex", nullable = true, length = 4)
    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    @Basic
    @Column(name = "addr", nullable = true, length = 50)
    public String getAddr() {
        return addr;
    }

    public void setAddr(String addr) {
        this.addr = addr;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Staff staff = (Staff) o;

        if (id != staff.id) return false;
        if (name != null ? !name.equals(staff.name) : staff.name != null) return false;
        if (job != null ? !job.equals(staff.job) : staff.job != null) return false;
        if (pw != null ? !pw.equals(staff.pw) : staff.pw != null) return false;
        if (phone != null ? !phone.equals(staff.phone) : staff.phone != null) return false;
        if (sex != null ? !sex.equals(staff.sex) : staff.sex != null) return false;
        if (addr != null ? !addr.equals(staff.addr) : staff.addr != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (job != null ? job.hashCode() : 0);
        result = 31 * result + (pw != null ? pw.hashCode() : 0);
        result = 31 * result + (phone != null ? phone.hashCode() : 0);
        result = 31 * result + (sex != null ? sex.hashCode() : 0);
        result = 31 * result + (addr != null ? addr.hashCode() : 0);
        return result;
    }

    @OneToMany(mappedBy = "staffByWarehouseKeeperId")
    public Collection<Purchase> getPurchasesById() {
        return purchasesById;
    }

    public void setPurchasesById(Collection<Purchase> purchasesById) {
        this.purchasesById = purchasesById;
    }


    @OneToMany(mappedBy = "staffByWarehouseKeeperId")
    public Collection<Sale> getSalesById() {
        return salesById;
    }

    public void setSalesById(Collection<Sale> salesById) {
        this.salesById = salesById;
    }
}


