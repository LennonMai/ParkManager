package com.hgsoft.dao;


import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.hgsoft.entity.Sysparamconf;

@Repository
public class SynDataDao extends BaseDao<Sysparamconf> {

	public void synOperator() {
		// TODO Auto-generated method stub
		Query query = getSession().createSQLQuery("{call proc_synLaneOperator}");
		query.executeUpdate();
	}

	public void synWhiteList() {
		// TODO Auto-generated method stub
		Query query = getSession().createSQLQuery("{call proc_synWhiteList}");
		query.executeUpdate();
		
	}

}
