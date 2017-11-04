package com.hgsoft.dao;

import java.util.List;
import org.springframework.stereotype.Repository;
import com.hgsoft.entity.AreaInformation;

@Repository 
public class AreaInformationDao extends BaseDao<AreaInformation>{
	
	//验证保存或者修改区域信息时，是否存在相同的区域编码
	@SuppressWarnings("unchecked")
	public List<AreaInformation> ishasAreaNo(Object areaNo){
		String hql="select areaInfo.areaNo from AreaInformation areaInfo where areaInfo.areaNo=?";
		List<AreaInformation> list=executeQuery(hql,areaNo);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	
	@SuppressWarnings("unchecked")
	public List<AreaInformation> LoadArea(Object cityNo){
		String hql="from AreaInformation areaInfo where areaInfo.cityNo=?";
		List<AreaInformation> list=executeQuery(hql,cityNo);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	
	//取所有区域
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<AreaInformation> getAllAreaInformation() {
		String hql = "from AreaInformation areaInformation";

		List resultList = executeQuery(hql);
		if(resultList.isEmpty()) {
			return null;
		} else {
			return resultList;
		}
	}
	
	//验证区域是否存在
	public AreaInformation findAreaByName(String areaName) {
		String hql = "from AreaInformation areaInfo where areaInfo.areaName=?";
		@SuppressWarnings("rawtypes")
		List resultList = executeQuery(hql, areaName);
		if(resultList.isEmpty()) {
			return null;
		} else {
			return (AreaInformation)resultList.get(0);
		}
	}
	
	public boolean findAreaNameByNoThisAreaNo(Short areaNo,String areaName) {
		String hql = "from AreaInformation areaInfo where areaInfo.areaNo!=?";
		@SuppressWarnings("unchecked")
		List<AreaInformation> resultList = this.executeQuery(hql, areaNo);
		for(int i=0;i<resultList.size();i++){
			if(areaName.trim().equals(resultList.get(i).getAreaName().trim()))
				return true;
		}
		return false;
	}
}
