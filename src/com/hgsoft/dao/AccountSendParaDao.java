package com.hgsoft.dao;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.hgsoft.util.JdbcUtil;


/**
 * 账户信息下发车道DAO
 * @author caijunhua
 *
 */

@Repository
public class AccountSendParaDao {
	
//	@Resource private SessionFactory sessionFactory;
//	
//	public Session getSession() {
//		Session session = sessionFactory.getCurrentSession();
//		return session;
//	}
	
//	private JdbcTemplate jdbcTemplate;
//	
//	@Resource
//	public void setDataSource(DataSource dataSource) {
//        this.jdbcTemplate = new JdbcTemplate(dataSource);
//    }
	@Resource
	private JdbcUtil jdbcUtil;

	
	public void SendPara() {
//		System.out.println("1111111111111111");
//		Session session = getSession();

		try{
//			ApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml", AccountSendParaDao.class);
//			DataSource source = (DataSource) ac.getBean("dataSource");
//			JdbcTemplate jt = new JdbcTemplate(source);
			//下发参数视图
			String sql1 = "delete from tb_SendPara where tablename='tb_AccountCard'";
			String sql2 = "insert into tb_SendPara select 1,0,0,laneno,laneComputerIP,'tb_AccountCard','tb_AccountCard' from tb_LaneUse";
//			System.out.println(sql1);
			jdbcUtil.update(sql1);
			jdbcUtil.update(sql2);
//			Query query1 = session.createSQLQuery(sql1);
//			Query query2 = session.createSQLQuery(sql2);
//			query1.executeUpdate();
//			query2.executeUpdate();
			
//			session.flush();   
//			session.close();   
//			jt.update(sql1);
//			jt.update(sql2);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
