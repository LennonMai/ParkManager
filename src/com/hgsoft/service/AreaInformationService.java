/**
 * 
 */
package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.AreaInformationDao;
import com.hgsoft.entity.AreaInformation;

/**
 * 区域信息
 * 
 * @author qinzuohai
 */
@Service
public class AreaInformationService extends BaseService<AreaInformation> {

	@Autowired
	public void setDao(@Qualifier("areaInformationDao") AreaInformationDao dao) {
		super.setDao(dao);
	}

	private AreaInformationDao getAreaInformationDao() {
		return (AreaInformationDao) this.getDao();
	}

	public List<AreaInformation> ishasAreaNo(Object areaNo) {
		return getAreaInformationDao().ishasAreaNo(areaNo);
	}

	public List<AreaInformation> LoadArea(Object cityNo) {
		return getAreaInformationDao().LoadArea(cityNo);
	}

	// 取所有区域
	public List<AreaInformation> getAllAreaInformation() {
		return getAreaInformationDao().getAllAreaInformation();
	}

	public AreaInformation findAreaByName(String areaName) {
		return getAreaInformationDao().findAreaByName(areaName);
	}

	public boolean findAreaNameByNoThisAreaNo(Short areaNo, String areaName) {
		return getAreaInformationDao().findAreaNameByNoThisAreaNo(areaNo, areaName);
	}

	public void delete(Short areaNo) {
		if (this.ishasAreaNo(areaNo) != null) {
			this.deleteById(areaNo);
		}
	}
}
