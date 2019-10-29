package com.dhu.controller;


import com.dhu.pojo.DetailListSale;
import com.dhu.pojo.Product;
import com.dhu.service.DetailListSaleService;
import com.dhu.service.ProductService;
import com.dhu.vo.VoInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/product")
public class ProductController {
    @Resource
    private ProductService productService;
    @Resource
    private DetailListSaleService detailListSaleService;




    /**
     *
     * @return 产品管理界面
     */
    @RequestMapping("/manageProduct")
    public ModelAndView manageProduct(){
        ModelAndView modelAndView = new ModelAndView("manage/ProductManage");
        List<Product> productlist = productService.findAllProduct();
        modelAndView.addObject("productlist",productlist);
        return modelAndView;
    }

    /**
     *批量修改产品
     * @param request
     * @return 成功 返回成功页面，失败 返回失败页面
     */
    @RequestMapping("/editProduct")
    public String editProduct(HttpServletRequest request) {
        if (productService.editProducts(request.getParameterMap())) {
            return "redirect:/product/manageProduct";
        } else {
            request.setAttribute("errorInFo", "编辑产品信息失败！");
            return "error";
        }
    }


    //获取所有产品，返回产品信息页面，这里并未排序
    @RequestMapping("/getAllProducts")
    public String getAllProducts(Model model){
        List<Product> products = productService.getAll();
        model.addAttribute("products",products);
        return "warehouse/ProductInfo";
    }
    //返回所有小于等于警戒线times倍的产品，并根据quantity/alertline升序排列
    @RequestMapping("/getProdcutsBelowAlertline")
    public String getProdcutsBelowAlertline(Model model,@RequestParam(value = "times",required = false) Integer times){
        //修改版1
        if (times == null){
            times = 0;
        }
        System.out.print("hhhhhhhhhhhhhhhh");
        System.out.println(times);
        List<Product> products = productService.getProductsBelowAlertline(times);
        model.addAttribute("products",products);
        return "warehouse/ProductInfo";
    }
    //根据id列表返回相应的产品列表
    @RequestMapping("/getProductsByListOfId")
    public String getProductsByListOfId(Model model,VoInfo voInfo){
        List<Integer> keys = voInfo.getKeys();
        List<Product> products = new ArrayList<Product>();
        for(int id:keys){
            products.add(productService.getObjectById(id));
        }
        model.addAttribute("selected",products);
        return "warehouse/CreateNewPurchaseList";
    }

    /**
     * 点击填写订单，进入该方法,查询大于0的产品
     * @return 返回产品列表
     */
    @RequestMapping("/findAllProduct")
    public ModelAndView findAllProduct(){
        List<Product> pList = productService.findAllProduct();
        ModelAndView modelAndView = new ModelAndView("sale/product/list");
        modelAndView.addObject("pList",pList);
        return modelAndView;
    }


    /**
     * 这里没有添加分页，可能还需要进行修改
     *接受页面的搜索框中的输入，
     * @return  返回符合查询条件的产品
     */
    @RequestMapping("/findAllProductByName")
    public ModelAndView findAllProductByName1(@RequestParam("name")String name){
        List<Product> pList = productService.findAllProductByName(name);
        ModelAndView modelAndView = new ModelAndView("sale/product/list");
        modelAndView.addObject("pList",pList);
        return modelAndView;
    }

    private final int maxResults = 16;

    /**
     * 分页显示所有商品
     * @param pageIndex 当前页码数
     * @return 返回商品显示页面
     */
    @RequestMapping("/getProductListByPage")
    public ModelAndView  getProductListByPage(@RequestParam(value = "pageIndex",required = false)Integer pageIndex){

        ModelAndView modelAndView = new ModelAndView("ecommerce/main");
        if (pageIndex==null){
            pageIndex=1;
        }
        int maxPage = productService.getMaxPage(pageIndex,maxResults);

        if(pageIndex<1){
            pageIndex=1;
        }
        if(pageIndex>maxPage){
            pageIndex=maxPage;
        }
        //设置每页商品的最大数目是40
        List<Product> pList = productService. getProductListByPage(pageIndex,maxResults);
        modelAndView.addObject("itemlist",pList);
        System.out.println(pageIndex);
        modelAndView.addObject("pageIndex",pageIndex);
        modelAndView.addObject("method","getProductListByPage");
        return modelAndView;
    }

    /**
     * 在产品详情界面应该对客户提交的购买数目进行验证，
     * 不能大于库存和小于1
     * 根据客户点击的产品编号，得到该产品的详细信息，以及顾客对该产品的评价信息
     * @param productID 产品编号
     * @return 返回产品信息和评价信息
     */
    @RequestMapping("/getProductDetailInfo")
    public ModelAndView getProductDetailInfo(@RequestParam("productId")Integer productID){
        ModelAndView modelAndView = new ModelAndView("ecommerce/productdetail");
        Product product = productService.getObjectById(productID);
        List<DetailListSale> detailListSales = detailListSaleService.getCommentByProductId(productID);
        modelAndView.addObject("product",product);
        modelAndView.addObject("detailListSales",detailListSales);
        return modelAndView;
    }

    /**
     * 这里本来不打算分页，但是页面下方有分页按钮，所以必须分页,使用这种方法进行分页，
     * 需要根据不同的页面改变url格式
     * 根据填写的价格范围，进行显示产品，前端不需要判断两个
     * 价格的大小关系
     * @param minPrice
     * @param maxPrice
     * @param pageIndex
     * @return
     */
    @RequestMapping("/getProductByPrice")
    public ModelAndView getProductByPrice(@RequestParam("minPrice")Double minPrice,
                                          @RequestParam("maxPrice")Double maxPrice,
                                          @RequestParam("pageIndex")Integer pageIndex){
        //此处填入视图名字
        ModelAndView modelAndView = new ModelAndView("sale/product/list");
        int maxPage = productService.getMaxPageByPrice(minPrice,maxPrice,pageIndex,maxResults);
        if(pageIndex<1){
            pageIndex=1;
        }
        if(pageIndex>maxPage){
            pageIndex=maxPage;
        }
        List<Product> pList = productService.getProductByPrice(minPrice,maxPrice,pageIndex,maxResults);
        modelAndView.addObject("pList",pList);
        modelAndView.addObject("pageIndex",pageIndex);
        modelAndView.addObject("method","getProductByPrice");
        return modelAndView;

    }

    /**
     * 根据产品的标签进行查询
     * @param label
     * @param pageIndex
     * @return
     */
    @RequestMapping("/getProductByBrandLabel")
    public ModelAndView getProductByBrandLabel(@RequestParam("label")String label
            ,@RequestParam("pageIndex")Integer pageIndex){
        ModelAndView modelAndView = new ModelAndView();
        int maxPage = productService.getMaxPageByLabel(label,pageIndex,maxResults);
        if(pageIndex<1){
            pageIndex=1;
        }
        if(pageIndex>maxPage){
            pageIndex=maxPage;
        }
        List<Product> pList = productService.getProductByBrandLabel(label,pageIndex,maxResults);
        modelAndView.addObject("pList",pList);
        modelAndView.addObject("pageIndex",pageIndex);
        modelAndView.addObject("method","getProductByBrandLabel");
        return modelAndView;
    }
    /**
     * 这里没有添加分页，可能还需要进行修改
     *接受页面的搜索框中的输入，
     * @return  返回符合查询条件的产品
     */
    @RequestMapping("/findProductByName")
    public ModelAndView findProductByName(@RequestParam("name")String name,
                                          @RequestParam("pageIndex")Integer pageIndex){
        System.out.println(name);
        int maxPage = productService.getMaxPageByName(pageIndex,maxResults,name);
        if(pageIndex<1){
            pageIndex=1;
        }
        if(pageIndex>maxPage){
            pageIndex=maxPage;
        }
        List<Product> pList =  productService.findProductByName(pageIndex,maxResults,name);
        ModelAndView modelAndView = new ModelAndView("ecommerce/main");
        modelAndView.addObject("itemlist",pList);
        modelAndView.addObject("pageIndex",pageIndex);
        modelAndView.addObject("method","findProductByName");
        modelAndView.addObject("name",name);
        return modelAndView;
    }

    @ResponseBody
    @RequestMapping("/findProductByJson")
    public List<String> findProductByJson(){
        List<Product> pList = productService.findAllProduct();
        List<String> strings = new ArrayList<>();
        for (Product product:pList){
            strings.add(product.getName());
        }
        return strings;
    }
}
