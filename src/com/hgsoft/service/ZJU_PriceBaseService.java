package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.ZJU_PriceBaseDao;
import com.hgsoft.entity.ZJU_PriceBase;

@Service
public class ZJU_PriceBaseService extends BaseService<ZJU_PriceBase> {

	@Autowired
	public void setDao(ZJU_PriceBaseDao dao) {
		super.setDao(dao);
	}

	private ZJU_PriceBaseDao getZJU_PriceBaseDao() {
		return (ZJU_PriceBaseDao) this.getDao();
	}

	public List<ZJU_PriceBase> ishasZJU_PriceBase(Object verNo, Object feeNo, Object rebateType, Object inOutSign,
			Object timesSign, Object vehTypeNo) {
		return getZJU_PriceBaseDao().ishasZJU_PriceBase(verNo, feeNo, rebateType, inOutSign, timesSign, vehTypeNo);
	}

	public List<ZJU_PriceBase> LoadZJU_PriceBase(Object verNo, Object feeNo, Object rebateType, Object inOutSign,
			Object timesSign, Object vehTypeNo) {
		return getZJU_PriceBaseDao().LoadZJU_PriceBase(verNo, feeNo, rebateType, inOutSign, timesSign, vehTypeNo);
	}

	public boolean deleteBycompositeID(Object verNo, Object feeNo, Object rebateType, Object inOutSign,
			Object timesSign, Object vehTypeNo) {
		return getZJU_PriceBaseDao().deleteBycompositeID(verNo, feeNo, rebateType, inOutSign, timesSign, vehTypeNo);
	}

	public Integer findMaxFeeNo() {
		return getZJU_PriceBaseDao().findMaxFeeNo();
	}

}
