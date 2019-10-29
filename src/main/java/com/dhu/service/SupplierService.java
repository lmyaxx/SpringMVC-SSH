package com.dhu.service;

import com.dhu.pojo.Supplier;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SupplierService extends BaseService<Supplier> {
    //通过姓名和状态模糊查询厂商
    public List<Supplier> getSuppliersByNameAndState(String name, String state){
        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Supplier.class);
        if(name!=null)
            detachedCriteria.add(Restrictions.like("name", "%"+name+"%"));
        if(state!=null)
            detachedCriteria.add(Restrictions.eq("state", state));
        return  getObjectsByDetachedCriteria(detachedCriteria);
    }
}
