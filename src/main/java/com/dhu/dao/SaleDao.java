package com.dhu.dao;

import com.dhu.pojo.Sale;
import org.springframework.stereotype.Repository;

import javax.persistence.Query;
import java.sql.Timestamp;
import java.util.List;

@Repository
public class SaleDao extends BaseDao<Sale> {
}
