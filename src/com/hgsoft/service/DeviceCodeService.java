package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.DeviceCodeDao;
import com.hgsoft.entity.DeviceCode;
import com.hgsoft.util.Pager;

@Service
public class DeviceCodeService extends BaseService<DeviceCode> {

	@Autowired
	public void setDao(@Qualifier("deviceCodeDao") DeviceCodeDao dao) {
		super.setDao(dao);
	}

	private DeviceCodeDao getDeviceCodeDao() {
		return (DeviceCodeDao) this.getDao();
	}

	public List<DeviceCode> findByCondition(Pager pager, Short deviceNo, String deviceName) {
		return getDeviceCodeDao().findByCondition(pager, deviceNo, deviceName);
	}

}
