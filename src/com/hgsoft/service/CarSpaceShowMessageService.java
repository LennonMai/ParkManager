package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.CarSpaceShowMessageDao;
import com.hgsoft.entity.CarSpaceShowMessage;

@Service
public class CarSpaceShowMessageService extends BaseService<CarSpaceShowMessage> {

	@Autowired
	public void setDao(@Qualifier("carSpaceShowMessageDao") CarSpaceShowMessageDao dao) {
		super.setDao(dao);
	}

	private CarSpaceShowMessageDao getCarSpaceShowMessageDao() {
		return (CarSpaceShowMessageDao) this.getDao();
	}

	public List<CarSpaceShowMessage> getAllCarSpaceShowMessage() {
		return getCarSpaceShowMessageDao().getAllCarSpaceShowMessage();
	}

	public CarSpaceShowMessage getCarSpaceShowMessageByPGL(short parkNo, short gateNo, short laneNo) {
		return getCarSpaceShowMessageDao().getCarSpaceShowMessageByPGL(parkNo, gateNo, laneNo);
	}
}
