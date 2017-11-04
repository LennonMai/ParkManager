package com.hgsoft.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.ICCardTransferDao;
import com.hgsoft.entity.ICCardTransfer;

@Service
public class ICCardTransferService extends BaseService<ICCardTransfer> {

	@Autowired
	public void setDao(ICCardTransferDao dao) {
		super.setDao(dao);
	}

	private ICCardTransferDao getICCardTransferDao() {
		return (ICCardTransferDao) this.getDao();
	}

	public Integer getICCardTransferRecNo() {
		return getICCardTransferDao().getICCardTransferRecNo();
	}

}
