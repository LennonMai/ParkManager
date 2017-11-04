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
	//��֤Ψһ��
	@SuppressWarnings("unchecked")
	public List<VehFreeTimes> ishasVehFreeTimes(Object vehPlate){
		String hql=" from VehFreeTimes vehFreeTimes where vehFreeTimes.vehPlate=?  ";
		 List<VehFreeTimes> list=executeQuery(hql,vehPlate);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	
	//����VehFreeTimes
	@SuppressWarnings("unchecked")
	public  List<VehFreeTimes> LoadVehFreeTimes(Object vehPlate){
		
		String hql=" from VehFreeTimes vehFreeTimes where vehFreeTimes.vehPlate=?  ";
		List<VehFreeTimes> list=executeQuery(hql,vehPlate);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	
	//��������ɾ������
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
