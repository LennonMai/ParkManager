package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.CarClassCodeDao;
import com.hgsoft.entity.CarClassCode;
import com.hgsoft.util.Pager;

@Service
public class CarClassCodeService extends BaseService<CarClassCode> {

	@Autowired
	public void setDao(@Qualifier("carClassCodeDao") CarClassCodeDao dao) {
		super.setDao(dao);
	}

	private CarClassCodeDao getCarClassCodeDao() {
		return (CarClassCodeDao) this.getDao();
	}

	public List<CarClassCode> findByCondition(Pager pager, Integer classNo, String className) {
		return getCarClassCodeDao().findByCondition(pager, classNo, className);
	}

}
