package com.hgsoft.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.RoleDao;
import com.hgsoft.entity.Role;

@Service
public class RoleService extends BaseService<Role> {

	@Autowired
	public void setDao(@Qualifier("roleDao") RoleDao dao) {
		super.setDao(dao);
	}

	private RoleDao getRoleDao() {
		return (RoleDao) this.getDao();
	}

	public Role getRoleByName(String roleName) { // ��֤��ɫ���Ƿ����
		return getRoleDao().getRoleByName(roleName);
	}

	public void deleteRoleById(int id) {
		getRoleDao().deleteRoleById(id);
	}

}
