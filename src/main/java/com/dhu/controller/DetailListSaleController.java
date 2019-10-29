package com.dhu.controller;

import com.dhu.pojo.DetailListSale;
import com.dhu.pojo.Sale;
import com.dhu.service.DetailListSaleService;
import com.dhu.service.ProductService;
import com.dhu.service.SaleService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
@Controller
@RequestMapping("/detailListSale")
public class DetailListSaleController {
    @Resource
    private DetailListSaleService detailListSaleService;
    @Resource
    private SaleService saleService;
    @Resource
    private ProductService productService;
    @RequestMapping("/doEvaluate")
    public ModelAndView doEvaluate(DetailListSale detailListSale){
        ModelAndView modelAndView = new ModelAndView("ecommerce/orderdetail");
        System.out.println(detailListSale.getId());
        System.out.println(detailListSale.getProductId());
        System.out.println(detailListSale.getQuantity());
        detailListSaleService.update(detailListSale);

        Sale sale = saleService.getDetailSaleInfo(detailListSale.getId());
        for (DetailListSale detailListSale1:sale.getDetailListSalesById()){
            if(detailListSale1.getProductByProductId()==null){
                detailListSale1.setProductByProductId(productService.getObjectById(detailListSale.getProductId()));
            }
        }
        modelAndView.addObject("sale",sale);
        //测试

        return modelAndView;
    }
}
