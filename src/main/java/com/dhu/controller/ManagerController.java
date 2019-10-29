package com.dhu.controller;

import com.dhu.service.ManagerService;
import com.dhu.service.StaffService;
import com.dhu.util.Util;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Map;

@Controller
@RequestMapping("/managers")
public class ManagerController {
    @Resource
    private ManagerService managerService;
    @Resource
    private StaffService staffService;

    /**
     *
     * @return 分析设计界面
     */
    @RequestMapping("/analysisData")
    public ModelAndView analysisData() {
        ModelAndView modelAndView = new ModelAndView("manage/DataAnalysis");
        modelAndView.addObject("tC",managerService.countCustomer("A"));
        modelAndView.addObject("vC",managerService.countCustomer("V"));
        modelAndView.addObject("aC",managerService.countCustomer("T"));
        modelAndView.addObject("tS",managerService.countSupplier("A"));
        modelAndView.addObject("aS",managerService.countSupplier("T"));
        return modelAndView;
    }

    /**
     *
     * @return 返回员工利润折线图
     */
    @RequestMapping("/createStaffProfitChart")
    public ModelAndView createStaffProfitChart() {
        ModelAndView modelAndView = new ModelAndView("manage/CreateProfitChart");
        modelAndView.addObject("selecttype","true");

        modelAndView.addObject("charttype","staffProfitChart");
       // request.setAttribute("charttype", "staffProfitChart");
        modelAndView.addObject("stafflist",staffService.getAll());
        return modelAndView;
    }

    /**
     * 创建员工利润比较图
     * @return 创建员工利润比较图界面
     */
    @RequestMapping("/createStaffProfitCompareChart")
    public ModelAndView createStaffProfitCompareChart() {
        ModelAndView modelAndView = new ModelAndView("manage/CreateProfitChart");
        modelAndView.addObject("selecttype","false");
        modelAndView.addObject("charttype", "staffProfitCompareChart");
        modelAndView.addObject("stafflist",staffService.getAll());
        return modelAndView;
    }

    /**
     *
     * @param stime 开始时间
     * @param etime 结束时间
     * @param sid 员工id
     * @param method staffProfitCompareChart和staffProfitChart
     * @param request 请求域
     * @return 根据method返回
     */
    @RequestMapping("/staffProfitChart")
    public ModelAndView staffProfitChart(@RequestParam("stime")String stime,
                                   @RequestParam("etime")String etime,
                                   @RequestParam(value = "sid",required = false)String sid,
                                    @RequestParam("method")String method,
                                         HttpServletRequest request) {
        ModelAndView modelAndView = new ModelAndView("manage/StaffProfitChart");
        if("staffProfitChart".equals(method)){
            String data = "<h1>ERROR</h1>";
            String tmps;

            Date date = new Date();
            Calendar calendar = Calendar.getInstance();

            int tpi = 0;
            Map<Timestamp, Double> points = managerService.findProfitPoints(Util.str2TimeStamp(stime),
                    Util.str2TimeStamp(etime), sid);
            tmps = "";
            for (Timestamp tp : points.keySet()) {
                date = tp;
                System.out.println(date.toString());
                calendar.setTime(date);
                System.out.println(calendar.toString());
                tpi = calendar.get(Calendar.YEAR);
                tmps += String.valueOf(tpi);
                tmps += "*";
                tpi = calendar.get(Calendar.MONTH);
                tmps += String.valueOf(tpi);
                tmps += "*";
                tpi = calendar.get(Calendar.DATE);
                tmps += String.valueOf(tpi);
                tmps += "*";
                tmps += String.valueOf(points.get(tp));
                tmps += "|";
            }
            if (!tmps.equals(""))
                tmps = tmps.substring(0, tmps.length() - 1);
            data = tmps;
            modelAndView.addObject("datas",data);
            modelAndView.addObject("stid",sid);
            return modelAndView;
        }else {
            String datax = "";
            String datay = "";
            String tmpx, tmpy;
            modelAndView.setViewName("manage/StaffProfitCompareChart");
            int tpi = 0;
            Map<Integer, Double> points = managerService.findProfitPoints(Util.str2TimeStamp(stime),
                    Util.str2TimeStamp(etime), request.getParameterMap());
            tmpx = tmpy = "";
            for (Integer tp : points.keySet()) {
                tmpx += tp.toString();
                tmpx += "*";
                tmpy += points.get(tp).toString();
                tmpy += "*";
            }
            datax = tmpx.substring(0, tmpx.length() - 1);
            datay = tmpy.substring(0, tmpy.length() - 1);
            modelAndView.addObject("datax",datax);
            modelAndView.addObject("datay",datay);
            return modelAndView;
        }
    }

    @RequestMapping("/addnews")
    public String addNews(){
        return "manage/AddNews";
    }
}
