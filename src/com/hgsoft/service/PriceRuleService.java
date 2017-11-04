package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.PriceRuleDao;
import com.hgsoft.entity.PriceRule;
import com.hgsoft.util.Pager;

@Service
public class PriceRuleService extends BaseService<PriceRule> {

	@Autowired
	public void setDao(@Qualifier("priceRuleDao") PriceRuleDao dao) {
		super.setDao(dao);
	}

	private PriceRuleDao getPriceRuleDao() {
		return (PriceRuleDao) this.getDao();
	}

	public List<PriceRule> ishasPriceRule(Object parkNo, Object feeTypeNo, Object vehTypeNo, Object startRange) {
		return getPriceRuleDao().ishasPriceRule(parkNo, feeTypeNo, vehTypeNo, startRange);
	}

	public List<PriceRule> LoadPriceRule(Object parkNo, Object feeTypeNo, Object vehTypeNo, Object startRange) {
		return getPriceRuleDao().LoadPriceRule(parkNo, feeTypeNo, vehTypeNo, startRange);
	}

	public boolean deleteBycompositeID(Object parkNo, Object feeTypeNo, Object vehTypeNo, Object startRange) {
		return getPriceRuleDao().deleteBycompositeID(parkNo, feeTypeNo, vehTypeNo, startRange);
	}

	public List<PriceRule> findByCondition(Pager pager, Integer verNo, Short feeTypeNo, Short vehTypeNo) {
		return getPriceRuleDao().findByCondition(pager, verNo, feeTypeNo, vehTypeNo);
	}
}
