package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.DeviceErrorCodeDao;
import com.hgsoft.entity.DeviceErrorCode;
import com.hgsoft.util.Pager;

@Service
public class DeviceErrorCodeService extends BaseService<DeviceErrorCode> {

	@Autowired
	public void setDao(@Qualifier("deviceErrorCodeDao") DeviceErrorCodeDao dao) {
		super.setDao(dao);
	}

	private DeviceErrorCodeDao getDeviceErrorCodeDao() {
		return (DeviceErrorCodeDao) this.getDao();
	}

	public List<DeviceErrorCode> findByCondition(Pager pager, Short deviceErrorNo, String deviceErrorName,
			Short deviceNo) {
		return getDeviceErrorCodeDao().findByCondition(pager, deviceErrorNo, deviceErrorName, deviceNo);
	}

}
