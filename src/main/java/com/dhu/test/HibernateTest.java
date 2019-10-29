package com.dhu.test;

import com.dhu.pojo.Staff;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class HibernateTest {

	StandardServiceRegistry registry =  null;
    SessionFactory sessionFactory = null;
    Session session = null;
    Transaction transaction = null;

	@Before
    public void init() {

        registry = new StandardServiceRegistryBuilder()
                .configure() // configures settings from hibernate.cfg.xml
                .build();
        sessionFactory = new MetadataSources(registry).buildMetadata().buildSessionFactory();
        session = sessionFactory.openSession();
        //开始事务
        transaction = session.getTransaction();
        transaction.begin();
    }

	@Test
    public void testSaveUser() {
	    Staff staff = new Staff();
        staff.setId(123);
        staff.setName("haha");
        staff.setJob("M");
        staff.setPw("1234");
        session.save(staff);
    }

    @After
    public void destroy(){
        //transaction.commit();
        session.close();
        sessionFactory.close();
        StandardServiceRegistryBuilder.destroy(registry);
    }

}
