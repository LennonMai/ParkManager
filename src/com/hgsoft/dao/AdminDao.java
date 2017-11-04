package com.hgsoft.dao;

import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.hgsoft.entity.Admin;
import com.hgsoft.util.JdbcUtil;

@Repository 
public class AdminDao extends BaseDao<Admin> {
	
	@Resource
	private JdbcUtil jdbcUtil;
	
	//取得管理员号，900000001开始
	@SuppressWarnings("unchecked")
	public int getAdminId() {
		String hql = "from Admin admin";
		List resultList = executeQuery(hql);
		if(resultList.isEmpty()) {
			return 900000000;
		} else {
			int size = resultList.size();
			return ((Admin)resultList.get(size-1)).getId();
		}
	}
	
	//验证用户登录名是否存在
	@SuppressWarnings("unchecked")
	public Admin getAdminByUsername(String adminName) {
		String hql = "from Admin admin where admin.username=?";
		List<Admin> resultList = executeQuery(hql, adminName);
		if(resultList.isEmpty()) {
			return null;
		} else {
			return resultList.get(0);
		}
	}
	
	//验证用户登录名是否存在
	@SuppressWarnings("unchecked")
	public Admin getAdminById(int id) {
		String hql = "from Admin admin where admin.id=?";
		List<Admin> resultList = executeQuery(hql, id);
		if(resultList.isEmpty()) {
			return null;
		} else {
			return resultList.get(0);
		}
	}
	
	//根据id删除用户
	public void deleteAdminById(int id) {
		String sql = "delete from t_park_admin_role where admin="+id;
		jdbcUtil.delete(sql);
		String hql = "delete from Admin admin where admin.id=?";
		Query q = getSession().createQuery(hql);
		q.setInteger(0, id);
		q.executeUpdate();
	}
	
	@SuppressWarnings("unchecked")
	public List<Admin> getAllAdmin(){
		String hql = "from Admin admin";
		List resultList = executeQuery(hql);
		if (resultList.isEmpty())
			return null;
		else {
			return resultList;
		}

	}
}
