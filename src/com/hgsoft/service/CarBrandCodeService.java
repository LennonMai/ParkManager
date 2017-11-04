package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.CarBrandCodeDao;
import com.hgsoft.entity.CarBrandCode;
import com.hgsoft.util.Pager;

@Service
public class CarBrandCodeService extends BaseService<CarBrandCode> {

	@Autowired
	public void setDao(@Qualifier("carBrandCodeDao") CarBrandCodeDao dao) {
		super.setDao(dao);
	}

	private CarBrandCodeDao getCarBrandCodeDao() {
		return (CarBrandCodeDao) this.getDao();
	}

	public List<CarBrandCode> findByCondition(Pager pager, Integer brandNo, String brandName) {
		return getCarBrandCodeDao().findByCondition(pager, brandNo, brandName);
	}

}
