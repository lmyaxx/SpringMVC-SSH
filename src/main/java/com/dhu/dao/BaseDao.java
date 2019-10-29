package com.dhu.dao;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Projections;
import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;
import org.hibernate.criterion.DetachedCriteria;
import javax.annotation.Resource;
import javax.persistence.criteria.CriteriaQuery;
import java.io.Serializable;
import java.util.List;
import java.util.Map;

/*
dao层不进行事务控制，事务交给Service层维护
 */
@Repository
public class BaseDao<T> {
    @Resource
    private SessionFactory sessionFactory;


    //根据ID获取对象
    public T getObjectById(Serializable id, Class<T> clazz) {
        return (T) sessionFactory.getCurrentSession().get(clazz, id);
    }
    //新增对象
    public Serializable save(T t) {
        return sessionFactory.getCurrentSession().save(t);
    }
    //删除根据Id删除对象
    public void delete(Serializable id, Class<T> clazz) {
        T t = getObjectById(id, clazz);
        if (t != null) {
            sessionFactory.getCurrentSession().delete(t);
        } else {
            new RuntimeException("你要删除的数据不存在").printStackTrace();
        }
        ;
    }
    // 更新对象
    public void update(T t) {
        sessionFactory.getCurrentSession().update(t);
    }
    //获取所有对象
    @SuppressWarnings("unchecked")
    public List<T> getAll(Class<T> clazz) {
        return sessionFactory.getCurrentSession().createQuery(" from "+clazz.getSimpleName()).list();
    }
    //根据某种特征获取符合条件的所有对象
    public  List<T> getObjectsByDetachedCriteria(DetachedCriteria detachedCriteria){
        Session session = sessionFactory.getCurrentSession();
        Criteria criteria = detachedCriteria.getExecutableCriteria(session);
        return criteria.list();
    }
    //
    public  List<T> getObjectsByHQL(String hql,List<Object> conditions){
        Session session = sessionFactory.getCurrentSession();
        Query query = session.createQuery(hql);
        for(int i = 0;i<conditions.size();i++) {
            query.setParameter(i,conditions.get(i));
        }
        return query.list();
    }

    //获取符合某种条件的对象的数量
    public long getObjectsNumByDetachedCriteria(DetachedCriteria detachedCriteria){
        Session session = sessionFactory.getCurrentSession();
        Criteria criteria = detachedCriteria.getExecutableCriteria(session);
        criteria.setProjection(Projections.rowCount());
        return (long) criteria.uniqueResult();
    }
    //分页查询某种条件的对象
    public List<T> getObjectsByPageAndDetachedCriteria(DetachedCriteria detachedCriteria,int beginIndex,int num){
        Session session = sessionFactory.getCurrentSession();
        Criteria criteria = detachedCriteria.getExecutableCriteria(session);
        criteria.setFirstResult(beginIndex);
        criteria.setMaxResults(num);
        return criteria.list();
    }

    @SuppressWarnings("deprecation")
    public Integer getNextId(Class<T> clazz){

        Session session = sessionFactory.getCurrentSession();
        Integer id = (Integer) session.createCriteria(clazz).setProjection( Projections.projectionList().add(Projections.max("id") ) ).uniqueResult();
        return id+1;
    }
}
