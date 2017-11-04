package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.SpecialVehDao;
import com.hgsoft.entity.SpecialVeh;
import com.hgsoft.util.Pager;

/**
 * @author qinzuohai
 */
@Service
public class SpecialVehService extends BaseService<SpecialVeh> {

	@Autowired
	public void setDao(@Qualifier("specialVehDao") SpecialVehDao dao) {
		super.setDao(dao);
	}

	private SpecialVehDao getSpecialVehDao() {
		return (SpecialVehDao) this.getDao();
	}

	public List<SpecialVeh> findSpecialVehByCondition(Pager pager, String vehPlate, String cardNo, Integer specialType,
			Short lanetype) {
		return getSpecialVehDao().findSpecialVehByCondition(pager, vehPlate, cardNo, specialType, lanetype);
	}

	public List<SpecialVeh> LoadSpecialVeh(String vehPlate, String cardNo) {
		return getSpecialVehDao().LoadSpecialVeh(vehPlate, cardNo);
	}

	public boolean deleteBycompositeID(String vehPlate, String cardNo) {
		return getSpecialVehDao().deleteBycompositeID(vehPlate, cardNo);
	}

	public boolean findSpecialVehByVehPlateCardNo(String vehPlate) {
		return getSpecialVehDao().findSpecialVehByVehPlateCardNo(vehPlate);
	}

	// ������� ��
	@SuppressWarnings("unchecked")
	public List queryMonitoring(Pager pager, String station, String road, String status, String systemType,
			String device) {
		return getSpecialVehDao().queryMonitoring(pager, station, road, status, systemType, device);
	}

	// ��������豸��Ϣ ��
	@SuppressWarnings("unchecked")
	public List allDevice() {
		return getSpecialVehDao().allDevice();
	}

	// ��������豸������Ϣ ��
	@SuppressWarnings("unchecked")
	public List allDeviceError() {
		return getSpecialVehDao().allDeviceError();
	}
}
