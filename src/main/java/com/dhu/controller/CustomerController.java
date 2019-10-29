package com.dhu.controller;

import com.dhu.pojo.Customer;
import com.dhu.pojo.DetailListSale;
import com.dhu.pojo.Sale;
import com.dhu.service.CustomerService;
import com.dhu.service.SaleService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.Collections;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/customer")
public class CustomerController {

    @Resource
    private CustomerService customerService;
    /**
     *处理新增客户请求
     * @return 返回添加客户页面
     */
    @RequestMapping("/returnAddCustomerVierer")
    public String returnAddCustomerVierer(){
        return  "sale/customer/add";
    }

    /**
     * 处理客户列表的请求，返回所偶客户对象
     * @return 返回客户列表
     */
    @RequestMapping("/customerList")
    public ModelAndView customerList(){
        List<Customer> cList = customerService.getAll();
        Collections.reverse(cList);
        ModelAndView modelAndView = new ModelAndView("sale/customer/list");
        modelAndView.addObject("cList",cList);
        return modelAndView;
    }

    /**
     * 接受添加客户页面即add.jsp传入的数据，保存到数据库中，不适用springmvc封装成pojo原因是不想修改数据库
     * @return
     */
    @RequestMapping(value="/saveCustomer", method = {RequestMethod.POST})
    public String saveCustomer(Customer customer){

        customer.setState("F");
        customer.setPassword("123456");
        System.out.println(customer.getName());
        System.out.println(customer.getEmail());
        System.out.println(customer.getVip() + " " + customer.getAddr() + " " + customer.getState() + " " + customer.getPhone());
        customerService.save(customer);
        return "redirect:/customer/customerList";
    }

    /**
     * 从customer下的list.jsp中接收待修改客户的id，返回对该客户进行修改的界面
     * @param id 客户id
     * @return 该客户的信息和修改该客户信息的界面
     */
    @RequestMapping("/editCustomer")
    public ModelAndView editCustomer(@RequestParam("id")Integer id){
        ModelAndView modelAndView = new ModelAndView("sale/customer/edit");
        Customer customer = customerService.getObjectById(id);
        modelAndView.addObject(customer);
        return modelAndView;
    }

    @RequestMapping("/updateCustomer")
    public String updateCustomer(Customer customer){
        System.out.println(customer.getId() + " " + customer.getVip() + " " + customer.getAddr() + " " + customer.getPhone());
        Customer user = customerService.getObjectById(customer.getId());
        user.setVip(customer.getVip());
        user.setAddr(customer.getAddr());
        user.setPhone(customer.getPhone());
        customerService.update(user);
        return "redirect:/customer/customerList";

    }

    /**
     *接受从客户了列表界面筛选框的输入，进行处理
     * @return 返回客户列表界面
     */
    @RequestMapping("/findCustomerByName")
    public ModelAndView findCustomerByName(@RequestParam("name")String name){
        System.out.println(name);
        List<Customer> cList = customerService.findCustomerByName(name);
        ModelAndView modelAndView = new ModelAndView("sale/customer/list");
        modelAndView.addObject("cList",cList);
        return modelAndView;
    }

    /**
     * 在reassure.jsp页面确定好产品后，点击确定由该方法处理
     * @return 客户列表界面
     */
    @RequestMapping("/findCustomerList")
    public ModelAndView findCustomerList(){
        ModelAndView modelAndView = new ModelAndView("sale/order/list");
        List<Customer> cList = customerService.getAll();
        modelAndView.addObject("cList",cList);
        return modelAndView;
    }

    /**
     * 在填写订单的时候，根据客户名字筛选客户，此方法属于冗余代码，但如果不使用
     * 这种方式，需要在界面里面增加请求参数，标识应该返回哪一个界面，采用冗余
     * @param name 客户姓名
     * @return
     */
    @RequestMapping("/searchCustomerByName")
    public ModelAndView searchCustomerByName(@RequestParam("name")String name){
        ModelAndView modelAndView = new ModelAndView("sale/order/list");
        List<Customer> cList = customerService.findCustomerByName(name);
        modelAndView.addObject("cList",cList);
        return modelAndView;
    }

    @Resource
    private SaleService saleService;

    /**
     * 客户登录
     * @param email 账户
     * @param password 密码
     * @param session
     * @return
     */
    @RequestMapping("/customer_login")
    public String login(String email,String password, HttpSession session){
        Customer customer = customerService.login(email,password);
        if(customer==null){//登录失败
            return "ecommerce/login_register";//登录失败返回哪里？？
        }
        else {
            session.setAttribute("user",customer);
            //此外，要把登录前游客购物车中的商品加入到这个用户的购物车中
            Map<Integer,Sale> cart = (Map<Integer, Sale>) session.getAttribute("cart");
            if(cart!=null){
                //如果登录的用户的购物车是空的话，直接加入
                if(cart.get(customer.getId())==null){
                    cart.put(customer.getId(),cart.get(0));//设置0是未登录时的客户id
                    cart.remove(0);
                }
                else {
                    if (cart.get(0)!=null){
                        Map<Integer,Sale> userCart = (Map<Integer, Sale>) session.getAttribute("cart");
                        StringBuffer msg = new StringBuffer();
                        for (DetailListSale detailListSale: cart.get(0).getDetailListSalesById()){
                            saleService.addProductToCart(userCart,detailListSale.getProductId(),detailListSale.getQuantity(),
                                    customer,0,msg);
                        }
                    }


                }
                session.setAttribute("cart",cart);
            }
            return "ecommerce/eindex";
        }

    }

    @RequestMapping("/logout")
    public String logout(HttpSession session){
        session.setAttribute("user",null);
        session.setAttribute("total",0);
        session.setAttribute("quantity",0);
        return "ecommerce/eindex";
    }

    @RequestMapping(value="/saveCustomer1", method = {RequestMethod.POST})
    public String saveCustomer1(Customer customer){

        customer.setState("F");
        customer.setVip(0);
        System.out.println(customer.getName());
        //System.out.println();
        System.out.println(customer.getVip() + " " + customer.getAddr() + " " + customer.getState() + " " + customer.getPhone());
        System.out.println(customer.getEmail());
        System.out.println(customer.getPassword());
        customerService.save(customer);
        return "ecommerce/login_register";//这里应该返回哪里呢
    }

    /**
     * 修改客户信息
     * @param customer
     * @param session
     * @return
     */
    @RequestMapping("/editCustomer1")
    public ModelAndView editCustomer1(Customer customer,HttpSession session){
        ModelAndView modelAndView = new ModelAndView("ecommerce/eindex");
        Customer user= (Customer)session.getAttribute("user");
        if (user==null){
            modelAndView.setViewName("ecommerce/login_register");
        }
        if(customer.getName()!=null&&customer.getName().length()!=0)
            user.setName(customer.getName());
        System.out.println(customer.getPhone());
        user.setPhone(customer.getPhone());
        user.setAddr(customer.getAddr());
        System.out.println(customer.getEmail());
//        user.setEmail("123");
        customerService.update(user);
        session.setAttribute("user",user);
        modelAndView.addObject(customer);
        return modelAndView;
    }

    @RequestMapping("/updateCustomer1")
    public String updateCustomer1(Customer customer){
        System.out.println(customer.getId() + " " + customer.getVip() + " " + customer.getAddr() + " " + customer.getPhone());
        customer.setState("F");
        try {
            customerService.update(customer);
            return "success";
        }catch (Exception e){
            return "error";
        }


    }
}
