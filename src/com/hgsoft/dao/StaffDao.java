package com.hgsoft.dao;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;
import com.hgsoft.entity.Staff;

@Repository 
public class StaffDao extends BaseDao<Staff> {
	public void deleteByCardNo(String cardNo) {
		String hql = "delete from Staff staff where  staff.cardNo='"+cardNo+"'";
		Query q = getSession().createQuery(hql) ;
        q.executeUpdate() ;		
	}
}
