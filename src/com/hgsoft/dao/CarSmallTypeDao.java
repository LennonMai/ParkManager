package com.hgsoft.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.hgsoft.entity.CarSmallType;
import com.hgsoft.util.Pager;

@Repository
public class CarSmallTypeDao extends BaseDao<CarSmallType>{
	public List findSmallTypeByCarType(Integer carType){
		String hql = "from CarSmallType carSmallType where carSmallType.carType = "+carType;
		List list = executeQuery(hql);
		if(list==null || list.isEmpty()){
			return null;
		}else{
			return list;
		}
	}
	
	public List findAllCarSmallType(){
		String hql = "from CarSmallType carSmallType ";
		List list = executeQuery(hql);
		if(list==null || list.isEmpty()){
			return null;
		}else{
			return list;
		}
	}
	
	public List findAllCarSmallType(Pager pager){
		String hql = "from CarSmallType carSmallType ";
		Long count = executeCount(hql);
		pager.setTotalSize(count);
		List list = executeQuery(pager, hql);
		if(list==null || list.isEmpty()){
			return null;
		}else{
			return list;
		}
	}
	
	public CarSmallType findCarSmallTypeById(Integer carType, Integer carSmallType){
		String hql = "from CarSmallType carSmallType where 1=1";
		//carType、carSmallType为组合主键，必须同时存在才能确定一条记录
		if(carType!=null && !carType.equals("") && carSmallType!=null && !carSmallType.equals("")){
			hql += " and carSmallType.carType="+carType;
			hql +=" and carSmallType.carSmallType="+carSmallType;
		}
		List list = executeQuery(hql);
		
		if(list!=null && list.size()>0){
			return (CarSmallType) list.get(0);
		}else{
			return null;
		}
	}
}
