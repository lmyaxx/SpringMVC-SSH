package com.dhu.service;

import com.dhu.pojo.Staff;
import com.dhu.util.Md5;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.Map;
import java.util.Set;

@Service
public class StaffService extends BaseService<Staff> {

    /**
     * 批量更新员工信息
     * @param map
     * @return 成功，返回true，失败，返回false
     */
    @Transactional
    public boolean updateStaffList(Map<String,String[]> map) throws UnsupportedEncodingException, NoSuchAlgorithmException {
        Set<String> set = map.keySet();

        for(String id:set){
            if(id.charAt(0)=='i'){
                Staff staff = new Staff();
                String data = map.get(id)[0];
                String[] info;
                info=data.split(",");  //分解信息串
                //0：用户姓名  1：性别  2：用户职务  3：用户手机号  4：用户密码  5：用户地址
                staff.setId(Integer.parseInt(id.substring(2)));
                if (info.length<5) return false;
                else if (info[4].equals("")) return false;  //密码为空，返回错误
                if (info.length>=1)staff.setName(info[0]);
                if (info.length>=2)staff.setSex(info[1]);
                if (info.length>=3)staff.setJob(info[2]);
                if (info.length>=4)staff.setPhone(info[3]);
                if (info.length>=5)staff.setPw(Md5.EncoderByMd5(info[4]));
                if (info.length>=6)staff.setAddr(info[5]);
                this.update(staff);//调用父类更新方法
            }
        }
        return true;
    }

    /**
     * 批量插入员工信息
     * @param map
     * @return 成功，返回true，失败，返回false
     */
    @Transactional
    public boolean addStaffs(Map<String,String[]>map) throws UnsupportedEncodingException, NoSuchAlgorithmException {
        Set<String> set = map.keySet();
        Staff staff = new Staff();
        for(String id:set){
            if(id.charAt(0)=='i'){
                String data = map.get(id)[0];
                String[] info;
                info=data.split(",");  //分割信息串
                if (info.length>=5){  //判断密码是否为空
                    if (info[4].equals("")) return false;  //密码为空返回添加失败
                    staff.setId(Integer.parseInt(id.substring(2)));
                    staff.setName(info[0]);
                    staff.setJob(info[2]);
                    staff.setPw(Md5.EncoderByMd5(info[4]));
                    staff.setSex(info[1]);
                    staff.setPhone(info[3]);
                    if (info.length>=6)staff.setAddr(info[5]);
                    this.save(staff);//调用父类插入方法

                }
            }
        }
        return true;
    }
}
