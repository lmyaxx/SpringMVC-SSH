package com.dhu.vo;

import com.dhu.pojo.DetailListPurchase;
import com.dhu.pojo.Product;
import com.dhu.pojo.Purchase;

import java.util.List;

public class VoInfo {
    private List<DetailListPurchase> detailListPurchases;

    private List<Purchase> purchases;

    private List<Integer> keys;

    private List<String> names;

    private List<String> values;

    public List<String> getNames() {
        return names;
    }

    public void setNames(List<String> names) {
        this.names = names;
    }

    public List<String> getValues() {
        return values;
    }

    public void setValues(List<String> values) {
        this.values = values;
    }

    private List<Product> products;


    public List<DetailListPurchase> getDetailListPurchases() {
        return detailListPurchases;
    }

    public void setDetailListPurchases(List<DetailListPurchase> detailListPurchases) {
        this.detailListPurchases = detailListPurchases;
    }

    public List<Integer> getKeys() {
        return keys;
    }

    public void setKeys(List<Integer> keys) {
        this.keys = keys;
    }

    public List<Product> getProducts() {
        return products;
    }

    public void setProducts(List<Product> products) {
        this.products = products;
    }

    public List<Purchase> getPurchases() {
        return purchases;
    }

    public void setPurchases(List<Purchase> purchases) {
        this.purchases = purchases;
    }
}
