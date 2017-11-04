package com.hgsoft.dao;

import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Repository;
import com.hgsoft.entity.PriceRule;
import com.hgsoft.util.Pager;

@Repository
public class PriceRuleDao extends BaseDao<PriceRule> {

	//验证费率唯一性
	@SuppressWarnings("unchecked")
	public List<PriceRule> ishasPriceRule(Object parkNo,Object feeTypeNo,Object vehTypeNo,Object startRange){
		String hql=" from PriceRule priceRule where priceRule.parkNo=? and priceRule.feeTypeNo=? " +
				"and priceRule.vehTypeNo=? and priceRule.startRange=?";
		List<PriceRule> list=executeQuery(hql,parkNo,feeTypeNo,vehTypeNo,startRange);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	
	//加载PriceRule
	@SuppressWarnings("unchecked")
	public List<PriceRule> LoadPriceRule(Object parkNo,Object feeTypeNo,Object vehTypeNo,Object startRange){
		
		String hql="from PriceRule priceRule where priceRule.parkNo=? and priceRule.feeTypeNo=? " +
				"and priceRule.vehTypeNo=? and priceRule.startRange=?";
		List<PriceRule> list=executeQuery(hql,parkNo,feeTypeNo,vehTypeNo,startRange);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	
	//根据联合主键删除数据
	public boolean deleteBycompositeID(Object parkNo,Object feeTypeNo,Object vehTypeNo,Object startRange){
		List<PriceRule> li=this.LoadPriceRule(parkNo, feeTypeNo, vehTypeNo, startRange);
		if(li!=null){
			PriceRule priceRule=li.get(0);
			getSession().clear();
			getSession().refresh(priceRule);
			getSession().merge(priceRule);
			getSession().delete(priceRule);
		}
		
		if (this.LoadPriceRule(parkNo, feeTypeNo, vehTypeNo, startRange) == null)
			return true;
		else
			return false;
	}
	
	@SuppressWarnings("unchecked")
	public List<PriceRule> findByCondition(Pager pager,
			Integer verNo, Short feeTypeNo, Short vehTypeNo) {

		StringBuffer sf = new StringBuffer(
				"from PriceRule priceRule where");
		List<Object> obj = new ArrayList<Object>();
		if (verNo!=null) {
			sf.append(" priceRule.verNo = ? and");
			obj.add(verNo);
		}
		if (feeTypeNo!=null) {
			sf.append(" priceRule.feeTypeNo = ? and");
			obj.add(feeTypeNo);
		}
		if (vehTypeNo!=null) {
			sf.append(" priceRule.vehTypeNo = ? and");
			obj.add(vehTypeNo);
		}
		
		sf = sf.replace(sf.length() - 4, sf.length(), "");
		// 查出总行数，对分页进行设置
		
		Long count = this.executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
		return this.executeQuery(pager, sf.toString(), obj.toArray());
	}
	
}
