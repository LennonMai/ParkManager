package com.hgsoft.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.BillTransferDao;
import com.hgsoft.entity.BillTransfer;

@Service
public class BillTransferService extends BaseService<BillTransfer> {

	@Autowired
	public void setDao(@Qualifier("billTransferDao") BillTransferDao dao) {
		super.setDao(dao);
	}

	private BillTransferDao getBillTransferDao() {
		return (BillTransferDao) this.getDao();
	}

	public Integer getMaxRecNO() {
		return getBillTransferDao().getMaxRecNO();
	}

}
