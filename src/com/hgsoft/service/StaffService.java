package com.hgsoft.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.StaffDao;
import com.hgsoft.entity.Staff;

@Service
public class StaffService extends BaseService<Staff> {

	@Autowired
	public void setDao(@Qualifier("staffDao") StaffDao dao) {
		super.setDao(dao);
	}

	private StaffDao getStaffDao() {
		return (StaffDao) this.getDao();
	}

	public void deleteByCardNo(String cardNo) {
		getStaffDao().deleteByCardNo(cardNo);
	}
}
