package com.hgsoft.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;
import com.hgsoft.entity.PriceBase;
import com.hgsoft.util.Pager;


@Repository
public class PriceBaseDao extends BaseDao<PriceBase> {

	//验证费率唯一性
	@SuppressWarnings("unchecked")
	public List<PriceBase> ishasPriceBase(Object verNo,Object feeNo,Object rebateType,Object inOutSign,Object timesSign,Object vehTypeNo){
		String hql=" from PriceBase priceBase where priceBase.verNo=? and priceBase.feeNo=? " +
				   " and priceBase.rebateType=? and priceBase.inOutSign=?"+
		           " and priceBase.timesSign=? and priceBase.vehTypeNo=?";
		 List<PriceBase> list=executeQuery(hql,verNo,feeNo,rebateType,inOutSign,timesSign,vehTypeNo);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	
	//加载PriceRule
	@SuppressWarnings("unchecked")
	public List<PriceBase> LoadPriceBase(Object verNo,Object feeNo,Object rebateType,Object inOutSign,Object timesSign,Object vehTypeNo){
		String hql=" from PriceBase priceBase where priceBase.verNo=? and priceBase.feeNo=? " +
		   " and priceBase.rebateType=? and priceBase.inOutSign=?"+
           " and priceBase.timesSign=? and priceBase.vehTypeNo=?";	
		 List<PriceBase> list=executeQuery(hql,verNo,feeNo,rebateType,inOutSign,timesSign,vehTypeNo);
		if(!list.isEmpty()){
			list.get(0).setStayAdd(list.get(0).getStayAdd()/60);
			list.get(0).setAddFee(list.get(0).getAddFee()/10);
			list.get(0).setMaxFee(list.get(0).getMaxFee()/10);
			return list;
		}else
			return null;
	}
	
	//根据联合主键删除数据
	public boolean deleteBycompositeID(Object verNo,Object feeNo,Object rebateType,Object inOutSign,Object timesSign,Object vehTypeNo){
	    List<PriceBase> li=this.LoadPriceBase(verNo,feeNo,rebateType,inOutSign,timesSign,vehTypeNo);
	    if(li!=null){
	    	PriceBase priceBase=li.get(0);
			getSession().clear();
			getSession().refresh(priceBase);
			getSession().merge(priceBase);
			getSession().delete(priceBase);
	    }
		
		if (this.LoadPriceBase(verNo,feeNo,rebateType,inOutSign,timesSign,vehTypeNo)==null)
			return true;
		else
			return false;
	}
	
	//取费率号的最大值
	public Integer findMaxFeeNo(){
		String hql="select Max(priceBase.feeNo) from PriceBase priceBase " ;
		@SuppressWarnings("rawtypes")
		List list=executeQuery(hql);
		if(list.get(0)==null){
			return 0;
		}
		else return Integer.valueOf(list.get(0).toString()); 
		
	}
	
	@SuppressWarnings("unchecked")
	public List<PriceBase> findByCondition(Pager pager,
			Integer verNo, Integer vehTypeNo, Integer feeNo) {

		StringBuffer sf = new StringBuffer(
				"from PriceBase priceBase where");
		List<Object> obj = new ArrayList<Object>();
		if (verNo!=null) {
			sf.append(" priceBase.verNo = ? and");
			obj.add(verNo);
		}
		if (vehTypeNo!=null) {
			sf.append(" priceBase.vehTypeNo = ? and");
			obj.add(vehTypeNo);
		}
		if (feeNo!=null) {
			sf.append(" priceBase.feeNo = ? and");
			obj.add(feeNo);
		}
		
		sf = sf.replace(sf.length() - 4, sf.length(), "");
		// 查出总行数，对分页进行设置
		
		Long count = this.executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
		return this.executeQuery(pager, sf.toString(), obj.toArray());
	}
}
