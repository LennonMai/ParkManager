package com.hgsoft.dao;

import java.util.List;
import org.springframework.stereotype.Repository;
import com.hgsoft.entity.CityInformation;

/**
 * ������Ϣ
 * 
 * @author qinzuohai
 */
@Repository
public class CityInformationDao extends BaseDao<CityInformation> {

	// ��֤��������޸ĳ�����Ϣʱ���Ƿ������ͬ�ĳ��б���
	@SuppressWarnings("unchecked")
	public List<CityInformation> ishasCityNo(Object cityNo) {
		String hql = "select cityInfo.cityNo from CityInformation cityInfo where cityInfo.cityNo=?";
		if (!executeQuery(hql, cityNo).isEmpty()) {
			return executeQuery(hql, cityNo);
		} else
			return null;
	}
	

	// ��֤�������Ƿ����

	public CityInformation findCityByName(String cityName) {
		String hql = "from CityInformation cityInfo where cityInfo.cityName=?";
		@SuppressWarnings("rawtypes")
		List resultList = executeQuery(hql, cityName);
		if (resultList.isEmpty()) {
			return null;
		} else {
			return (CityInformation) resultList.get(0);
		}
	}
	
	public boolean findCityNameByNoThisCityNo(Short cityNo,String cityName) {
		String hql = "from CityInformation cityInfo where cityInfo.cityNo!=?";
		@SuppressWarnings("unchecked")
		List<CityInformation> resultList = this.executeQuery(hql, cityNo);
		for(int i=0;i<resultList.size();i++){
			if(cityName.trim().equals(resultList.get(i).getCityName().trim()))
				return true;
		}
		return false;
	}
}
