package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.PricepasstypeDao;
import com.hgsoft.entity.Pricepasstype;
import com.hgsoft.util.Pager;

/**
 * 特殊车辆处理信息Service
 * 
 * @author caijunhua
 */
@Service
public class PricepasstypeService extends BaseService<Pricepasstype> {

	@Autowired
	public void setDao(@Qualifier("pricepasstypeDao") PricepasstypeDao dao) {
		super.setDao(dao);
	}

	private PricepasstypeDao getPricepasstypeDao() {
		return (PricepasstypeDao) this.getDao();
	}

	/**
	 * 判断收费类型影射是否存在
	 */
	public boolean isExist(Short parkNo, Short inGateNo, Short outGateNo, Short feeType, Short verNo) {
		return getPricepasstypeDao().isExist(parkNo, inGateNo, outGateNo, feeType, verNo);
	}

	public Pricepasstype getPricepasstype(Short parkNo, Short inGateNo, Short outGateNo, Short feeType, Short verNo) {
		return getPricepasstypeDao().getPricepasstype(parkNo, inGateNo, outGateNo, feeType, verNo);
	}

	/**
	 * 根据条件查询
	 */
	@SuppressWarnings("unchecked")
	public List<Pricepasstype> getByCondition(Pager pager, Short parkNo, Short inGateNo, Short outGateNo, Short feeType,
			Short verNo) {
		return getPricepasstypeDao().getByCondition(pager, parkNo, inGateNo, outGateNo, feeType, verNo);
	}

	/**
	 * 获取所有收费类型影射
	 * 
	 * @return
	 */
	public List<Pricepasstype> getAllPricepasstype(Pager pager) {
		return getPricepasstypeDao().getAllPricepasstype(pager);
	}

	/*
	 * public void updatePricepasstype(Short parkNo, Short inGateNo, Short
	 * outGateNo, Short feeType, Short verNo) {
	 * pricepasstypeDao.updatePricepasstype(parkNo, inGateNo, outGateNo,
	 * feeType, verNo); }
	 */
}
