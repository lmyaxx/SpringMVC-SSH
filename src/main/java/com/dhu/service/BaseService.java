package com.dhu.service;

import com.dhu.dao.BaseDao;
import org.hibernate.criterion.DetachedCriteria;

import javax.annotation.Resource;
import javax.transaction.Transactional;
import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.List;

public class BaseService<T>{
    @Resource
    private BaseDao<T> baseDao;

    private Class<T> clazz;

    @SuppressWarnings({ "unchecked", "rawtypes" })
    public BaseService() {
        // 子类
        Class cla = getClass();
        // 通过子类获取到父类
        // 泛型参数
        Type type = cla.getGenericSuperclass();
        if (type instanceof ParameterizedType) {
            ParameterizedType pType = (ParameterizedType) type;
            clazz = (Class<T>) pType.getActualTypeArguments()[0];
        }
    }

    /*
     * 保存数据
     * @see cn.mylife.service.user.BaseService#save(java.lang.Object)
     */
    @Transactional
    public Serializable save(T t) {
        return baseDao.save(t);
    }

    /*
     * 根据ID删除数据
     * @see cn.mylife.service.user.BaseService#delete(java.io.Serializable)
     */
    @Transactional
    public void delete(Serializable id) {
        baseDao.delete(id, clazz);
    }

    /*
     * 更新数据
     * @see cn.mylife.service.user.BaseService#update(java.lang.Object)
     */
    @Transactional
    public void update(T t) {
        baseDao.update(t);
    }

    /*
     * 根据ID获得数据
     * @see cn.mylife.service.user.BaseService#get(java.io.Serializable)
     */
    @Transactional
    public T getObjectById(Serializable id) {
        return baseDao.getObjectById(id, clazz);
    }

    /*
     * 获取所有的数据
     * @see cn.mylife.service.user.BaseService#getAll()
     */
    @Transactional
    public List<T> getAll() {
        return baseDao.getAll(clazz);
    }
    /*
     根据detachedCriteria查询限定条件的列表
     */
    @Transactional
    public List<T> getObjectsByDetachedCriteria(DetachedCriteria detachedCriteria){
        return  baseDao.getObjectsByDetachedCriteria(detachedCriteria);
    }
    @Transactional
    public  List<T> getObjectsByHQL(String hql,List<Object> conditions){
        return baseDao.getObjectsByHQL(hql,conditions);
    }
    /*
    根据detachedCriteria查询限定条件的列表元素的数量
     */
    @Transactional
    public long getObjectsNumByDetachedCriteria(DetachedCriteria detachedCriteria){
        return  baseDao.getObjectsNumByDetachedCriteria(detachedCriteria);
    }

    //分页查询某种条件的对象
    @Transactional
    public List<T> getObjectsByPageAndDetachedCriteria(DetachedCriteria detachedCriteria,int beginIndex,int num){
        return  baseDao.getObjectsByPageAndDetachedCriteria(detachedCriteria,beginIndex,num);
    }

    //获取下一个id
    public Integer getNextId(Class<T> clazz){
        return baseDao.getNextId(clazz);
    }
}
