/**
 * 
 */
package com.hgsoft.service;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.StoreCardDateDao;
import com.hgsoft.entity.StoreCardDate;

/**
 * @author qinzuohai
 *
 */
@Service
public class StoreCardDateService extends BaseService<StoreCardDate> {

	@Autowired
	public void setDao(@Qualifier("storeCardDateDao") StoreCardDateDao dao) {
		super.setDao(dao);
	}

	private StoreCardDateDao getStoreCardDateDao() {
		return (StoreCardDateDao) this.getDao();
	}

	public boolean Update(Date firTime) {
		return getStoreCardDateDao().Update(firTime);
	}
}
