package com.hgsoft.dao;

import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

@Repository
public class FreeDao {
	@Resource
	SessionFactory sessionFactory;
	
	public Session getSession(){
		Session session = sessionFactory.getCurrentSession();
		return session;
	}
	public List isSysCard(String cardNo) {
		// TODO Auto-generated method stub
		String sql = "select * from v_PassCardWL where CardNo ="+cardNo;
		return getSession().createSQLQuery(sql).list();
	}
	public List isWhiteListCard(String cardNo) {
		// TODO Auto-generated method stub
		String sql = "select * from V_WHITELIST where CardNo ="+cardNo;
		return getSession().createSQLQuery(sql).list();
	}

}
