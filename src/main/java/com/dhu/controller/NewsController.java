package com.dhu.controller;

import com.dhu.pojo.News;
import com.dhu.service.NewsService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

@Controller
@RequestMapping("/news")
public class NewsController {
    @Resource
    private NewsService newsService;
    //添加新闻，返回成功信息
    @RequestMapping("/addNews")
//    @ResponseBody
    public String addNews(Model model, HttpServletRequest request, String title,String img,String content) throws IOException {
        //新建一个空news并插入各种数据
        News news=new News();
        news.setPicId(img);
        Timestamp releaseTime  = new Timestamp(System.currentTimeMillis());
        news.setReleaseTime(releaseTime);
        content=content.substring(50,content.length()-17);
        news.setContent(content);
        news.setTitle(title);
        //获取下一条新闻的id
        Integer id = (Integer) newsService.getNextId(News.class);
        news.setNewsId(id);
        newsService.save(news);

        return "redirect:/news/getLatestFiveNews";

//        if (fileToUpload != null) {
//                String name = fileToUpload.getOriginalFilename();
//                String suffix=name.substring(name.lastIndexOf(".")+1);
//                String realPath = request.getSession().getServletContext().getRealPath("/");
//                //保存发布时间
//                Timestamp releaseTime  = new Timestamp(System.currentTimeMillis());
//                news.setReleaseTime(releaseTime);
//                //获取下一条新闻的id
//                Integer id = (Integer) newsService.getNextId(News.class);
//                //获取文件名
//                String imagePath = realPath+"images/newsPhoto/"+id.toString()+"."+suffix;
//               //服务器存图片
//                fileToUpload.transferTo(new File(imagePath));
//                //数据库保存图片名
//                news.setPicId(id.toString());
//                newsService.save(news);
//            }
//            return "success";
    }
    @RequestMapping("/main_welcome")
    public String main_welcome(){
        return "main_welcome";
    }
//    public String addNews(String title,Integer isoffical,String content,String img, HttpSession httpSession, Model mv)
//    {
//        User user=(User)httpSession.getAttribute("currentuser");
//        Integer type=0;
//        if (user==null) return "error";
//        News news=new News();
//        news.setPublishername(user.getUsername());
//        news.setPublisher(user.getId());
//        news.setTitle(title);
//        if (img!=null && !img.equals("")){
//            news.setImg(img);
//            type|=4;
//        }
//        if (isoffical!=null && isoffical==1) type|=2;
//        news.setType(type);
//        System.out.println(type);
//        content=content.substring(50,content.length()-17);
//        System.out.println(content);
//        news.setContent(content);
//        if (newsService.addNews(news)) return "redirect:newsList?page=1";
//        else return "error";
//
//
//    }
    //删除新闻
    @RequestMapping("/deleteNewsById")
    @ResponseBody
    public String deleteNewsById(Integer newsId){
        newsService.delete(newsId);
        return "redirect:/news/main_welcome";
    }
    //根据id获取某条详细新闻
    @RequestMapping("/getNewsById")
    public String getNewsById(Model model,Integer newsId){
        News news = newsService.getObjectById(newsId);
        model.addAttribute("news",news);
        return "manage/News";
    }
    //获取最新5条新闻，用于轮播界面，返回主界面main轮播
    @RequestMapping("/getLatestFiveNews")
    public String getLatestFiveNews(Model model){
        List<News> newsList = newsService.getLatestFiveNews();
        model.addAttribute("newsList",newsList);
        return "forward:/news/main_welcome";
    }

    //分页获取新闻，返回新闻列表界面；
    @RequestMapping("/getNewsByPageAndSize")
    public String getNewsByPageAndSize(Model model,Integer page,Integer size){
        Long number1 = newsService.getNewsNum();
        if(page==0)
            page=1;
        Double number = number1 /1.0;
        //正常，3条记录，size=4，page=1，最终page=1
        //越界，3条记录，size=4，page=2，最终page=1
        //5条记录，size=4，page=1，最终
        if(number/size+1<=page)
            page=page-1;
        List<News> newsList = newsService.getNewsByPageAndSize(page,size);
        model.addAttribute("newsList",newsList);
        model.addAttribute("page",page);
        return "manage/NewsList";
    }

}
