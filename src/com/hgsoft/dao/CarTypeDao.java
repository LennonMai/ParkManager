package com.hgsoft.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.hgsoft.entity.CarType;
import com.hgsoft.entity.CardType;
import com.hgsoft.util.Pager;

@Repository
public class CarTypeDao extends BaseDao<CarType>{
	
	
	@SuppressWarnings("unchecked")
	public List<CardType> getAllCarType() {
		String hql = " from CarType carType ";
		List list = executeQuery(hql);
		if (list.isEmpty()) {
			return null;
		} else {
			return list;
		}
	}
	
	public List<CardType> getAllCarType(Pager pager) {
		String hql = " from CarType carType ";
		Long count = executeCount(hql);
		pager.setTotalSize(count);
		List list = executeQuery(pager, hql);
		if (list.isEmpty()) {
			return null;
		} else {
			return list;
		}
	}
	
	@SuppressWarnings("unchecked")
	public CarType getCarTypeByCarType(Integer carType ) {
		String hql = "from CarType carTypeTemp where carTypeTemp.carType=? ";
		List list = executeQuery(hql,carType);
		if (list.isEmpty()) {
			return null;
		} else {
			return (CarType)list.get(0);
		}
	}
}
