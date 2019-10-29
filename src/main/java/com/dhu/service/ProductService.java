package com.dhu.service;

import com.dhu.pojo.Product;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Service
public class ProductService extends BaseService<Product>{



    //根据名称模糊查询某Id供应商的产品列表；
    @Transactional
    public List<Product> getProductByName(String name,int supplierId){
        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Product.class);
        detachedCriteria.add(Restrictions.eq("supplierId",supplierId));
        detachedCriteria.add(Restrictions.ilike("name","%"+name+"%"));
        return this.getObjectsByDetachedCriteria(detachedCriteria);
    }

    /**
     * 返回数据库中库存大于0的所有产品
     * @return
     */
    public List<Product> findAllProduct(){
        List<Product> pList = this.getObjectsByDetachedCriteria(
                DetachedCriteria.forClass(Product.class).add(
                        Restrictions.gt("quantity",0)
                )
        );
        return pList;
    }

    public List<Product> findAllProductByName(String name){
        List<Product> pList = this.getObjectsByDetachedCriteria(
                DetachedCriteria.forClass(Product.class).add(
                        Restrictions.and(
                                Restrictions.gt("quantity",0),
                                Restrictions.like("name","%"+name.trim()+"%")
                        )
                )
        );
        return pList;
    }

    @Transactional
    public boolean editProducts(Map<String,String[]> map){
        Set<String>set = map.keySet();
        for(String id:set){
            if(id.charAt(0)=='i'){
                String data = map.get(id)[0];
                Product product=new Product();
                String[] info;
                info=data.split(",");  //分解信息串
                product = this.getObjectById(Integer.parseInt(id.substring(2)));
                if(!info[1].equals("")) product.setAlertline(Integer.parseInt(info[1]));
                else return false;
                if(!info[0].equals("")) product.setPrice(Double.parseDouble(info[0]));
                else return false;
                this.update(product);
            }
        }
        return true;
    }


    @Transactional
    public List<Product> getProductsBelowAlertline(int times) {
        String hql="from Product where quantity <= alertline*? order by quantity/alertline asc";
        List<Object> conditions = new ArrayList<Object>();
        conditions.add(times);
        return getObjectsByHQL(hql,conditions);
    }




















    public int getMaxPageByLabel(String label,int pageIndex,int maxResults){
        long total = this.getObjectsNumByDetachedCriteria(
                DetachedCriteria.forClass(Product.class).add(
                        Restrictions.and(
                                Restrictions.eq("supplierBySupplierId.label",
                                        label),
                                Restrictions.ge("quantity",0)
                        )
                ));
        int maxPage = (int)total/maxResults+1;
        return maxPage;
    }

    /**
     * 根据商品的标签查询商品
     * @param label 商标
     * @param pageIndex 当前页码
     * @param maxResults 当前页显示最大数量
     * @return 查到的列表
     */
    public List<Product> getProductByBrandLabel(String label,int pageIndex,int maxResults){
        int firstResult = maxResults*(pageIndex-1);
        List<Product> pList = this.getObjectsByPageAndDetachedCriteria(
                DetachedCriteria.forClass(Product.class).add(
                        Restrictions.and(
                                Restrictions.eq("supplierBySupplierId.label",
                                        label),
                                Restrictions.ge("quantity",0)
                        )
                ),firstResult,maxResults
        );
        return pList;
    }
    public int getMaxPageByPrice(double minPrice,double maxPrice,
                                 int pageIndex,int maxResults){
        if(minPrice>maxPrice){
            double temp = maxPrice;
            maxPrice=minPrice;
            minPrice=temp;
        }
        long total = this.getObjectsNumByDetachedCriteria(
                DetachedCriteria.forClass(Product.class).add(
                        Restrictions.and(
                                Restrictions.ge("price",minPrice),
                                Restrictions.le("price",maxPrice),
                                Restrictions.ge("quantity",0)
                        )
                ));
        int maxPage = (int)total/maxResults+1;
        return maxPage;
    }
    /**
     * 根据价格范围查询相应的产品列表
     * @param minPrice 最低价格
     * @param maxPrice 最高价格
     * @return 产品列表
     */
    public List<Product> getProductByPrice(double minPrice,double maxPrice,
                                           int pageIndex,int maxResults){
        if(minPrice>maxPrice){
            double temp = maxPrice;
            maxPrice=minPrice;
            minPrice=temp;
        }
        int firstResult = maxResults*(pageIndex-1);
        List<Product> pList = this.getObjectsByPageAndDetachedCriteria(
                DetachedCriteria.forClass(Product.class).add(
                        Restrictions.and(
                                Restrictions.ge("price",minPrice),
                                Restrictions.le("price",maxPrice),
                                Restrictions.ge("quantity",0)
                        )
                ),firstResult,maxResults
        );
        return pList;
    }

    /**
     * 得到最大页数
     * @param pageIndex
     * @param maxResults
     * @return
     */
    public int getMaxPage(Integer pageIndex,int maxResults){
        long total = this.getObjectsNumByDetachedCriteria(
                DetachedCriteria.forClass(Product.class).add(
                        Restrictions.ge("quantity",0)
                ));
        int maxPage = (int)total/maxResults+1;
        return maxPage;
    }
    /**
     *
     * @param pageIndex 页码
     * @param maxResults 每页显示的最大产品数量
     * @return 产品列表
     */
    public List<Product> getProductListByPage(Integer pageIndex,int maxResults){
        //求出起始记录下标
        int firstResult = maxResults*(pageIndex-1);
        List<Product> pList = this.getObjectsByPageAndDetachedCriteria(
                DetachedCriteria.forClass(Product.class).add(
                        Restrictions.ge("quantity",0)
                ),firstResult,maxResults
        );
        return pList;

    }

    /**
     * 根据商品名字计算最大页数
     * @param pageIndex
     * @param maxResults
     * @param name
     * @return
     */
    public int getMaxPageByName(Integer pageIndex,int maxResults,String name){
        long total = this.getObjectsNumByDetachedCriteria(
                DetachedCriteria.forClass(Product.class).add(
                        Restrictions.and(
                                Restrictions.ge("quantity",0),
                                Restrictions.like("name","%"+name+"%")
                        )
                ));
        int maxPage = (int)total/maxResults+1;
        System.out.println("maxPage" + maxPage);
        return maxPage;
    }

    /**
     * 根据商品的名字进行分页查询
     * @param pageIndex
     * @param maxResults
     * @param name
     * @return
     */
    public List<Product> findProductByName(Integer pageIndex,int maxResults,String name){
        int firstResult = maxResults*(pageIndex-1);
        List<Product> pList = this.getObjectsByPageAndDetachedCriteria(
                DetachedCriteria.forClass(Product.class).add(
                        Restrictions.and(Restrictions.like("name","%" + name + "%"),
                                Restrictions.gt("quantity",0))
                ),firstResult,maxResults
        );
        return pList;
    }

}
