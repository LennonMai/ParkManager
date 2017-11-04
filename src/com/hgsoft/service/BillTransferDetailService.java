package com.hgsoft.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.BillTransferDetailDao;
import com.hgsoft.entity.BillTransferDetail;

@Service
public class BillTransferDetailService extends BaseService<BillTransferDetail> {

	@Autowired
	public void setDao(@Qualifier("billTransferDetailDao") BillTransferDetailDao dao) {
		super.setDao(dao);
	}

	private BillTransferDetailDao getBillTransferDetailDao() {
		return (BillTransferDetailDao) this.getDao();
	}

	public Integer getMaxRecNO() {
		return getBillTransferDetailDao().getMaxRecNO();
	}

}
