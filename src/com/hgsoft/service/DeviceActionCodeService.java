package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.DeviceActionCodeDao;
import com.hgsoft.entity.DeviceActionCode;
import com.hgsoft.util.Pager;

@Service
public class DeviceActionCodeService extends BaseService<DeviceActionCode> {

	@Autowired
	public void setDao(@Qualifier("deviceActionCodeDao") DeviceActionCodeDao dao) {
		super.setDao(dao);
	}

	private DeviceActionCodeDao getDeviceActionCodeDao() {
		return (DeviceActionCodeDao) this.getDao();
	}

	public List<DeviceActionCode> findByCondition(Pager pager, Short deviceActionNo, String deviceActionName,
			Short deviceNo) {
		return getDeviceActionCodeDao().findByCondition(pager, deviceActionNo, deviceActionName, deviceNo);
	}

}
