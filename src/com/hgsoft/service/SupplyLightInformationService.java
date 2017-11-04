/**
 * 
 */
package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.SupplyLightInformationDao;
import com.hgsoft.entity.SupplyLightInformation;
import com.hgsoft.util.Order;

/**
 * 补光灯时间信息
 * 
 * @author qinzuohai
 */
@Service
public class SupplyLightInformationService extends BaseService<SupplyLightInformation> {

	@Autowired
	public void setDao(@Qualifier("supplyLightInformationDao") SupplyLightInformationDao dao) {
		super.setDao(dao);
	}

	private SupplyLightInformationDao getSupplyLightInformationDao() {
		return (SupplyLightInformationDao) this.getDao();
	}

	public List<SupplyLightInformation> findAll() {
		return getSupplyLightInformationDao().findAll(Order.asc("startTime"));
	}

	public List<SupplyLightInformation> ishasStartTime(Object startTime) {
		return getSupplyLightInformationDao().ishasStartTime(startTime);
	}

	public void delete(String startTime) {
		if (this.ishasStartTime(startTime) != null) {
			this.deleteById(startTime);
		}
	}
}
