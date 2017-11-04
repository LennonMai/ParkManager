package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.ICCardStorageDao;
import com.hgsoft.entity.ICCardStorage;

@Service
public class ICCardStorageService extends BaseService<ICCardStorage> {

	@Autowired
	public void setDao(ICCardStorageDao dao) {
		super.setDao(dao);
	}

	private ICCardStorageDao getICCardStorageDao() {
		return (ICCardStorageDao) this.getDao();
	}

	public List<Object[]> getICCardStorageAndGatewayInformation() {
		return getICCardStorageDao().getICCardStorageAndGatewayInformation();
	}

	public ICCardStorage getICCardStorageByPosition(int position) {
		return getICCardStorageDao().getICCardStorageByPosition(position);
	}

}
