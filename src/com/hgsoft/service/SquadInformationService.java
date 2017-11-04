/**
 * 
 */
package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.SquadInformationDao;
import com.hgsoft.entity.SquadInformation;
import com.hgsoft.util.Order;

/**
 * 车位信息
 * 
 * @author qinzuohai
 */
@Service
public class SquadInformationService extends BaseService<SquadInformation> {

	@Autowired
	public void setDao(@Qualifier("squadInformationDao") SquadInformationDao dao) {
		super.setDao(dao);
	}

	private SquadInformationDao getSquadInformationDao() {
		return (SquadInformationDao) this.getDao();
	}

	public List<SquadInformation> findAll() {
		return getSquadInformationDao().findAll(Order.asc("squadNo"));
	}

	public List<SquadInformation> ishasSquadNo(Object squadNo) {
		return getSquadInformationDao().ishasSquadNo(squadNo);
	}

	public List<SquadInformation> getAllSquadInformation() {
		return getSquadInformationDao().getAllSquadInformation();
	}

	public SquadInformation findSquadByName(String squadName) {
		return getSquadInformationDao().findSquadByName(squadName);
	}

	public boolean findSquadNameByNoThisSquadNo(Short squadNo, String squadName) {
		return getSquadInformationDao().findSquadNameByNoThisSquadNo(squadNo, squadName);
	}

	public void delete(Short squadNo) {
		if (this.ishasSquadNo(squadNo) != null) {
			this.deleteById(squadNo);
		}
	}
}
