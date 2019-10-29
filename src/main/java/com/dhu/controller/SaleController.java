package com.dhu.controller;

import com.dhu.pojo.*;
import com.dhu.service.CustomerService;
import com.dhu.service.SaleService;
import com.dhu.vo.VoInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 因为业务逻辑原因不得不使用session和cookie，选择session
 * 后经尝试发现可以不用，使用全局变量代替，目前不清楚哪一种设计更好
 */
@Controller
@SessionAttributes("cart")
@RequestMapping("/sale")
public class SaleController {
    @Resource
    private SaleService saleService;



    @Resource
    private CustomerService customerService;


    /**
     *接受从产品列表界面输入的产品数量
     * @return 确认界面
     */
    @RequestMapping("getBuyProductInfo")
    public String getBuyProductInfo(HttpServletRequest request,
                                          HttpSession session){
        Sale sale = new Sale();
        try {
            sale = saleService.writeBuyProductInfo(request.getParameterMap());
            //Sale sale = new Sale();
            session.setAttribute("sale",sale);
            //测试
            Product product = sale.getDetailListSalesById().iterator().next().getProductByProductId();
            System.out.println(product.getName());
            return "sale/order/reassure";
        }catch (Exception e){
            return "main_welcome";
        }
    }

    /**
     * 在reassure.jsp中点击删除按钮后由这个方法处理
     * 删除已经添加欲购买的产品
     * @param id 产品
     * @Return 返回reassure.jsp页面
     */
    @RequestMapping("/deleteAddedProductByid")
    public ModelAndView deleteAddedProductByid(@RequestParam("id")Integer id,
                                               HttpSession session){
        ModelAndView modelAndView = new ModelAndView();
        Sale sale = (Sale)session.getAttribute("sale");
        try {
            System.out.println(id + "产品");
            System.out.println(sale.getTotalPrice());
            saleService.deleteAddedProductByid(id,sale);
            modelAndView.addObject(sale);
            modelAndView.setViewName("sale/order/reassure");
            if(sale==null){
                modelAndView.setViewName("main_welcome");
            }
            return modelAndView;
        }catch (Exception e){
            System.out.println("出现未知异常");
            modelAndView.setViewName("login/login");//此处需要修改
            return modelAndView;
        }
    }

    /**
     *根据客户id和之前选择的产品信息，写入数据库中
     * @param customerId

     * @return
     */
    @RequestMapping("/writeOrder")
    public ModelAndView writeOrder(@RequestParam("customerId")Integer customerId,
                                   HttpSession session){

        Staff staff = (Staff)session.getAttribute("existUser");
        System.out.println("writeodder");
        Sale sale = (Sale) session.getAttribute("sale");

        ModelAndView modelAndView = new ModelAndView();
        if (sale==null){
            modelAndView.setViewName("login/login");
            return modelAndView;
        }
        try{
            if(saleService.insertSaleAndDetailSale(customerId,sale,staff)){
                modelAndView.setViewName("redirect:/sale/getSaleList");
                return modelAndView;
            }
            else {
                modelAndView.addObject("warnInfo","库存不足！");
                modelAndView.setViewName("warn");
            }
        }catch (Exception e){
            System.out.println(e);
            modelAndView.setViewName("error");
            return modelAndView;
        }
        modelAndView.setViewName("error");
        return modelAndView;
    }

    /**
     *点击订单列表进入该方法进行处理
     * 查询数据库中的订单并返回
     * @return 订单列表界面
     */
    @RequestMapping("/getSaleList")
    public ModelAndView getSaleList(){
        List<Sale> sList = saleService.getSaleList();
        ModelAndView modelAndView = new ModelAndView("sale/salelist/list");
        modelAndView.addObject("sList",sList);
        return modelAndView;
    }

    /**
     * 根据订单状态进行查询
     * @param state 订单状态
     * @param method 从哪个界面进入，获得隐含查询条件
     * @return 订单列表界面
     */
    @RequestMapping("/getSaleListByState")
    public ModelAndView getSaleListByStatet(@RequestParam("state")String state,
                                            @RequestParam("method")String method,
                                            HttpSession session){
        ModelAndView modelAndView = new ModelAndView();
        Staff staff = (Staff)session.getAttribute("existUser");
        System.out.println(method);
        if(staff==null){
            System.out.println("尚未登录");
            modelAndView.setViewName("login/login");
            modelAndView.addObject("warninfo","请先登录");
            return modelAndView;
        }
        if("billList".equals(method)){
            List<Sale> sList = saleService.getSaleListByState(state);
            modelAndView.addObject("sList",sList);
            modelAndView.setViewName("sale/salelist/list");
        }
        else if("myList".equals(method)){
            List<Sale> sList = saleService.getSaleListByState(state,staff);
            modelAndView.addObject("sList",sList);
            modelAndView.setViewName("sale/salelist/myList");
        }
        return modelAndView;
    }

    /**
     * 根据订单号，查询该订单的详细信息
     * @param saleId
     * @return
     */
    @RequestMapping("/getDetailSaleInfo")
    public ModelAndView getDetailSaleInfo(@RequestParam("saleId")Integer saleId){
        ModelAndView modelAndView = new ModelAndView("sale/salelist/detail");
        Sale sale = saleService.getDetailSaleInfo(saleId);
        modelAndView.addObject("sale",sale);
        return modelAndView;
    }

    /**
     * 点击我的订单由这个方法处理

     * @return 该销售员售出的所有订单
     */
    @RequestMapping("/getCurrentSalerBills")
    public ModelAndView getCurrentSalerBills(HttpSession session){
        ModelAndView modelAndView = new ModelAndView("sale/salelist/myList");
        Staff staff = (Staff)session.getAttribute("existUser");
        if(staff==null){
            System.out.println("尚未登录");
            modelAndView.setViewName("login/login");
            modelAndView.addObject("warninfo","请先登录");
            return modelAndView;
        }
        List<Sale> sList = saleService.getSaleListBySalersId(staff);
        modelAndView.addObject("sList",sList);

        return modelAndView;
    }

    /**
     *点击客户列表中的购买历史，进入该方法
     * @param customerId 客户id
     * @return 当前用户的购买历史
     */

    @RequestMapping("/getMyBuyHistory")
    public ModelAndView getMyBuyHistory(@RequestParam("customerId")Integer customerId){
        ModelAndView modelAndView = new ModelAndView("sale/customer/buyHistory");
        List<Sale> sList = saleService.getSaleListByCustomerId(customerId);
        modelAndView.addObject("sList",sList);
        return modelAndView;
    }

    //获取所有的状态为B的销售单
    @RequestMapping("/getSalesStateEqualB")
    public String getSalesStateEqualB(Model model){
        List<Sale> saleList = saleService.getSalesStateEqualB();
        model.addAttribute("salelist",saleList);
        return "warehouse/SaleLists";
    }
    //将订状态从B转换到C
    @RequestMapping("/updateSalesToStateC")
    public String updateSalesToStateC(Model model, HttpSession session, VoInfo voInfo){
        List<Integer> keys = voInfo.getKeys();
        for(int i:keys){
            System.out.println("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
            System.out.println(i);
        }
        Staff staff = (Staff) session.getAttribute("existUser");
        try{
            saleService.updateSalesToStateC(staff,keys);
            return "success";
        }catch (Exception e){
            model.addAttribute("errorInFo", " 货存不足,出库失败！");
            return "error";
        }
    }
    //将根据销售表id获取详细销售表
    @RequestMapping("/getDetailSalesBySaleId")
    public String getDetailSalesBySaleId(Model model,int saleId){
        Sale sale = saleService.getObjectById(saleId);
        Collection<DetailListSale> detailListSales = sale.getDetailListSalesById();
        model.addAttribute("detail",detailListSales);
        model.addAttribute("detailtype", "sale");
        model.addAttribute("pstate","S");
        model.addAttribute("listid",saleId);
        return "warehouse/Details";
    }


    private int unLoginUser = 0;

    /**
     *
     * @param productId
     * @param quantity
     * @param session
     * @param response
     * @return

     */
    @RequestMapping("/addProductToCart")
    @ResponseBody
    public Map<String,Object> addProductToCart(
            @RequestParam("productId")Integer productId,
                                         @RequestParam(value = "quantity",required = false)Integer quantity, HttpSession session, HttpServletResponse response
                                        ) throws IOException {
        if(quantity==null){
            quantity=1;
        }
        Customer customer = (Customer)session.getAttribute("user") ;
        System.out.println("hahahhahah");
        //key为客户id，value为sale对象
        Map<Integer,Sale> cart = (Map<Integer, Sale>) session.getAttribute("cart");
        if (cart==null){
            cart = new HashMap<>();
        }
        StringBuffer msg = new StringBuffer();
        Sale sale = saleService.addProductToCart(cart,productId,quantity,customer,unLoginUser,msg);
        System.out.println(msg);
        session.setAttribute("cart",cart);//更新购物车
        Map<String,Object> map = new HashMap<>();
        map.put("error","true");
        System.out.println(sale.getTotalPrice());
        System.out.println(sale.getDetailListSalesById().size());
        map.put("total",sale.getTotalPrice());
        int totalQuantity = 0;
        for (DetailListSale detailListSale:sale.getDetailListSalesById()){
            totalQuantity += detailListSale.getQuantity();
        }
        map.put("quantity",sale.getDetailListSalesById().size());
        session.setAttribute("total",sale.getTotalPrice());
        session.setAttribute("quantity",sale.getDetailListSalesById().size());
        return  map;
    }

    /**
     * 根据登录的客户名显示购物车，如果购物车为空，则返回null
     * @param session
     * @return
     */
    @RequestMapping("/showCart")
    public ModelAndView showCart(HttpSession session){
        ModelAndView modelAndView = new ModelAndView("ecommerce/cart");
        Customer customer = (Customer)session.getAttribute("user") ;
        Map<Integer,Sale> cart = (Map<Integer, Sale>) session.getAttribute("cart");
        Sale customerCart = saleService.showCart(cart,customer,unLoginUser);
        if (customerCart==null){
            modelAndView.setViewName("/ecommerce/eindex");//此时应该返回一个购物车信息为空的页面
            return modelAndView;
        }
        else {
            modelAndView.addObject("itemslist",customerCart);
           // modelAndView.addObject("calc",1);
            return modelAndView;
        }
    }

    /**
     * 在订单详情页面点击立即提交,
     * @param session
     * @return 如果无用户登录，则返回登录界面
     *          如果用户登录则返回确认界面
     *           确认界面包括产品详细信息，以及客户信息如地址等
     *           客户的一些信息和购买数量可以修改
     *           返回reassure.jsp
     */
    @RequestMapping("/doSubmit")
    public ModelAndView doSubmit(HttpSession session,
                              @RequestParam("productId")Integer productId,
                              @RequestParam("num")Integer num){
        ModelAndView modelAndView = new ModelAndView("redirect:login/login");
        Customer customer = (Customer)session.getAttribute("user");
        if(customer==null){
            return modelAndView;
        }
        else {
             Sale sale = saleService.doSubmit(customer,productId,num);
             modelAndView.addObject(sale);
             modelAndView.setViewName("");
             return modelAndView;
        }
    }

    /**
     * 不知道前端如何传递参数，等前端写好后再写
     * @return
     */
    @RequestMapping("/doBuy")
    public ModelAndView doBuy(HttpSession session){
        ModelAndView modelAndView = new ModelAndView("ecommerce/myorders");
        Customer customer = (Customer)session.getAttribute("user") ;
        Map<Integer,Sale> cart = (Map<Integer, Sale>) session.getAttribute("cart");
        if(cart!=null&&cart.containsKey(customer.getId())){
            saleService.doBuy(customer,cart);
            //清空购物车
            cart.remove(customer.getId());
            session.setAttribute("cart",cart);
        }
        List<Sale> sList = saleService.getSaleListByCustomerId(customer.getId());
        for (Sale sale:sList){
            if (sale.getCustomerByCustomerId()==null){
                sale.setCustomerByCustomerId(customerService.getObjectById(sale.getCustomerId()));
            }
        }
        modelAndView.addObject("itemlist",sList);
        return modelAndView;
    }
    @RequestMapping("/doComputer")
    public ModelAndView doComputer(HttpServletRequest request,HttpSession session){
        Map<String,String[]> map = request.getParameterMap();

        ModelAndView modelAndView = new ModelAndView("ecommerce/cart");

        Customer customer = (Customer)session.getAttribute("user") ;
        System.out.println(customer.getId());
        Map<Integer,Sale> cart = (Map<Integer, Sale>) session.getAttribute("cart");
        saleService.doComputer(map,customer,cart);
        session.setAttribute("cart",cart);
        System.out.println(cart.get(customer.getId()).getTotalPrice());
        modelAndView.addObject("itemslist",cart.get(customer.getId()));
        modelAndView.addObject("calc",1);

        return modelAndView;
    }
    @ResponseBody
    @RequestMapping("/emptyCart")
    public Map<String,Object> emptyCart(HttpSession session){
        Map<String,Object> map = new HashMap<>();
        Customer customer = (Customer)session.getAttribute("user");
        Map<Integer,Sale> cart = (Map<Integer, Sale>) session.getAttribute("cart");

        if(customer==null){
            if(cart!=null){
                cart.remove(unLoginUser);
               // cart.put(unLoginUser,null);
            }
        }
        else {
            if(cart!=null){
                cart.remove(customer.getId());
                //cart.put(customer.getId(),null);
            }
        }
        System.out.println("执行");
        session.setAttribute("cart",cart);
        session.setAttribute("total",0);
        session.setAttribute("quantity",0);
        map.put("error","true");
        return map;

    }

    @RequestMapping("/addProductToCart2")
    public ModelAndView addProductToCart2(@RequestParam("productId")Integer productId,
                                               @RequestParam(value = "quantity",required = false)Integer quantity, HttpSession session, HttpServletResponse response
    ) throws IOException {
        if(quantity==null){
            quantity=1;
        }
        Customer customer = (Customer)session.getAttribute("user") ;
        System.out.println("hahahhahah");
        //key为客户id，value为sale对象
        Map<Integer,Sale> cart = (Map<Integer, Sale>) session.getAttribute("cart");
        if (cart==null){
            cart = new HashMap<>();
        }
        StringBuffer msg = new StringBuffer();
        Sale sale = saleService.addProductToCart(cart,productId,quantity,customer,unLoginUser,msg);
        System.out.println(msg);
        session.setAttribute("cart",cart);//更新购物车
        session.setAttribute("total",sale.getTotalPrice());
        session.setAttribute("quantity",sale.getDetailListSalesById());

        System.out.println(sale.getTotalPrice());
        System.out.println(sale.getDetailListSalesById().size());
        ModelAndView modelAndView = new ModelAndView("/ecommerce/eindex");
        return modelAndView;
    }

}
