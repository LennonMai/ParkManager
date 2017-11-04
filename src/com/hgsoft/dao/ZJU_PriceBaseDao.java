/**
 * 
 */
package com.hgsoft.dao;

import java.util.List;

import org.springframework.stereotype.Repository;
import com.hgsoft.entity.ZJU_PriceBase;

/**
 * @author qinzuohai
 * 
 */
@Repository
public class ZJU_PriceBaseDao extends BaseDao<ZJU_PriceBase>{
	//验证费率唯一性
	@SuppressWarnings("unchecked")
	public List<ZJU_PriceBase> ishasZJU_PriceBase(Object verNo,Object feeNo,Object rebateType,Object inOutSign,Object timesSign,Object vehTypeNo){
		String hql=" from ZJU_PriceBase ZJUpriceBase where ZJUpriceBase.verNo=? and ZJUpriceBase.feeNo=? " +
				   " and ZJUpriceBase.rebateType=? and ZJUpriceBase.inOutSign=?"+
		           " and ZJUpriceBase.timesSign=? and ZJUpriceBase.vehTypeNo=?";
		List<ZJU_PriceBase> list=executeQuery(hql,verNo,feeNo,rebateType,inOutSign,timesSign,vehTypeNo);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	
	//加载White_PriceBase
	@SuppressWarnings("unchecked")
	public List<ZJU_PriceBase> LoadZJU_PriceBase(Object verNo,Object feeNo,Object rebateType,Object inOutSign,Object timesSign,Object vehTypeNo){
		
		String hql=" from ZJU_PriceBase ZJUpriceBase where ZJUpriceBase.verNo=? and ZJUpriceBase.feeNo=? " +
		   " and ZJUpriceBase.rebateType=? and ZJUpriceBase.inOutSign=?"+
        " and ZJUpriceBase.timesSign=? and ZJUpriceBase.vehTypeNo=?";
		List<ZJU_PriceBase> list=executeQuery(hql,verNo,feeNo,rebateType,inOutSign,timesSign,vehTypeNo);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	
	//根据联合主键删除数据
	public boolean deleteBycompositeID(Object verNo,Object feeNo,Object rebateType,Object inOutSign,Object timesSign,Object vehTypeNo){
		ZJU_PriceBase ZJUPriceBase=this.LoadZJU_PriceBase(verNo,feeNo,rebateType,inOutSign,timesSign,vehTypeNo).get(0);
		getSession().clear();
		getSession().refresh(ZJUPriceBase);
		getSession().merge(ZJUPriceBase);
		getSession().delete(ZJUPriceBase);
		if (this.LoadZJU_PriceBase(verNo,feeNo,rebateType,inOutSign,timesSign,vehTypeNo)== null)
			return true;
		else
			return false;
	}
	
	//取费率号的最大值
	public Integer findMaxFeeNo(){
		String hql="select Max(ZJUPriceBase.feeNo) from ZJU_PriceBase ZJUPriceBase " ;
		@SuppressWarnings("rawtypes")
		List list=executeQuery(hql);
		if(list.get(0)==null){
			return 0;
		}
		else return Integer.valueOf(list.get(0).toString()); 
	}
}
