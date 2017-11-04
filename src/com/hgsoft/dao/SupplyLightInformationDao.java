package com.hgsoft.dao;

import java.util.List;
import org.springframework.stereotype.Repository;
import com.hgsoft.entity.SupplyLightInformation;
@Repository 
public class SupplyLightInformationDao extends BaseDao<SupplyLightInformation>{
	
	//��֤��������޸Ĳ����ʱ����Ϣʱ���Ƿ������ͬ�Ĳ����ʱ����Ϣ
	@SuppressWarnings("unchecked")
	public List<SupplyLightInformation> ishasStartTime(Object startTime){
		String hql="select supplyLightInfo.startTime from SupplyLightInformation supplyLightInfo where supplyLightInfo.startTime=?";
		List<SupplyLightInformation> list=executeQuery(hql,startTime);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
}
