/**
 * 
 */
package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.CityInformationDao;
import com.hgsoft.entity.CityInformation;

/**
 * 城市信息
 * 
 * @author qinzuohai
 */
@Service
public class CityInformationService extends BaseService<CityInformation> {

	@Autowired
	public void setDao(@Qualifier("cityInformationDao") CityInformationDao dao) {
		super.setDao(dao);
	}

	private CityInformationDao getCityInformationDao() {
		return (CityInformationDao) this.getDao();
	}

	public List<CityInformation> ishasCityNo(Object cityNo) {
		return getCityInformationDao().ishasCityNo(cityNo);
	}

	public CityInformation findCityByName(String cityName) {
		return getCityInformationDao().findCityByName(cityName);
	}

	public boolean findCityNameByNoThisCityNo(Short cityNo, String cityName) {
		return getCityInformationDao().findCityNameByNoThisCityNo(cityNo, cityName);
	}

	public void delete(Short cityNo) {
		if (this.ishasCityNo(cityNo) != null) {
			this.deleteById(cityNo);
		}
	}

}
