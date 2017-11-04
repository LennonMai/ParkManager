package com.hgsoft.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.CarSpaceDynamicDao;
import com.hgsoft.entity.CarSpaceDynamic;

@Service
public class CarSpaceDynamicService extends BaseService<CarSpaceDynamic> {
	@Autowired
	public void setDao(@Qualifier("carSpaceDynamicDao") CarSpaceDynamicDao dao) {
		super.setDao(dao);
	}

	private CarSpaceDynamicDao getCarSpaceDynamicDao() {
		return (CarSpaceDynamicDao) this.getDao();
	}

	public CarSpaceDynamic getCarSpaceDynamicByRecNo(int recNo) {// 通过账号查询账户
		return getCarSpaceDynamicDao().getCarSpaceDynamicByRecNo(recNo);
	}

}
