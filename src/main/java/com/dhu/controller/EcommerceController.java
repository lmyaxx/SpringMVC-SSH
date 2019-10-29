package com.dhu.controller;

import com.dhu.pojo.Sale;
import com.dhu.service.DetailListSaleService;
import com.dhu.service.SaleService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;

@Controller
@RequestMapping("/ecommerce")
public class EcommerceController {
    @Resource
    private SaleService saleService;
    @Resource
    private DetailListSaleService detailListSaleService;

    private final int maxResults = 16;


    @RequestMapping("/emain")
    public String eMain(){
        return "ecommerce/eindex";
    }
    @RequestMapping("/checkout")
    public String checkout(){
        return "ecommerce/cart";
    }

    @RequestMapping("/userdetail")
    public String userde(){
        return "ecommerce/userdetail";
    }
    @RequestMapping("/login_register")
    public String loginRegister(){
        return "ecommerce/login_register";
    }

    @RequestMapping("/cart")
    public String cart(){
        return "ecommerce/cart";
    }

    @RequestMapping("/user")
    public String user(){
        return "ecommerce/userdetail";
    }

    @RequestMapping("/orders")
    public String orders(){
        return "ecommerce/myorders";
    }

    @RequestMapping("/order")
    public ModelAndView orderdetail(Integer id){
        Sale sale = saleService.getDetailSaleInfo(id);

        ModelAndView modelAndView = new ModelAndView("ecommerce/orderdetail");
        modelAndView.addObject("sale",sale);
        System.out.println(sale.getDetailListSalesById().iterator().next().getComment());
        return modelAndView;
    }

    @RequestMapping("/addr")
    public String addr(){
        return "ecommerce/addressinfo";
    }
}


