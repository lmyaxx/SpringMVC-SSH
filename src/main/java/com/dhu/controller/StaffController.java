package com.dhu.controller;

import com.dhu.pojo.Customer;
import com.dhu.pojo.Product;
import com.dhu.pojo.Staff;
import com.dhu.service.ProductService;
import com.dhu.service.StaffService;
import com.dhu.util.Md5;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.List;
import java.util.Map;


@Controller
@SessionAttributes(value = {"existUser","customer"})
@RequestMapping("/staff")
public class StaffController {

    @Resource
    private StaffService staffService;

    @Resource
    private ProductService productService;

    @RequestMapping("/addUser")
    public ModelAndView addPerson(int id){
        Staff staff = staffService.getObjectById(id);


        //查数据
      System.out.println(staff.getName());

        //存起来
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.setViewName("success");
        modelAndView.addObject("staff", staff);
        return modelAndView;
    }
    @RequestMapping("/getProductById")
    public ModelAndView getProductById(int id){
        Product product = productService.getObjectById(id);


        //查数据
        System.out.println(product.getName());

        //存起来
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.setViewName("success");
        modelAndView.addObject("product", product);
        return modelAndView;
    }

    /**
     * 写词方法目的是为了其它模块测试使用，无实际价值
     * @param username
     * @param password
     * @return
     */
    @RequestMapping("/login")
    public ModelAndView login(@RequestParam(value = "username",required = false)Integer username,
                              @RequestParam(value = "password" ,required = false)String password,
                                Map<String,Object>map) throws UnsupportedEncodingException, NoSuchAlgorithmException {
        if(username==null||password==null){
            return new ModelAndView("login/login");
        }
        System.out.println(username);
        Staff staff = staffService.getObjectById(username);
        ModelAndView modelAndView = new ModelAndView();
        if(username==staff.getId()&&Md5.checkpassword(password,staff.getPw())){
            map.put("existUser",staff);
            Customer customer = new Customer();
//            customer.setId(1001);
            map.put("customer",customer);
            if(staff.getJob().equals("S")){
                modelAndView.addObject("stafftype","S");
                modelAndView.addObject("staff",staff);
                modelAndView.setViewName("main");
            }
            else if(staff.getJob().equals("M")){
                modelAndView.addObject("stafftype","M");
                modelAndView.addObject("staff",staff);
                modelAndView.setViewName("main");
            }
            else if(staff.getJob().equals("W")){
                modelAndView.addObject("stafftype","W");
                modelAndView.addObject("staff",staff);
                modelAndView.setViewName("main");
            }
            else if(staff.getJob().equals("B")){
                modelAndView.addObject("stafftype","B");
                modelAndView.addObject("staff",staff);
                System.out.println("B");
                modelAndView.setViewName("main");
            }
        }
        else{
            modelAndView.addObject("msg","用户名或者密码错误");
            modelAndView.setViewName("login/login");
        }
        return modelAndView;
    }

    /**
     * 点击经理模块的员工管理进入这个方法，查询所有员工
     * @return 员工列表
     */
    @RequestMapping("/staffManage")
    public ModelAndView staffManage(){
        ModelAndView modelAndView = new ModelAndView("manage/StaffManage");
        List<Staff> stafflist = staffService.getAll();
        modelAndView.addObject("stafflist",stafflist);
        return modelAndView;
    }

    /**
     *
     * @return 添加员工界面
     */
    @RequestMapping("/getAddStaffViewer")
    public String getAddStaffViewer(){
        return "manage/AddStaff";
    }

    /**
     * 在管理员工界面点击确认修改后进入这个方法
     * @param request 获取前端数据
     * @return 成功，返回员工管理页面 失败，返回失败页面
     */
    @RequestMapping("/updateStaffInfo")
    public ModelAndView updateStaffInfo(HttpServletRequest request){

        ModelAndView modelAndView = new ModelAndView("redirect:/staff/staffManage");
        //修改成功之后返回员工管理界面
        System.out.println(request.getParameterMap().size());
        try {
            if(staffService.updateStaffList(request.getParameterMap())){
                return modelAndView;
            }
            else{
                modelAndView.setViewName("error");
                return modelAndView;
            }
        }catch (Exception e){
            System.out.println(e);
            modelAndView.setViewName("error");
            return modelAndView;
        }
    }

    /**
     * 批量提价员工
     * @param request
     * @return 成功返回成功页面，失败返回，失败页面
     */
    @RequestMapping("/addStaffs")
    public ModelAndView addStaffs(HttpServletRequest request){
        ModelAndView modelAndView = new ModelAndView();
        try{
            if(staffService.addStaffs(request.getParameterMap())){
                modelAndView.setViewName("redirect:/staff/staffManage");
            }
            else {
                modelAndView.setViewName("error");
            }
        }catch (Exception e){
            System.out.println(e);
            modelAndView.setViewName("error");
            return modelAndView;
        }
        return modelAndView;
    }
    @RequestMapping("/logout")
    public String logout(HttpSession session){
        session.setAttribute("stafflist",null);
        return "redirect:/staff/staffLogin";
    }

    @RequestMapping("/main_welcome")
    public String returnMain_welcome(){
        return "main_welcome";
    }

    @RequestMapping("/userInfo")
    public String userDetail(ModelMap map,Integer id){
        //Staff staff = (Staff)map.get("staff");
        Staff staff = staffService.getObjectById(id);
        map.put("staff",staff);
        return "/login/userinfo";
    }

    @RequestMapping("/staffLogin")
    public String loginView(){
        return "login/login";
    }

    @RequestMapping("/alterPassword")
    public String alterPassword(@RequestParam(value = "id",required = false) Integer id,
                                @RequestParam(value = "rePassword",required = false) String rePassword) throws UnsupportedEncodingException, NoSuchAlgorithmException {
        if (id!=null&&rePassword!=null){
            Staff staff = staffService.getObjectById(id);
            staff.setPw(Md5.EncoderByMd5(rePassword));
            staffService.update(staff);
        }
        return "redirect:/staff/staffLogin";
    }


}
