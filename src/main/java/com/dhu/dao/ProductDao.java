package com.dhu.dao;

import com.dhu.pojo.Product;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;
import org.hibernate.criterion.DetachedCriteria;
import javax.annotation.Resource;
import java.util.List;

@Repository
public class ProductDao extends BaseDao<Product>{

}



