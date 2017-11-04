package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.PriceBaseDao;
import com.hgsoft.entity.PriceBase;
import com.hgsoft.util.Pager;

@Service
public class PriceBaseService extends BaseService<PriceBase> {

	@Autowired
	public void setDao(@Qualifier("priceBaseDao") PriceBaseDao dao) {
		super.setDao(dao);
	}

	private PriceBaseDao getPriceBaseDao() {
		return (PriceBaseDao) this.getDao();
	}

	public List<PriceBase> ishasPriceBase(Object verNo, Object feeNo, Object rebateType, Object inOutSign,
			Object timesSign, Object vehTypeNo) {
		return getPriceBaseDao().ishasPriceBase(verNo, feeNo, rebateType, inOutSign, timesSign, vehTypeNo);
	}

	public List<PriceBase> LoadPriceBase(Object verNo, Object feeNo, Object rebateType, Object inOutSign,
			Object timesSign, Object vehTypeNo) {
		return getPriceBaseDao().LoadPriceBase(verNo, feeNo, rebateType, inOutSign, timesSign, vehTypeNo);
	}

	public boolean deleteBycompositeID(Object verNo, Object feeNo, Object rebateType, Object inOutSign,
			Object timesSign, Object vehTypeNo) {
		return getPriceBaseDao().deleteBycompositeID(verNo, feeNo, rebateType, inOutSign, timesSign, vehTypeNo);
	}

	public Integer findMaxFeeNo() {
		return getPriceBaseDao().findMaxFeeNo();
	}

	public List<PriceBase> findByCondition(Pager pager, Integer verNo, Integer vehTypeNo, Integer feeNo) {
		return getPriceBaseDao().findByCondition(pager, verNo, vehTypeNo, feeNo);
	}

}
