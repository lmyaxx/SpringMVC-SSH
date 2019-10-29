package com.dhu.service;

import com.dhu.dao.DetailListSaleDao;
import com.dhu.dao.ProductDao;
import com.dhu.pojo.*;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.SessionAttributes;

import javax.annotation.Resource;
import javax.transaction.Transactional;
import java.sql.Timestamp;
import java.util.*;

@Service
@SessionAttributes("cart")public class SaleService extends BaseService<Sale> {
    @Resource
    private ProductDao productDao;
    @Resource
    private DetailListSaleDao detailListSaleDao;

    /**
     * 这个方法只进行了查询
     * 根据产品id和要购买的产品数量，封装成sale对象
     * @param map
     * @return
     */
    public Sale writeBuyProductInfo(Map<String,String[]>map){
        Set<String> set = map.keySet();
        Sale sale = new Sale();
        Collection<DetailListSale> detailListSales = new ArrayList<>();
        double totalPrice = 0;
        for(String id:set){
            if(id.charAt(0)=='i'){
                int quantity = Integer.parseInt(map.get(id)[0]);
                id = id.substring(2);
                int productId = Integer.parseInt(id);
                Product product = productDao.getObjectById(productId,Product.class);
                DetailListSale detailListSale = new DetailListSale();
                detailListSale.setProductId(productId);
                detailListSale.setProductByProductId(product);
                detailListSale.setQuantity(quantity);
                totalPrice += quantity*product.getPrice();
                detailListSales.add(detailListSale);
            }
        }
        sale.setDetailListSalesById(detailListSales);
        sale.setTotalPrice(totalPrice);
        return sale;
    }

    /**
     * 这个方法无数据库操作
     * 根据传入的id删除已添加但不再需要的产品，如果全部删除则返回空
     * @param id 产品id
     * @param sale 销售对象
     */
    public void deleteAddedProductByid(int id,Sale sale){
        Iterator<DetailListSale> detailListSaleIterator =
                sale.getDetailListSalesById().iterator();
        double totalPrice = sale.getTotalPrice();
        while (detailListSaleIterator.hasNext()){
            DetailListSale detailListSale = detailListSaleIterator.next();
            Product product = detailListSale.getProductByProductId();
            if(product.getId()==id){
                detailListSaleIterator.remove();
                totalPrice -= product.getPrice()*detailListSale.getQuantity();
                break;
            }
        }
        sale.setTotalPrice(totalPrice);
        if(sale.getDetailListSalesById().size()==0){
            sale = null;
        }
    }

    /**
     * 把客户购买的信息存入数据库中
     * @param customerId 客户id
     * @param sale
     * @param staff
     * @return 是否保存成功
     */
    @Transactional
    public boolean insertSaleAndDetailSale(int customerId, Sale sale, Staff staff){
        boolean flag = true;//标记是否保存成功
        Collection<DetailListSale> detailListSales = sale.getDetailListSalesById();
        Iterator<DetailListSale> detailListSaleIterator =
                sale.getDetailListSalesById().iterator();
        for (DetailListSale detailListSale:detailListSales){
            //保存从数据库中取出的产品信息
            Product product = detailListSale.getProductByProductId();
            Product temp = productDao.getObjectById(product.getId(),Product.class);
            //如果要售出的产品数目大于库存，则保存失败
            if(detailListSale.getQuantity()>temp.getQuantity()){
                flag = false;
                break;
            }
        }
        sale.setDetailListSalesById(null);
        if (flag){
            //把sale插入数据库
            sale.setSalerId(staff.getId());//插入员工id
            sale.setCustomerId(customerId);//客户id
            sale.setState("A");//订单状态
            Timestamp submitTime  = new Timestamp(System.currentTimeMillis());//时间
            sale.setTime(submitTime);
            int saleId = (Integer)this.save(sale);
            for (DetailListSale detailListSale:detailListSales){
                detailListSale.setId(saleId);//订单
                System.out.println(detailListSale.getId());
                System.out.println(detailListSale.getProductId());
                System.out.println(detailListSale.getQuantity());
                detailListSaleDao.save(detailListSale);
            }
            return true;
        }
        else {
            return false;
        }
    }

    /**
     * 调用dao查询所有的订单
     * @return返回链表
     */
    public List<Sale> getSaleList(){
        List<Sale> sList = this.getAll();//调用父类方法
        Collections.reverse(sList);
        return sList;
    }

    /**
     * 根据订单是否出库进行查询
     * @param state 订单状态
     * @return 订单列表
     */
    public List<Sale> getSaleListByState(String state){
        List<Sale> sList = this.getObjectsByDetachedCriteria(
                DetachedCriteria.forClass(Sale.class).add(
                        Restrictions.eq("state",state)
                )
        );
        Collections.reverse(sList);
        return sList;
    }

    /**
     * 对当前销售人员的订单是否出库进行查询
     * @param state 订单状态
     * @param staff 当前登录员工
     * @return 订单列表
     */
    public List<Sale> getSaleListByState(String state,Staff staff){
        int id = staff.getId();
        List<Sale> sList = this.getObjectsByDetachedCriteria(
                DetachedCriteria.forClass(Sale.class).add(
                        Restrictions.and(
                                Restrictions.eq("state",state),
                                Restrictions.eq("salerId",
                                        id)
                        )
                )
        );
        Collections.reverse(sList);
        return sList;
    }



    /**
     * 根据订单号查询这个订单的详细信息
     * @param id
     * @return
     */
    public Sale getDetailSaleInfo(int id){
        Sale sale = this.getObjectById(id);
        return sale;
    }

    /**
     * 根据销售员的id查询这个销售员售出的所有订单
     * @param staff 当前登录员工
     * @return 返回订单列表
     */
    public List<Sale> getSaleListBySalersId(Staff staff){
        Integer id = staff.getId();
        System.out.println(staff.getId());
        List<Sale> sList = this.getObjectsByDetachedCriteria(
                DetachedCriteria.forClass(Sale.class).add(
                        Restrictions.eq("salerId",
                                id)
                )
        );
        Collections.reverse(sList);
        return sList;
    }

    /**
     * 根据客户id查询订单
     * @param customerId 客户id
     * @return 客户列表
     */
    public List<Sale> getSaleListByCustomerId(int customerId){
        List<Sale> sList = this.getObjectsByDetachedCriteria(
                DetachedCriteria.forClass(Sale.class).add(
                        Restrictions.eq("customerId",
                              customerId)
                )
        );
        Collections.reverse(sList);
        return sList;
    }

    //获取B状态的销售单
    @Transactional
    public List<Sale> getSalesStateEqualB(){
        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Sale.class);
        detachedCriteria.add(Restrictions.eq("state", "B"));
        return getObjectsByDetachedCriteria(detachedCriteria);
    }
    //将订单转换为C状态，订单出库成功
    //作者 李明月
    @Transactional
    public void updateSalesToStateC(Staff staff, List<Integer> saleIds) {
        for(int id:saleIds){
            Sale sale = this.getObjectById(id);
            sale.setState("C");
            sale.setWarehouseKeeperId(staff.getId());
           // this.save(sale);
            this.update(sale);//认为应该是更新
        }
    }


    /**
     * 改进版本
     * 根据产品id和数目添加到购物车中，如果该产品已经存在于购物车
     * 那么只更改数量即可，如果添加的数量多于库存，那么显示相应的消息，
     * 不做添加
     * @param productId 产品id
     * @param num 数量
     * @param sale
     * @param msg
     */
    private void addProductToCart(int productId,int num,Sale sale,StringBuffer msg){
        Collection<DetailListSale> detailListSales = sale.getDetailListSalesById();
        Product product = productDao.getObjectById(productId,Product.class);
        if(detailListSales==null){
            detailListSales = new ArrayList<>();
        }
        boolean flag = false;//标记该产品是否已经在购物车中
        //如果购物车中已经存在这个商品，则只需要更改数量，如果数量大于库存，则不更改
        double totalprice= 0;
        for (DetailListSale detailListSale:detailListSales){
            if (detailListSale.getProductId()==productId){
                if(detailListSale.getQuantity()+num<=product.getQuantity()){
                    detailListSale.setQuantity(detailListSale.getQuantity()+num);
                    totalprice += product.getPrice()*num;
                    sale.setTotalPrice(sale.getTotalPrice()+totalprice);
                    msg.append("添加成功！");
                }
                else {
                    msg.append(product.getName() + "的库存不足，请选择其它商品");
                }
                flag=true;
                break;
            }
        }
        if(!flag){//如果没有包含的话
            if(num<product.getQuantity()){
                DetailListSale detailListSale = new DetailListSale();
                detailListSale.setProductId(productId);
                detailListSale.setQuantity(num);
                detailListSale.setProductByProductId(productDao.getObjectById(productId,Product.class));
                detailListSales.add(detailListSale);
                sale.setDetailListSalesById(detailListSales);
                sale.setTotalPrice(sale.getTotalPrice()+product.getPrice()*num);
                msg.append("添加成功！");
            }
            else {
                msg.append(product.getName() + "的库存不足，请选择其它商品");
            }

        }

    }

    /**
     * 显示用户的购物车信息
     * @param cart
     * @param customer 客户
     * @param unLoginUser 未登录用户特殊编号
     * @return sale对象
     */
    public Sale showCart(Map<Integer,Sale> cart,Customer customer,int unLoginUser){
        if(cart==null){
            return null;
        }
        if (customer==null){
            if(!cart.containsKey(unLoginUser)){//如果游客用户目前没有向加购物车添加商品
                return null;
            }
            deleteInvaildProductInCart(cart.get(unLoginUser));
            return cart.get(unLoginUser);
        }
        else{
            if (cart.get(customer.getId())==null){
                return null;
            }

            deleteInvaildProductInCart(cart.get(customer.getId()));
            return cart.get(customer.getId());
        }
    }

    /**
     * 删除购物车中失效的产品，如仓库数量不足
     * @param sale
     */
    private void deleteInvaildProductInCart(Sale sale){
        if(sale.getDetailListSalesById()==null){
            return;
        }
        Iterator<DetailListSale> detailListSaleIterator =
                sale.getDetailListSalesById().iterator();
        while (detailListSaleIterator.hasNext()){
            DetailListSale detailListSale = detailListSaleIterator.next();
            Product product = productDao.getObjectById(detailListSale.getProductId(),Product.class);
            //如果库存不足则删除
            if (detailListSale.getQuantity()>product.getQuantity()){
                detailListSaleIterator.remove();
            }
        }
    }

    /**
     * controller层调用这个方法，添加商品到购物车中
     * @param cart
     * @param productId
     * @param num
     * @param customer
     * @param unLoginUser
     * @param msg
     */

    public Sale addProductToCart(Map<Integer,Sale> cart,int productId,
                                 int num,
                                 Customer customer,
                                 int unLoginUser,
                                 StringBuffer msg){
        Collection<DetailListSale> detailListSales = new ArrayList<>();
        if(customer==null){
            if(!cart.containsKey(unLoginUser)){
                Sale sale = new Sale();
                sale.setTotalPrice(0.0);
                sale.setDetailListSalesById(detailListSales);
                cart.put(unLoginUser,sale);
            }
            Sale sale = cart.get(unLoginUser);
            addProductToCart(productId,num,sale,msg);
            cart.put(unLoginUser,sale);

            System.out.println(msg + "mag");
            return sale;
        }
        else {
            if(!cart.containsKey(customer.getId())){
                Sale sale = new Sale();
                sale.setDetailListSalesById(detailListSales);
                sale.setTotalPrice(0.0);
                cart.put(customer.getId(),sale);
            }
            Sale sale = cart.get(customer.getId());
            if(sale==null){
                sale = new Sale();
                sale.setDetailListSalesById(detailListSales);
                sale.setTotalPrice(0.0);
                // cart.put(customer.getId(),sale);
            }
            addProductToCart(productId,num,sale,msg);
            cart.put(customer.getId(),sale);
            return sale;
        }
    }

    /**
     * 根据传入的客户信息和用户购买信息，封装sale对象，进行前端的确认显示
     * @param customer
     * @param productId
     * @param num
     * @return
     */
    public Sale doSubmit(Customer customer,int productId,int num){
        Sale sale = new Sale();
        Collection<DetailListSale> detailListSales = new ArrayList<>();
        DetailListSale detailListSale = new DetailListSale();
        Product product = productDao.getObjectById(productId,Product.class);
        detailListSale.setQuantity(num);
        detailListSale.setProductId(productId);
        detailListSale.setProductByProductId(product);
        detailListSales.add(detailListSale);
        sale.setDetailListSalesById(detailListSales);
        sale.setCustomerByCustomerId(customer);
        sale.setTotalPrice(product.getPrice()*num);
        return sale;
    }

    private void editProductToCart(int productId,int num,Sale sale,StringBuffer msg){
        Collection<DetailListSale> detailListSales = sale.getDetailListSalesById();
        Product product = productDao.getObjectById(productId,Product.class);
        if(detailListSales==null){
            detailListSales = new ArrayList<>();
        }
        //如果购物车中已经存在这个商品，则只需要更改数量，如果数量大于库存，则不更改
        double totalprice= 0;
        for (DetailListSale detailListSale:detailListSales){
            if (detailListSale.getProductId()==productId){
                if(num<=product.getQuantity()){
                    detailListSale.setQuantity(num);
                    totalprice += product.getPrice()*num;
                    System.out.println(totalprice);
                    sale.setTotalPrice(sale.getTotalPrice()+totalprice);
                    msg.append("添加成功！");
                }
                else {
                    msg.append(product.getName() + "的库存不足，请选择其它商品");
                }
                break;
            }
        }
    }


    /**
     * 处理计算总价等业务
     * @param map
     * @param customer
     * @param cart
     */
    public void doComputer(Map<String,String[]>map,Customer customer,Map<Integer,Sale> cart){
        Set<String> set = map.keySet();
        cart.get(customer.getId()).setTotalPrice(0.00);
        for (String id:set){
            if (id.charAt(0)=='i'){
                int num = Integer.parseInt(map.get(id)[0]);
                StringBuffer msg = new StringBuffer();
                editProductToCart(Integer.parseInt(id.substring(2)),num,cart.get(customer.getId()),msg);
            }
        }
    }
    @Transactional
    public boolean doBuy(Customer customer,Map<Integer,Sale> cart){
        Sale sale = cart.get(customer.getId());
        boolean flag = true;//标记是否保存成功
        Collection<DetailListSale> detailListSales = sale.getDetailListSalesById();
        Iterator<DetailListSale> detailListSaleIterator =
                sale.getDetailListSalesById().iterator();
        for (DetailListSale detailListSale:detailListSales){
            //保存从数据库中取出的产品信息
            Product product = detailListSale.getProductByProductId();
            Product temp = productDao.getObjectById(product.getId(),Product.class);
            //如果要售出的产品数目大于库存，则保存失败
            if(detailListSale.getQuantity()>temp.getQuantity()){
                flag = false;
                break;
            }
        }
        if (flag){
            //把sale插入数据库
            sale.setCustomerId(customer.getId());//客户id
            sale.setState("A");//订单状态
            sale.setSalerId(1005);//本来这个键应设置为可以为空
            Timestamp submitTime  = new Timestamp(System.currentTimeMillis());//时间
            System.out.println(sale.getTotalPrice());
            System.out.println(customer.getId());
            System.out.println(sale.getState());
            sale.setTime(submitTime);
            int saleId = (Integer)this.save(sale);
            for (DetailListSale detailListSale:detailListSales){
                detailListSale.setId(saleId);//订单
                System.out.println(detailListSale.getId());
                System.out.println(detailListSale.getProductId());
                System.out.println(detailListSale.getQuantity());
                detailListSaleDao.save(detailListSale);
            }
            return true;
        }
        else {
            return false;
        }
    }
}
