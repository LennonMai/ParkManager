package com.hgsoft.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.CarDao;
import com.hgsoft.entity.Car;

@Service
public class CarService extends BaseService<Car> {

	@Autowired
	public void setDao(@Qualifier("carDao") CarDao dao) {
		super.setDao(dao);
	}

	private CarDao getCarDao() {
		return (CarDao) this.getDao();
	}

	public Car getCar(String vehPlate) {
		return getCarDao().getCar(vehPlate);
	}

}
