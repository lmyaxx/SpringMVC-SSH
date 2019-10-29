package com.dhu.controller;

import com.dhu.pojo.Product;
import com.dhu.pojo.Supplier;
import com.dhu.service.ProductService;
import com.dhu.service.SupplierService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.Collection;
import java.util.Collections;
import java.util.List;

@Controller
@RequestMapping("/supplier")
public class SupplierController {

    @Resource
    private SupplierService supplierService;

    @Resource
    private ProductService productService;

    /***************************************对Supplier进行操作**Begin**********************************************/

    //查询通过名称模糊查询某个供应商的产品
    @RequestMapping("/getProductsOfSupplierByName")
    public String getProductsOfSupplierByName(Model model,int supplierId,String productName){
        List<Product> products = productService.getProductByName(productName,supplierId);
        int total = products.size();
        model.addAttribute("total",total);
        model.addAttribute("products",products);
        model.addAttribute("supplierId",supplierId);
        return "purchase/Supplier/products";
    }
    //为某供应商商添加产品
    @RequestMapping("/addProduct")
    @ResponseBody
    public String addProduct(Model model, HttpServletRequest request , Product product, int supplierId, MultipartFile fileToUpload) throws IOException {
        if (fileToUpload != null) {
            String name = fileToUpload.getOriginalFilename();
            String suffix=name.substring(name.lastIndexOf(".")+1);
            String realPath = request.getSession().getServletContext().getRealPath("/");
            //获取下一产品的id作为图片名
            Integer id = (int) productService.getNextId(Product.class);
            //获取文件名
            String imagePath = realPath+"images/productPhoto/"+id.toString()+"."+suffix;
            //服务器存图片
            fileToUpload.transferTo(new File(imagePath));
            //数据库保存图片名
            product.setPicId(id.toString());
            product.setId(id);
            product.setSupplierId(supplierId);
            productService.save(product);
        }
        return "success";
    }

    //显示所有供应商以及其数量
    @RequestMapping("/getAllSuppliers")
    public String getAllSuppliers(Model model){
        List<Supplier> suppliers = supplierService.getAll();
        Collections.reverse(suppliers);
        int total = suppliers.size();
        model.addAttribute("total",total);
        model.addAttribute("suppliers",suppliers);
        return "purchase/Supplier/list";
    }

    //为供应商新增产品，返回增加产品的页面
    @RequestMapping("/getAddProductPage")
    public String getAddProductPage(Model model,int supplierId){
        Supplier supplier = supplierService.getObjectById(supplierId);

        model.addAttribute("supplier",supplier);
        return "purchase/Supplier/addProduct";
    }
    //根据名称和状态查询出相应供应商
    @RequestMapping("/getSuppliersByNameAndState")
    public String getSuppliersByNameAndState(Model model,String name,String state){
        List<Supplier> suppliers= supplierService.getSuppliersByNameAndState(name, state);
        int total = suppliers.size();
        model.addAttribute("total",total);
        model.addAttribute("suppliers",suppliers);
        return "purchase/Supplier/list";
    }
    //获取新增供应商页面
    @RequestMapping("/getAddSupplierPage")
    public String getAddSupplierPage(){
        return "purchase/Supplier/add";
    }
    //新增供应商
    @RequestMapping("/addSupplier")
    public String addSupplier(Model model,Supplier supplier){
        try {
            supplierService.save(supplier);
            return "redirect:/supplier/getAllSuppliers";
        }catch (Exception e){
            e.printStackTrace();
            model.addAttribute("errorInfo","系统故障，添加失败，请联系维护人员！");
            return "error";
        }
    }
    //获取某id供应商的所有产品
    @RequestMapping("/getProductsBySupplier")
    public String getProductsBySupplier(Model model,int supplierId) {
        Supplier supplier = supplierService.getObjectById(supplierId);
        Collection<Product> products = supplier.getProductsById();
        int total = products.size();
        model.addAttribute("products", products);
        model.addAttribute("total", total);
        model.addAttribute("supplierId", supplierId);
        return "purchase/Supplier/products";
    }
    @RequestMapping("/getUpdateSupplierPage")
    public String getUpdateSupplierPage(Model model,Integer supplierId){
        Supplier supplier = supplierService.getObjectById(supplierId);
        model.addAttribute("supplier",supplier);
        return "purchase/Supplier/edit";
    }
    @RequestMapping("/updateSupplier")
    public String updateSupplier(Model model,Supplier supplier){
        try {
            supplierService.update(supplier);
            return "success";
        }catch (Exception e){
            e.printStackTrace();
            model.addAttribute("errorInfo","系统故障，更新失败，请联系维护人员！");
            return "error";
        }
    }

}
