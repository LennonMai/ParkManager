/**
 * 
 */
package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.PriceRule_zdDao;
import com.hgsoft.entity.PriceRule_zd;

/**
 * @author qinzuohai
 * 
 */
@Service
public class PriceRule_zdService extends BaseService<PriceRule_zd> {

	@Autowired
	public void setDao(@Qualifier("priceRule_zdDao") PriceRule_zdDao dao) {
		super.setDao(dao);
	}

	private PriceRule_zdDao getPriceRule_zdDao() {
		return (PriceRule_zdDao) this.getDao();
	}

	public List<PriceRule_zd> ishasPriceRule_zd(Object feeRuleType, Object vehTypeNo) {
		return getPriceRule_zdDao().ishasPriceRule_zd(feeRuleType, vehTypeNo);
	}

	public List<PriceRule_zd> LoadPriceRule_zd(Object feeRuleType, Object vehTypeNo) {
		return getPriceRule_zdDao().LoadPriceRule_zd(feeRuleType, vehTypeNo);
	}

	public boolean deleteByCompositeID(Object feeRuleType, Object vehTypeNo) {
		return getPriceRule_zdDao().deleteByCompositeID(feeRuleType, vehTypeNo);
	}

}
