/**
 * 
 */
package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.VehFreeTimesDao;
import com.hgsoft.entity.VehFreeTimes;

/**
 * @author qinzuohai
 *
 */
@Service
public class VehFreeTimesService extends BaseService<VehFreeTimes> {

	@Autowired
	public void setDao(@Qualifier("vehFreeTimesDao") VehFreeTimesDao dao) {
		super.setDao(dao);
	}

	private VehFreeTimesDao getVehFreeTimesDao() {
		return (VehFreeTimesDao) this.getDao();
	}

	public List<VehFreeTimes> ishasVehFreeTimes(Object vehPlate) {
		return getVehFreeTimesDao().ishasVehFreeTimes(vehPlate);
	}

	public List<VehFreeTimes> LoadVehFreeTimes(Object vehPlate) {
		return getVehFreeTimesDao().LoadVehFreeTimes(vehPlate);
	}

	public boolean deleteByVehPlate(Object vehPlate) {
		return getVehFreeTimesDao().deleteByVehPlate(vehPlate);
	}
}
