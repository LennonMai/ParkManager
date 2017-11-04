package com.hgsoft.dao;

import org.springframework.stereotype.Repository;
import com.hgsoft.entity.SecurityCommandOperation;




@Repository
public class SecurityCommandOperationDao extends BaseDao<SecurityCommandOperation> {
	
	
	@SuppressWarnings("unchecked")
	public Long getCount(String commandId){	
		String hql = "from SecurityCommandOperation securityCommandOperation where securityCommandOperation.commandId =?";
		Long count = this.executeCount(hql, Integer.parseInt(commandId));
		return count;
	}
	
	@SuppressWarnings("unchecked")
	public Long getAllCount(){
		String hql ="from SecurityCommandOperation securityCommandOperation";
		Long count = this.executeCount(hql, null);
		return count;
	} 
}
