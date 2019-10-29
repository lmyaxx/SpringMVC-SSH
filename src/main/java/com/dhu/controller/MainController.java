package com.dhu.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {
    @RequestMapping("index")
    public String toIndex(){
        return "forward:/staff/login";
    }

    @RequestMapping("main_welcome")
    public String welcome(){
        return "redirect:/news/getLatestFiveNews";
    }
}

