package com.dhu.controller;

import com.dhu.pojo.Product;
import com.dhu.pojo.Purchase;
import com.dhu.pojo.Staff;
import com.dhu.service.ProductService;
import com.dhu.service.PurchaseService;
import com.dhu.vo.VoInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/purchase")
public class PurchaseController {
    @Resource
    private PurchaseService purchaseService;

    @Resource
    private ProductService productService;
/********************采购员操作begin********************************/
    //获取所有处于A状态的订单
    @RequestMapping("/getPurchasesStateEqualA")
    public String getPurchaseStateEqualA(Model model){
        List<Purchase> purchases= purchaseService.getPurchaseStateA();
        int total = purchases.size();
        if(total>0){
            model.addAttribute("purchases",purchases);
            model.addAttribute("total",total);
            return "purchase/Purchase/list";
        }
        else{
            model.addAttribute("warnInfo","当前查询没有相关信息");
            return "warn";
        }
    }
    //采购员认领采购订单，并将其装态转换为B
    @RequestMapping("/fetchPurchaseStateEqualA")
    public String fetchPurchaseStateEqualA(HttpSession session,Model model,int purchaseId){
        Staff staff = (Staff) session.getAttribute("existUser");
        try {
            if(purchaseService.updatePurchaseToStateB(staff.getId(),purchaseId)){
                return "success";
            }else{
                model.addAttribute("warnInfo","当前订单已被领取");
                return "warn";
            }
        }catch (Exception e){
            e.printStackTrace();
            model.addAttribute("errorInfo","系统故障，更新失败，请联系维护人员！");
            return "error";
        }
    }
    //获取某操作人的所有认领但未提交的订单
    @RequestMapping("/getPurchasesStateEqualBbyStaff")
    public String getPurchasesStateEqualBbyStaff(HttpSession session,Model model){
        Staff staff = (Staff) session.getAttribute("existUser");
        List<Purchase> purchases = purchaseService.getPurchaseStateBByStaff(staff);
        int total = purchases.size();
        if(total>=0){
            model.addAttribute("purchases",purchases);
            model.addAttribute("total",total);
            return "purchase/Purchase/mylist";
        }
        else{
            model.addAttribute("warnInfo","当前查询没有相关信息");
            return "/warn";
        }
    }
    //提交订单，更新价格，提交时间，订单状态至C
    @RequestMapping("/updatePurchaseFromBToC")
    public String updatePurchaseFromBToC(Model model,double totalPrice,int purchaseId){
        try {
            if(purchaseService.updatePurchaseToStateC(purchaseId,totalPrice)){
                return "success";
            }else{
                model.addAttribute("warnInfo","当前订单已被提交");
                return "warn";
            }
        }catch (Exception e){
            e.printStackTrace();
            model.addAttribute("errorInfo","系统故障，更新失败，请联系维护人员！");
            return "error";
        }
    }

    /********************采购员操作结束********************************/
    /********************仓库管理员操作开始********************************/
    //创建采购单，并创建相应的详细采购表
    @RequestMapping("/createPurchase")
    public String createPurchase(Model model, HttpSession session, VoInfo voInfo){
        List<Product> products =voInfo.getProducts();
        Staff staff =(Staff) session.getAttribute("existUser");
        try{
            purchaseService.createPurchase(staff,products);
            model.addAttribute("productlist",productService.getAll());
            return "success";
        }catch (Exception e){
            System.out.println(e);
            model.addAttribute("errorInfo","创建订单失败!");
            return "error";
        }
    }
    //获取所有状态不是D的采购单
    @RequestMapping("/getPurchasesStateNotEqualD")
    public String getPurchasesStateNotEqualD(Model model){
        model.addAttribute("purchaselist",purchaseService.getPurchaseStateNotEqualD());
        return "warehouse/PurchaseLists";
    }
    //将采购单状态更新为D
    @RequestMapping("/updatePurchaseStateToDByPurchaseList")
    public String updatePurchaseStateToDByPurchaseList(Model model,VoInfo voInfo){
        List<Purchase> purchases = voInfo.getPurchases();
        for(Purchase purchase:purchases){
            System.out.println(purchase.getId());
            System.out.println(purchase.getBuyerId());
        }
        try{
            purchaseService.updatePurchasesToStateD(purchases);
            return "success";
        }catch (Exception e){
            model.addAttribute("errorInFo", "入库失败！");
            return "error";
        }
    }
    @RequestMapping("/deletePurchaseStateEqualAByPurchaseList")
    public String deletePurchaseStateEqualAByPurchaseList(Model model,VoInfo voInfo){
        List<Purchase> purchases = voInfo.getPurchases();
        try{
            purchaseService.deletePurchaseStateEqualA(purchases);
            return "success";
        }catch (Exception e){
            model.addAttribute("errorInFo", "删除失败！");
            return "error";
        }
    }
    //将根据采购表id获取采购详情表
    @RequestMapping("/getDetailPurchaseListByPurchaseId")
    public String getDetailPurchaseListByPurchaseId(Model model,int purchaseId){
        Purchase purchase = purchaseService.getObjectById(purchaseId);
        if(purchase.getState().equals("A")){
            model.addAttribute("pstate","A");
        }else{
            model.addAttribute("pstate","O");
        }
        //这里listid是指采购者id
        model.addAttribute("listid",purchaseId);
        //这里的detail，指的是详细采购表
        model.addAttribute("detail",purchase.getDetailListPurchasesById());
        //这里我真的很迷
        model.addAttribute("detailtype","purchase");
        return "warehouse/Details";
    }


}
