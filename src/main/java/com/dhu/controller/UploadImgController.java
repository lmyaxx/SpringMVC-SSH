package com.dhu.controller;

import org.apache.commons.io.FilenameUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.UUID;



@Controller
public class UploadImgController {

    @RequestMapping(value = "uploadImg")
    @ResponseBody
    public String getUploadFile(String addr,HttpServletRequest request, HttpServletResponse response) {
        System.out.println("fucking spring3 MVC upload file with Multipart form");
        String myappPath = request.getSession().getServletContext().getRealPath("/");
        String upfileurl=null;
        try {
            if (request instanceof MultipartHttpServletRequest) {
                MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
                System.out.println("fucking spring3 MVC upload file with Multipart form");
                MultipartFile file = multipartRequest.getFiles("file").get(0);
                long size = file.getSize();
                byte[] data = new byte[(int) size];
                InputStream input = file.getInputStream();
                input.read(data);

                String name = UUID.randomUUID().toString().replace("-", "");
                //System.out.println(name);
                String ext = FilenameUtils.getExtension(file.getOriginalFilename());
                //System.out.println(ext);
                File outFile = new File(myappPath + File.separator +"images"+File.separator+addr+File.separator+ name+"."+ext);
                if(!outFile.exists()) {
                    outFile.createNewFile();
                    upfileurl=name+"."+ext;

                    System.out.println("full path = " + outFile.getAbsolutePath());
                } else {
                    upfileurl=name+"."+ext;
                    System.out.println("full path = " + outFile.getAbsolutePath());
                }
                FileOutputStream outStream = new FileOutputStream(outFile);
                outStream.write(data);
                outStream.close();
                input.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "{"+"\"key\":\"true\""+",\"url\":\"/images/"+addr+"/"+upfileurl+"\"}";
    }

    @RequestMapping("uploadNewsImg")
    @ResponseBody
    public String uploadNewsImg(@RequestParam(value="file",required=false) MultipartFile file, HttpServletRequest request, HttpServletResponse response) throws Exception {
        //保存上传
        OutputStream out = null;
        InputStream fileInput=null;
        String myappPath = request.getSession().getServletContext().getRealPath("/");
        String upfileurl=null;
        try{
            if(file!=null){

                String name = UUID.randomUUID().toString().replace("-", "");
                String ext = FilenameUtils.getExtension(file.getOriginalFilename());
                File outFile = new File(myappPath + File.separator +"images"+File.separator+"news"+File.separator+ name+"."+ext);
                //打印查看上传路径
                System.out.println(outFile.getAbsolutePath());
                upfileurl=outFile.getName();
                if(!outFile.getParentFile().exists()){
                    outFile.getParentFile().mkdirs();
                }
                file.transferTo(outFile);
            }
        }catch (Exception e){
        }finally{
            try {
                if(out!=null){
                    out.close();
                }
                if(fileInput!=null){
                    fileInput.close();
                }
            } catch (IOException e) {
            }
        }
        return "{" +
                "  \"code\": 0" +
                "  ,\"msg\": \"\"" +
                "  ,\"data\": {" +
                "    \"src\": \""+
                upfileurl+
                "\"" +
                "  }" +
                "} ";

    }

}
