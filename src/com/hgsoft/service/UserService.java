package com.hgsoft.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.UserDao;
import com.hgsoft.entity.User;

@Service
public class UserService extends BaseService<User> {

	@Autowired
	public void setDao(@Qualifier("userDao") UserDao dao) {
		super.setDao(dao);
	}

	private UserDao getUserDao() {
		return (UserDao) this.getDao();
	}

	public int getMaxSysID() {
		return getUserDao().getMaxSysID();
	}

	public int insertUser(int sys_id, String userName, int credentialsType, String credentialsNo, String phone,
			String mobileNumber, String address) {
		return getUserDao().insertUser(sys_id, userName, credentialsType, credentialsNo, phone, mobileNumber, address);
	}

}
