package com.hgsoft.service;

import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.AdminDao;
import com.hgsoft.entity.Admin;
import com.hgsoft.entity.Module;
import com.hgsoft.entity.Role;
import com.hgsoft.util.Order;
import com.hgsoft.util.Property;

@Service
public class AdminService extends BaseService<Admin> {

	@Autowired
	public void setDao(@Qualifier("adminDao") AdminDao dao) {
		super.setDao(dao);
	}

	public AdminDao getAdminDao() {
		return (AdminDao) this.getDao();
	}

	public Admin check(String username, String password) {
		List<Admin> list = getAdminDao().findAll(Order.asc("id"), Property.eq("username", username),
				Property.eq("password", password));
		if (list.size() > 0)
			return (Admin) list.get(0);
		else
			return null;
	}

	// 取得管理员号，900000001开始
	public int getAdminId() {
		int id = getAdminDao().getAdminId();
		return id;
	}

	public Admin getAdminById(int id) {
		return getAdminDao().getAdminById(id);
	}

	// 验证用户登录名是否存在
	public Admin getAdminByUsername(String adminName) {
		return getAdminDao().getAdminByUsername(adminName);
	}

	// 根据id删除用户
	public void deleteAdminById(int id) {
		getAdminDao().deleteAdminById(id);
	}

	public List<Admin> findAllMajor() {
		return getAdminDao().findAll(Order.asc("name"), Property.isNotEmpty("majors"));
	}

	@SuppressWarnings("unchecked")
	public String getFunctions(Admin admin) {
		String functions = "";
		Set roles = admin.getRoles();
		if (!roles.isEmpty()) {
			Iterator it = roles.iterator();

			while (it.hasNext()) {
				Role role = (Role) it.next();
				Set modules = role.getModules();
				if (!modules.isEmpty()) {
					Iterator mit = modules.iterator();
					while (mit.hasNext()) {
						Module module = (Module) mit.next();
						functions = functions + ";" + module.getUrl() + ";" + module.getFunctions();
					}
				}

			}
		}
		return functions;
	}

	/**
	 * 总审核人数
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Integer checkCount() {
		List list = getAdminDao().findAll(Order.asc("id"), new Property[] { Property.isNotEmpty("majors") });
		if (list.size() > 0)
			return list.size();
		else
			return 0;
	}

	public List<Admin> getAllAdmin() {
		return getAdminDao().getAllAdmin();
	}

}
