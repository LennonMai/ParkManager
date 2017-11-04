package com.hgsoft.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.hgsoft.entity.OwnerIdentity;

@Repository
public class OwnerIdentityDao extends BaseDao<OwnerIdentity>{
	
	public List getAllOwnerIdentity(){
		String hql = "from OwnerIdentity ownerIdentity";
		List list = executeQuery(hql);
		if (list.isEmpty()) {
			return null;
		} else {
			return list;
		}
	}
}
