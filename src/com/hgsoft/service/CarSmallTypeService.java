package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.CarSmallTypeDao;
import com.hgsoft.entity.CarSmallType;
import com.hgsoft.util.Pager;

@Service
public class CarSmallTypeService extends BaseService<CarSmallType> {

	@Autowired
	public void setDao(@Qualifier("carSmallTypeDao") CarSmallTypeDao dao) {
		super.setDao(dao);
	}

	private CarSmallTypeDao getCarSmallTypeDao() {
		return (CarSmallTypeDao) this.getDao();
	}

	public List findSmallTypeByCarType(Integer carType) {
		return getCarSmallTypeDao().findSmallTypeByCarType(carType);
	}

	public List findAllCarSmallType() {
		return getCarSmallTypeDao().findAllCarSmallType();
	}

	public CarSmallType findCarSmallTypeById(Integer carType, Integer carSmallType) {
		return getCarSmallTypeDao().findCarSmallTypeById(carType, carSmallType);
	}

	public void saveCarSmallType(CarSmallType carSmallType) {
		getCarSmallTypeDao().save(carSmallType);
	}

	public void updateCarSmallType(CarSmallType carSmallType) {
		getCarSmallTypeDao().update(carSmallType);
	}

	public void deleteCarSmallType(CarSmallType carSmallType) {
		getCarSmallTypeDao().delete(carSmallType);
	}

	public List findAllCarSmallType(Pager pager) {
		return getCarSmallTypeDao().findAllCarSmallType(pager);
	}
}
