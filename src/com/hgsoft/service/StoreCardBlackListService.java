package com.hgsoft.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.StoreCardBlackListDao;
import com.hgsoft.entity.StoreCardBlackList;
import com.hgsoft.util.Pager;

@Service
public class StoreCardBlackListService extends BaseService<StoreCardBlackList> {

	@Autowired
	public void setDao(@Qualifier("storeCardBlackListDao") StoreCardBlackListDao dao) {
		super.setDao(dao);
	}

	private StoreCardBlackListDao getStoreCardBlackListDao() {
		return (StoreCardBlackListDao) this.getDao();
	}

	public StoreCardBlackList getStoreCardBlackListByCardNo(String cardNo) {
		return getStoreCardBlackListDao().getStoreCardBlackListByCardNo(cardNo);
	}

	public List<StoreCardBlackList> ishasStoreCardBlackList(Object scCode) {
		return getStoreCardBlackListDao().ishasStoreCardBlackList(scCode);
	}

	public List<StoreCardBlackList> LoadStoreCardBlackList(Object scCode) {
		return getStoreCardBlackListDao().LoadStoreCardBlackList(scCode);
	}

	public List<StoreCardBlackList> findByCondition(Pager pager, String scCode, String genCau, Date genTime) {
		return getStoreCardBlackListDao().findByCondition(pager, scCode, genCau, genTime);
	}

	public void delete(String scCode) {
		if (this.ishasStoreCardBlackList(scCode) != null) {
			this.deleteById(scCode);
		}
	}
}
