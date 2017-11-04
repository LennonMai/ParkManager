package com.hgsoft.dao;

import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.hgsoft.entity.Role;
import com.hgsoft.util.JdbcUtil;

@Repository 
public class RoleDao extends BaseDao<Role> {
	@Resource
	private JdbcUtil jdbcUtil;
	
	@SuppressWarnings("unchecked")
	public Role getRoleByName(String roleName) {	//验证角色名是否存在	
		String hql = "from Role role where role.name=?";
		List resultList = executeQuery(hql, roleName);
		if(resultList.isEmpty()) {
			return null;
		} else {
			return (Role)resultList.get(0);
		}
	}
	
	public void deleteRoleById(int id) {
//		String sql = "delete from t_park_admin_role where role="+id;
//		jdbcUtil.delete(sql);
		String sql = "delete from t_park_role_module where role="+id;
		jdbcUtil.delete(sql);
		String hql = "delete from Role role where role.id="+id;
		Query q = getSession().createQuery(hql);
		q.executeUpdate();
	}
	
}
