//package com.dhu.test;
//
//import com.dhu.dao.DetailListSaleDao;
//import com.dhu.pojo.Customer;
//import com.dhu.pojo.DetailListSale;
//import com.dhu.service.CustomerService;
//import com.dhu.service.DetailListSaleService;
//import org.junit.Test;
//import org.junit.runner.RunWith;
//import org.springframework.test.context.ContextConfiguration;
//import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
//
//import javax.annotation.Resource;
//
//@RunWith(SpringJUnit4ClassRunner.class)
////加载spring配置文件
//@ContextConfiguration(locations = { "classpath:applicationContext.xml" })
//public class CustomerTest {
//    @Resource
//    private CustomerService customerService;
//    @Resource
//    private DetailListSaleService detailListSaleService;
//    @Test
//    public void testCustomer(){
//        Customer customer = new Customer();
//        customer.setName("明月");
//        customer.setVip(1);
//        customer.setPhone("15565362443");
//        customer.setAddr("街道");
//        customer.setState("F");
//        customerService.save(customer);
//
//        customer.setId(12);
//        customerService.update(customer);
//    }
//
//}
