package com.dhu.controller;

import com.dhu.pojo.DetailListPurchase;
import com.dhu.pojo.Purchase;
import com.dhu.service.DetailPurchaseListService;
import com.dhu.service.PurchaseService;
import com.dhu.vo.VoInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.Collection;
import java.util.List;

@Controller
@RequestMapping("/DetailPurchaseList")
public class DetailPurchaseListController {
    @Resource
    private DetailPurchaseListService detailPurchaseListService;

    @Resource
    private PurchaseService purchaseService;
    //获取某采购单采购的详细产品情况,返回的界面信息不可更改
    @RequestMapping("/getDetailPurchaseListByPurchase")
    public ModelAndView getDetailPurchaseListByPurchase(Model model, int purchaseId){
        ModelAndView modelAndView = new ModelAndView();
        Purchase purchase = purchaseService.getObjectById(purchaseId);
        Collection<DetailListPurchase> detailListPurchases = purchase.getDetailListPurchasesById();
        for(DetailListPurchase d:detailListPurchases){
            System.out.println(d.getId());
            System.out.println(d.getProductByProductId().getName()+"hah");
        }
        int total = detailListPurchases.size();
        if(total>0){
//            model.addAttribute("total", total);
//            model.addAttribute("detailListPurchases",detailListPurchases);
//            model.addAttribute("purchase", purchase);
            modelAndView.addObject("total", total);
            modelAndView.addObject("detailListPurchases",detailListPurchases);
            modelAndView.addObject("purchase", purchase);
         //   modelAndView.setViewName("jsps/purchase/Purchase/detailListA");
            modelAndView.setViewName("purchase/Purchase/detailListA");
//            return "/jsps/purchase/Purchase/detailListA";
        }else{
            modelAndView.addObject("warnInfo", "当前查询没有相关信息");
//            model.addAttribute("warnInfo", "当前查询没有相关信息");
            modelAndView.setViewName("warn");
//            return "/jsps/warn";
        }
        return modelAndView;
    }
    //获取某采购单采购的详细产品情况,返回的价格信息可进行编辑
    @RequestMapping("/getDetailPurchaseListUpdatePage")
    public String getDetailPurchaseListUpdatePage(Model model,int purchaseId){
        Purchase purchase = purchaseService.getObjectById(purchaseId);
        Collection<DetailListPurchase> detailListPurchases = purchase.getDetailListPurchasesById();
        int total = detailListPurchases.size();
        if(purchase.getState().equals("B")){
            model.addAttribute("total", total);
            model.addAttribute("detailListPurchases",detailListPurchases);
            model.addAttribute("purchase", purchase);
            return "purchase/Purchase/detailListB";
        }else{
            model.addAttribute("warnInfo", "该采购单已提交，如有错误，请联系仓库管理员！");
            return "warn";
        }
    }
    //对详细采购表进行价格更新，因采购表状态未变为C，目前处于过度状态，确认后则不可更改
    @RequestMapping("/reassureUpdate")
    public String reassureUpdate(Model model, VoInfo voInfo, int purchaseId){
        double totalPrice = 0;
        List<DetailListPurchase> detailListPurchases = voInfo.getDetailListPurchases();
        Purchase purchase = purchaseService.getObjectById(purchaseId);
        int total = detailListPurchases.size();
        if(purchase.getState().equals("B")){
            try {
                detailListPurchases = detailPurchaseListService.updateDetailPurchaseListPrice(detailListPurchases);
                for(DetailListPurchase detailListPurchase:detailListPurchases){
                    totalPrice+=detailListPurchase.getBid()*detailListPurchase.getQuantity();
                }
                model.addAttribute("purchase", purchase);
                model.addAttribute("totalPrice", totalPrice);
                model.addAttribute("detailListPurchases",detailListPurchases);
                model.addAttribute("total",total);
                return"purchase/Purchase/reassure";
            }catch (Exception e){
                model.addAttribute("errorInfo", "系统故障，更新失败，请联系维护人员！");
                return "error";
            }
        }else{
            model.addAttribute("warnInfo", "该采购单已提交，如有错误，请联系仓库管理员！");
            return "warn.jsp";
        }
    }
    //
    @RequestMapping("/updateDetailPurchaseListQuantityOrDelete")
    public String updateDetailPurchaseListQuantityOrDelete(Model model,VoInfo voInfo){
        List<DetailListPurchase> detailListPurchaseList = voInfo.getDetailListPurchases();
        for(DetailListPurchase detailListPurchase:detailListPurchaseList){
            System.out.println(detailListPurchase.getProductId());
            System.out.println(detailListPurchase.getBid());
            System.out.println(detailListPurchase.getQuantity());
        }
        try{
            detailPurchaseListService.updateDetailPurchaseListQuantityOrDelete(detailListPurchaseList);
            return "success";
        }catch (Exception e){
            model.addAttribute("errorInFo", "订单修改失败！");
            return "error";
        }
    }
}
