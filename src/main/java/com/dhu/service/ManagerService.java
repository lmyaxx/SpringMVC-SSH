package com.dhu.service;

import com.dhu.dao.*;
import com.dhu.pojo.*;
import org.apache.maven.artifact.versioning.Restriction;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

@Service
public class ManagerService {
    @Resource
    private CustomerDao customerDao;
    @Resource
    private SupplierDao supplierDao;
    @Resource
    private StaffDao staffDao;
    @Resource
    private DetailListSaleDao detailListSaleDao;

    @Resource
    private SaleDao saleDao;

    //分类统计客户个数（A:全部客户      V：VIP客户     T：活跃客户）
    //成功：某类客户个数
    //失败：0或报错
    public int countCustomer(String type){ //T V A
        try {
            int cnt=0;
            if (type=="A"){
                cnt=customerDao.getAll(Customer.class).size();
            }
            else if (type=="V"){
                cnt=customerDao.getObjectsByDetachedCriteria(
                        DetachedCriteria.forClass(Customer.class).add(
                                Restrictions.eq("vip",1)
                        )
                ).size();
            }
            else if (type=="T"){
                cnt=customerDao.getObjectsByDetachedCriteria(
                        DetachedCriteria.forClass(Customer.class).add(
                                Restrictions.eq("state","F")
                        )
                ).size();
            }
            else{
                cnt=0;
            }
            return cnt;
        }
        catch(Exception e){
            throw e;
        }
    }

    //分类统计供应商个数（A:全部      T：活跃）
    //成功：某类供应商个数
    //失败：0或报错
    public int countSupplier(String type){ //T A
        try {
            int cnt=0;
            if (type=="A"){
                cnt=supplierDao.getAll(Supplier.class).size();
            }
            else if (type=="T"){
                cnt=supplierDao.getObjectsByDetachedCriteria(
                        DetachedCriteria.forClass(Supplier.class).add(
                                Restrictions.eq("state","T")
                        )
                ).size();
            }
            else{
                cnt=0;
            }
            return cnt;
        }
        catch(Exception e){
            throw e;
        }
    }

    //计算总进价
    //成功：总进价
    //失败：0.0或报错
    private double getTotalBid(String salelistid){
        try {
            double totalbid= 0.0;
            Sale sale=saleDao.getObjectById(Integer.parseInt(salelistid),Sale.class);
            for (DetailListSale detailListSale:sale.getDetailListSalesById()){
                totalbid += detailListSale.getProductByProductId().getBid();
            }
            return totalbid;
        }
        catch(Exception e){
            throw e;
        }
    }


    //计算某个订单的利润
    //成功：该订单的利润
    //失败：0.0或报错
    private double getProfit(String salelistid){
        try {
            double profit=0.0;
            double totalbid=getTotalBid(salelistid);
            //计算利润
            profit=saleDao.getObjectById(Integer.parseInt(salelistid),Sale.class)
                    .getTotalPrice()-totalbid;
            return profit;
        }
        catch(Exception e){
            throw e;
        }
    }

    //计算某段时间，某个销售员的利润
    //成功：某个销售员在某段时间的利润
    //失败：0.0或报错
    public double findProfit(Timestamp starttime,Timestamp endtime,String salerid){
        try{
            double profit=0.0;
            Staff staff=staffDao.getObjectById(Integer.parseInt(salerid),Staff.class);
            //核查是否为销售员
            if (staff==null){
                return profit;
            }
            else if(!staff.getJob().equals("S")){
                return profit;
            }
            //求利润和
            List<Sale> lists=null;
            if (starttime.toString().equals(endtime.toString())){ //判断是否为异常情况（未选择 或 选择了时间点）
                lists=saleDao.getObjectsByDetachedCriteria(
                        DetachedCriteria.forClass(Sale.class).add(
                                Restrictions.eq(
                                        "staffBySalerId",
                                        staff
                                )
                        )
                );
            }
            else if(starttime.before(endtime)){  //选择了时间段
                lists=saleDao.getObjectsByDetachedCriteria(DetachedCriteria.forClass(Sale.class).add(
                        Restrictions.and(
                                Restrictions.ge("time",starttime),
                                Restrictions.le("time",endtime)
                        )
                ));
            }
            else{ //选择了时间段，但start和end反了
                lists=saleDao.getObjectsByDetachedCriteria(DetachedCriteria.forClass(Sale.class).add(
                        Restrictions.and(
                                Restrictions.ge("time",endtime),
                                Restrictions.le("time",starttime)
                        )
                ));
            }
            for (Sale list:lists){ //遍历去掉销售员不匹配的
                if(list.getStaffBySalerId().getId()==staff.getId()) profit+=getProfit(list.getId()+"");
            }
            return profit;
        }
        catch(Exception e){
            throw e;
        }
    }

    //计算某段时间，某些销售员的利润折线
    //成功：某些销售员在某段时间的利润折线
    //失败：null或报错
    public Map<Integer,Double> findProfitPoints(Timestamp starttime,Timestamp endtime,Map<String,String[]> set){
        Map<Integer,Double> points=new TreeMap<Integer,Double>();  //TreeMap自动排序
        try{
            List<Staff> salers=new ArrayList<Staff>();
            if (set==null){
                salers=staffDao.getObjectsByDetachedCriteria(DetachedCriteria.forClass(Sale.class).add(
                        Restrictions.eq(
                                "job","S"
                        )
                ));
            }
            else{
                for(String s:set.keySet()){
                    if(s.charAt(0)=='i'){
                        salers.add(staffDao.getObjectById(Integer.parseInt(s.substring(2)),Staff.class));
                    }
                }
            }
            for (Staff staff:salers){ //遍历所有选中的用户，计算某一时间段内的利润
                points.put(staff.getId(), findProfit(starttime,endtime,staff.getId()+""));
            }
            return points;
        }
        catch(Exception e){
            throw e;
        }
    }

    //计算某段时间的总利润
    //成功：在某段时间的利润
    //失败：0.0或报错
    public double findProfit(Timestamp starttime,Timestamp endtime){
        try{
            double profit=0.0;
            List<Staff> salers=staffDao.getObjectsByDetachedCriteria(DetachedCriteria.forClass(Sale.class).add(
                    Restrictions.eq(
                            "job","S"
                    )
            ));
            for(Staff saler:salers){
                profit+=findProfit(starttime,endtime,saler.getId()+"");
            }
            return profit;
        }
        catch(Exception e){
            throw e;
        }
    }

    //计算某段时间的某个销售员的利润折线
    //成功：某销售员在某段时间的利润折线
    //失败：null或报错
    public  Map<Timestamp,Double> findProfitPoints(Timestamp starttime,Timestamp endtime,String salerid){
        Map<Timestamp,Double> points=new TreeMap<Timestamp,Double>();
        try{
            Staff staff=staffDao.getObjectById(Integer.parseInt(salerid),
                    Staff.class);
            if (staff==null){
                return points;
            }
            else if(!staff.getJob().equals("S")){
                return points;
            }
            List<Sale> lists=null;
            if (starttime.toString().equals(endtime.toString())){ //判断是否为异常情况（未选择 或 选择了时间点）
                lists=saleDao.getObjectsByDetachedCriteria(
                        DetachedCriteria.forClass(Sale.class).add(
                                Restrictions.eq(
                                        "staffBySalerId",
                                        staff
                                )
                        )
                );
            }
            else if(starttime.before(endtime)){  //选择了时间段
                lists=saleDao.getObjectsByDetachedCriteria(DetachedCriteria.forClass(Sale.class).add(
                        Restrictions.and(
                                Restrictions.ge("time",starttime),
                                Restrictions.le("time",endtime)
                        )
                ));
            }
            else{ //选择了时间段，但start和end反了
                lists=saleDao.getObjectsByDetachedCriteria(DetachedCriteria.forClass(Sale.class).add(
                        Restrictions.and(
                                Restrictions.ge("time",endtime),
                                Restrictions.le("time",starttime)
                        )
                ));
            }
            for (Sale list:lists){
                if(list.getStaffBySalerId().getId()==staff.getId()){
                    points.put(list.getTime(), getProfit(list.getId()+""));
                }
            }
            return points;
        }
        catch(Exception e){
            throw e;
        }
    }

}
