/**
 * 
 */
package com.hgsoft.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.hgsoft.entity.VehFreeTimes;

/**
 * @author qinzuohai
 *
 */
@Repository
public class VehFreeTimesDao extends BaseDao<VehFreeTimes>{
	//验证唯一性
	@SuppressWarnings("unchecked")
	public List<VehFreeTimes> ishasVehFreeTimes(Object vehPlate){
		String hql=" from VehFreeTimes vehFreeTimes where vehFreeTimes.vehPlate=?  ";
		 List<VehFreeTimes> list=executeQuery(hql,vehPlate);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	
	//加载VehFreeTimes
	@SuppressWarnings("unchecked")
	public  List<VehFreeTimes> LoadVehFreeTimes(Object vehPlate){
		
		String hql=" from VehFreeTimes vehFreeTimes where vehFreeTimes.vehPlate=?  ";
		List<VehFreeTimes> list=executeQuery(hql,vehPlate);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	
	//根据主键删除数据
	public boolean deleteByVehPlate(Object vehPlate){
		VehFreeTimes vehFreeTimes=this.LoadVehFreeTimes(vehPlate).get(0);
		getSession().clear();
		getSession().refresh(vehFreeTimes);
		getSession().merge(vehFreeTimes);
		getSession().delete(vehFreeTimes);
		if (this.LoadVehFreeTimes(vehPlate) == null)
			return true;
		else
			return false;
	}
}
