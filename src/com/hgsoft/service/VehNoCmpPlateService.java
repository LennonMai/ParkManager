package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.VehNoCmpPlateDao;
import com.hgsoft.entity.VehNoCmpPlate;
import com.hgsoft.util.Pager;

@Service
public class VehNoCmpPlateService extends BaseService<VehNoCmpPlate> {

	@Autowired
	public void setDao(@Qualifier("vehNoCmpPlateDao") VehNoCmpPlateDao dao) {
		super.setDao(dao);
	}

	private VehNoCmpPlateDao getVehNoCmpPlateDao() {
		return (VehNoCmpPlateDao) this.getDao();
	}

	public List<VehNoCmpPlate> findVehNoCmpPlateByCondition(Pager pager, String vehPlate) {
		return getVehNoCmpPlateDao().findVehNoCmpPlateByCondition(pager, vehPlate);
	}

	public boolean findVehNoCmpPlate(String vehPlate) {
		return getVehNoCmpPlateDao().findVehNoCmpPlate(vehPlate);
	}

	public boolean _update(String updateVehPlate, VehNoCmpPlate vehNoCmpPlate) {
		return getVehNoCmpPlateDao()._update(updateVehPlate, vehNoCmpPlate);
	}

	public void delete(String vehPlate) {
		if (this.findVehNoCmpPlate(vehPlate) != false) {
			this.deleteById(vehPlate);
		}

	}
}
