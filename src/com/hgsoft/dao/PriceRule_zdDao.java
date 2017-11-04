/**
 * 
 */
package com.hgsoft.dao;

import java.util.List;
import org.springframework.stereotype.Repository;
import com.hgsoft.entity.PriceRule_zd;

/**
 * @author qinzuohai
 *
 */
@Repository
public class PriceRule_zdDao extends BaseDao<PriceRule_zd>{
	//验证唯一性
	@SuppressWarnings("unchecked")
	public List<PriceRule_zd> ishasPriceRule_zd(Object feeRuleType,Object vehTypeNo){
		String hql=" from PriceRule_zd priceRule_zd where priceRule_zd.feeRuleType=? and  priceRule_zd.vehTypeNo=? ";
		List<PriceRule_zd> list=executeQuery(hql,feeRuleType,vehTypeNo);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	
	//加载PriceRule_zd
	@SuppressWarnings("unchecked")
	public List<PriceRule_zd>  LoadPriceRule_zd(Object feeRuleType,Object vehTypeNo){
	
		String hql=" from PriceRule_zd priceRule_zd where priceRule_zd.feeRuleType=? and  priceRule_zd.vehTypeNo=? ";
		List<PriceRule_zd> list=executeQuery(hql,feeRuleType,vehTypeNo);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	
	//根据联合主键删除数据
	public boolean deleteByCompositeID(Object feeRuleType,Object vehTypeNo){
		PriceRule_zd priceRule_zd=this.LoadPriceRule_zd(feeRuleType, vehTypeNo).get(0);
		getSession().clear();
		getSession().refresh(priceRule_zd);
		getSession().merge(priceRule_zd);
		getSession().delete(priceRule_zd);
		if (this.LoadPriceRule_zd(feeRuleType, vehTypeNo) == null)
			return true;
		else
			return false;
	}
}
