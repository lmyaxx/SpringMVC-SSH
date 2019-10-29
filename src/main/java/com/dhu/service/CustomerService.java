package com.dhu.service;

import com.dhu.pojo.Customer;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CustomerService extends BaseService<Customer> {

    /**
     *根据name进行模糊查询，返回符合条件的客户
     * @param name 客户姓名
     * @return 符合条件的客户
     */
    public List<Customer> findCustomerByName(String name){
        List<Customer> cList = this.getObjectsByDetachedCriteria(
                DetachedCriteria.forClass(Customer.class).add(Restrictions.like("name",
                        "%" + name.trim() + "%"))
        );
        return cList;
    }

    /**
     * 处理登录业务
     * @param email 账户
     * @param password 密码
     * @return 根据账户查到的客户信息
     */
    public Customer login(String email,String password){
        List<Customer> customers = this.getObjectsByDetachedCriteria(
                DetachedCriteria.forClass(Customer.class).add(
                        Restrictions.and(
                                Restrictions.eq("email",email),
                                Restrictions.eq("password",password)
                        )
                )
        );
        if(customers.size()==0){
            return null;
        }
        return customers.iterator().next();//只有一个客户
    }

}
