package com.dhu.util;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;


public class AccessControl implements HandlerInterceptor {
    private List<String> excludedUrls;

    public List<String> getExcludedUrls() {
        return excludedUrls;
    }

    public void setExcludedUrls(List<String> excludedUrls) {
        this.excludedUrls = excludedUrls;
    }


    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
//        String requestUrl = request.getRequestURI();
//        System.out.println(requestUrl+"       123    ");
//        if (requestUrl.equals("/index")){
//            return true;
//        }
//        for (String url : excludedUrls) {
//            System.out.println(url);
//            if (requestUrl.indexOf(url)>=0) {
//                System.out.println(requestUrl+"    1234          ");
//                return true;
//            }
//        }
//        String path = request.getServletPath();
//        System.out.println(path);
//        if (path.indexOf("ecommerce")>0){
//            return true;
//        }
//        HttpSession session = request.getSession();
//        Staff staff = (Staff)session.getAttribute("existUser");
//        Customer customer = (Customer)session.getAttribute("user");
//        if (customer!=null&&requestUrl.indexOf("sale")>=0){
//            return true;
//        }
//        if (customer!=null&&requestUrl.indexOf("detailListSale")>=0){
//            return true;
//        }
//
//        if (staff==null){
//            response.sendRedirect(request.getContextPath()+"/index");
//            return false;
//        }
//        System.out.println(requestUrl);
        return true;
    }

    @Override
    public void  postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
                           ModelAndView modelAndView) throws Exception {
//       if (modelAndView!=null){
//           // handler执行之后，返回ModelAndView之前
//           String viewName = modelAndView.getViewName();
//           HttpSession session = request.getSession();
//           Staff staff = (Staff)session.getAttribute("existUser");
//           if (viewName!=null){
//
//               if (staff!=null){
//                   if (staff.getJob()=="S"){
//                       if (viewName.lastIndexOf("sale")==-1){
//                           response.sendRedirect(request.getContextPath()+"/index");
//                       }
//                   }
//                   else if(staff.getJob()=="M"){
//                       if (viewName.lastIndexOf("manage")==-1){
//                           response.sendRedirect(request.getContextPath()+"/index");
//                       }
//                   }
//                   else if(staff.getJob()=="B"){
//                       if (viewName.lastIndexOf("purchase")==-1){
//                           response.sendRedirect(request.getContextPath()+"/index");
//                       }
//                   }
//                   else if(staff.getJob()=="W"){
//                       if (viewName.lastIndexOf("warehouse")==-1){
//                           response.sendRedirect(request.getContextPath()+"/index");
//                       }
//                   }
//               }
//           }
     //  }
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
            throws Exception {
        System.out.println(request.getRequestURI());
        // 返回ModelAndView之后。
        //响应用户之后。

    }

}
