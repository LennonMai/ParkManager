package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.CarTypeDao;
import com.hgsoft.entity.CarType;
import com.hgsoft.entity.CardType;
import com.hgsoft.util.Pager;

@Service
public class CarTypeService extends BaseService<CarType> {

	@Autowired
	public void setDao(@Qualifier("carTypeDao") CarTypeDao dao) {
		super.setDao(dao);
	}

	private CarTypeDao getCarTypeDao() {
		return (CarTypeDao) this.getDao();
	}

	public List<CardType> getAllCarType() {
		return getCarTypeDao().getAllCarType();
	}

	public CarType getCarTypeByCarType(Integer carType) {
		return getCarTypeDao().getCarTypeByCarType(carType);
	}

	public List<CardType> getAllCarType(Pager pager) {
		return getCarTypeDao().getAllCarType(pager);
	}

	public void saveCarType(CarType carType) {
		getCarTypeDao().save(carType);
	}

	public void updateCarType(CarType carType) {
		getCarTypeDao().update(carType);
	}

	public void deleteCarType(Integer id) {
		this.deleteById(id);
	}
}
