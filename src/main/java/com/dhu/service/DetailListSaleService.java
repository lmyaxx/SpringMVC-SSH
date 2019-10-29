package com.dhu.service;

import com.dhu.pojo.DetailListSale;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DetailListSaleService extends BaseService<DetailListSale>{
    /**
     * 根据产品号得到这个产品的评价信息
     * @param productId 产品id
     * @return comment列表
     */
    public List<DetailListSale> getCommentByProductId(Integer productId){
        List<DetailListSale> detailListSales = this.getObjectsByDetachedCriteria(
                DetachedCriteria.forClass(DetailListSale.class).add(
                        Restrictions.and(
                                Restrictions.eq("productId",productId),
                                Restrictions.isNotNull("comment")
                        )
                )
        );
        return detailListSales;
    }


}
