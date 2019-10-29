package com.dhu.service;

import com.dhu.dao.DetailPurchaseListDao;
import com.dhu.dao.PurchaseDao;
import com.dhu.pojo.DetailListPurchase;
import com.dhu.pojo.DetailListPurchasePK;
import com.dhu.pojo.Purchase;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.transaction.Transactional;
import java.util.Collection;
import java.util.List;

@Service
public class DetailPurchaseListService extends BaseService<DetailListPurchase> {
    @Resource
    private DetailPurchaseListDao detailPurchaseListDao;

    @Resource
    private PurchaseDao purchaseDao;
    // 对详细采购表中的每条采购价格进行更新,先获取对象，再给对应值更新，防至null覆盖有效值
    @Transactional
    public List<DetailListPurchase> updateDetailPurchaseListPrice(List<DetailListPurchase> list){
        for(int i = 0;i<list.size();i++){
            DetailListPurchasePK key = new DetailListPurchasePK();
            key.setId(list.get(i).getId());
            key.setProductId(list.get(i).getProductId());
            DetailListPurchase detailListPurchase1 = detailPurchaseListDao.getObjectById(key,DetailListPurchase.class);
            detailListPurchase1.setBid(list.get(i).getBid());
            detailPurchaseListDao.update(detailListPurchase1);
            list.set(i,detailListPurchase1);
        }
        return list;
    }
    //对纤细采购表中的每条采购数量进行更新或者删除,其中bid这一栏记录为0，或者1，用来标识是删除还是更新,1标识删除
    @Transactional
    public void updateDetailPurchaseListQuantityOrDelete(List<DetailListPurchase> list){
        for (DetailListPurchase detailListPurchase:list
                ) {
            DetailListPurchasePK key = new DetailListPurchasePK();
            key.setId(detailListPurchase.getId());
            key.setProductId(detailListPurchase.getProductId());
            if(detailListPurchase.getBid().equals(1.0)){
                //删除
                //System.out.println("删除删除删除删除删除删除删除删除删除删除删除");
                detailPurchaseListDao.delete(key,DetailListPurchase.class);
                //System.out.println("删除删除删除删除删除删除删除删除删除删除删除");
            }else{
                // 更新数量
                DetailListPurchase detailListPurchase1 = detailPurchaseListDao.getObjectById(key,DetailListPurchase.class);
                detailListPurchase1.setQuantity(detailListPurchase.getQuantity());
                detailPurchaseListDao.update(detailListPurchase1);
            }
        }
    }

}
