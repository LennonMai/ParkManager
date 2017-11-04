package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.BillStorageDao;
import com.hgsoft.entity.BillStorage;
import com.hgsoft.util.Pager;

@Service
public class BillStorageService extends BaseService<BillStorage> {

	@Autowired
	public void setDao(@Qualifier("billStorageDao") BillStorageDao dao) {
		super.setDao(dao);
	}

	private BillStorageDao getBillStorageDao() {
		return (BillStorageDao) this.getDao();
	}

	public List<BillStorage> findAllItemByHql(Pager pager, Integer hankNo, Short position, Short billType,
			String billHead) {
		return getBillStorageDao().findAllItemByHql(pager, hankNo, position, billType, billHead);
	}

	public List<BillStorage> getBillStorageByPosition(short position) {
		return getBillStorageDao().getBillStorageByPosition(position);
	}

}
