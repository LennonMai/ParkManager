package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.CarTypeTransDao;
import com.hgsoft.entity.CarTypeTrans;
import com.hgsoft.util.Pager;

@Service
public class CarTypeTransService extends BaseService<CarTypeTrans> {

	@Autowired
	public void setDao(@Qualifier("carTypeTransDao") CarTypeTransDao dao) {
		super.setDao(dao);
	}

	private CarTypeTransDao getCarTypeTransDao() {
		return (CarTypeTransDao) this.getDao();
	}

	public List<CarTypeTrans> findByCondition(Pager pager, String startDate, String class_, Integer weight,
			String vehType) {
		return getCarTypeTransDao().findByCondition(pager, startDate, class_, weight, vehType);
	}

}
