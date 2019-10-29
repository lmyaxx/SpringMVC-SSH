package com.dhu.service;

import com.dhu.dao.DetailPurchaseListDao;
import com.dhu.dao.PurchaseDao;
import com.dhu.pojo.*;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import javax.annotation.Resource;

import java.sql.Timestamp;
import java.util.Collection;
import java.util.List;

@Service
public class PurchaseService extends BaseService<Purchase> {


    @Resource
    private DetailPurchaseListDao detailPurchaseListDao;

    @Resource
    private PurchaseDao purchaseDao;

    //获取所有A状态订单
    @Transactional
    public List<Purchase> getPurchaseStateA(){
        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Purchase.class);
        detachedCriteria.add(Restrictions.eq("state", "A"));
        return getObjectsByDetachedCriteria(detachedCriteria);
    }

    //某人认领任务，先对订单状态进行校验,成功则更新采购者id，以及采购订单状态
    @Transactional
    public boolean updatePurchaseToStateB(int staffId,int purchaseId){
        Purchase purchase = getObjectById(purchaseId);
        if(purchase.getState().equals("A")){
            purchase.setBuyerId(staffId);
            purchase.setState("B");
            return true;
        }
        return false;
    }

    //获取某人的B状态purchase订单
    @Transactional
    public List<Purchase> getPurchaseStateBByStaff(Staff staff){
        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Purchase.class);
        detachedCriteria.add(Restrictions.eq("staffByBuyerId",staff));
        detachedCriteria.add(Restrictions.eq("state", "B"));
        return getObjectsByDetachedCriteria(detachedCriteria);
    }

    //提交订单时，校验该订单是否仍处于未被提交的B状态，并进行订单状态至C，更新总价、提交时间
    @Transactional
    public boolean updatePurchaseToStateC(int purchaseId,double totalPrice){
        Purchase purchase = getObjectById(purchaseId);
        if(purchase.getState().equals("B")){
            purchase.setState("C");
            purchase.setTotalPrice(totalPrice);
            Timestamp submitTime  = new Timestamp(System.currentTimeMillis());
            purchase.setSubmitTime(submitTime);
            return true;
        }else return false;
    }
    //获取所有状态不为完结状态D的订单
    @Transactional
    public List<Purchase> getPurchaseStateNotEqualD(){
        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Purchase.class);
        detachedCriteria.add(Restrictions.ne("state","D"));
        return getObjectsByDetachedCriteria(detachedCriteria);
    }
    //创建采购单，并对生成与之对应的详细采购单
    @Transactional
    public void createPurchase(Staff staff, List<Product>products){
        //创建订单并保存
        Purchase purchase = new Purchase();
        purchase.setState("A");
        purchase.setWarehouseKeeperId(staff.getId());
        Timestamp now=new Timestamp(System.currentTimeMillis());
        purchase.setReleaseTime(now);
        int id = (Integer) save(purchase);
        //对订单详细内容进行添加
        for(Product product:products){
            DetailListPurchase detailPurchaseList = new DetailListPurchase();
            detailPurchaseList.setQuantity(product.getQuantity());
            detailPurchaseList.setProductId(product.getId());
            detailPurchaseList.setId(id);
            detailPurchaseListDao.save(detailPurchaseList);
        }
    }



    //将订单状态更新到D,purchase中buyid=1标识入库
    @Transactional
    public void updatePurchasesToStateD(List<Purchase> purchases) {
        for(Purchase purchase:purchases){
            Purchase purchase1 = purchaseDao.getObjectById(purchase.getId(),Purchase.class);
            Integer flag= purchase.getBuyerId();
            if(flag!=null&&flag==1){
                purchase1.setState("D");
                purchaseDao.save(purchase1);
            }

        }
    }
    //根据批量入库或者删除采购表,purchase中buyid=1标识删除
    @Transactional
    public void deletePurchaseStateEqualA(List<Purchase> purchases){
        for(Purchase purchase:purchases){
            Purchase purchase1 = purchaseDao.getObjectById(purchase.getId(),Purchase.class);
            Integer flag= purchase.getBuyerId();
            if(flag!=null&&flag==1&&purchase1.getState().equals("A")){
                Collection<DetailListPurchase> detailListPurchases = purchase1.getDetailListPurchasesById();
                for(DetailListPurchase detailListPurchase:detailListPurchases){
                    DetailListPurchasePK key = new DetailListPurchasePK();
                    key.setId(detailListPurchase.getId());
                    key.setProductId(detailListPurchase.getProductId());
                    detailPurchaseListDao.delete(key,DetailListPurchase.class);
                }
                purchaseDao.delete(purchase1.getId(),Purchase.class);
            }
        }
    }


    //根据批量入库或者删除采购表
//    @Transactional
//    public void deleteOrUpdatePurchaseStateToDByPurchaseList(List<Purchase> purchases){
//        for(Purchase purchase:purchases){
//            //用购买者id来标识是删除还是入库，1标识删除
//            if(purchase.getBuyerId().equals(1)){
//                Purchase purchase1 = purchaseDao.getObjectById(purchase.getId(),Purchase.class);
//                //只能删除A状态采购单
//                if(purchase1.getState().equals("A")){
//                    Collection<DetailListPurchase> detailListPurchases = purchase1.getDetailListPurchasesById();
//                    for(DetailListPurchase detailListPurchase:detailListPurchases){
//                        DetailListPurchasePK key = new DetailListPurchasePK();
//                        key.setId(detailListPurchase.getId());
//                        key.setProductId(detailListPurchase.getProductId());
//                        detailPurchaseListDao.delete(key,DetailListPurchase.class);
//                    }
//                    purchaseDao.delete(purchase1.getId(),Purchase.class);
//                }
//            }else{
//                //不是1则比表示入库
//                Purchase purchase1 = purchaseDao.getObjectById(purchase.getId(),Purchase.class);
//                purchase1.setState("D");
//                purchaseDao.save(purchase1);
//            }
//        }
//    }
}
