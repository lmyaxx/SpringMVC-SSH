package com.dhu.service;

import com.dhu.pojo.News;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Property;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
public class NewsService extends BaseService<News>{

    @Transactional
    public Long getNewsNum(){
        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(News.class);
        return this.getObjectsNumByDetachedCriteria(detachedCriteria);
    }

    //获取最新的5条新闻，用于轮播
    @Transactional
    public List<News> getLatestFiveNews() {
        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(News.class);
        detachedCriteria.addOrder(Order.desc("releaseTime"));
        detachedCriteria.add(Property.forName("picId").isNotNull());
        detachedCriteria.add(Property.forName("picId").ne(""));
        return this.getObjectsByPageAndDetachedCriteria(detachedCriteria,0,5);
    }
    //分页获取新闻
    @Transactional
    public List<News> getNewsByPageAndSize(Integer page,Integer num) {
        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(News.class);
        detachedCriteria.addOrder(Order.desc("releaseTime"));
        return this.getObjectsByPageAndDetachedCriteria(detachedCriteria,(page-1)*num,num);
    }
}
