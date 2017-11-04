/**
 * 
 */
package com.hgsoft.service;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.TollyCardDateDao;
import com.hgsoft.entity.TollyCardDate;

/**
 * @author qinzuohai
 *
 */
@Service
public class TollyCardDateService extends BaseService<TollyCardDate> {

	@Autowired
	public void setDao(@Qualifier("tollyCardDateDao") TollyCardDateDao dao) {
		super.setDao(dao);
	}

	private TollyCardDateDao getTollyCardDateDao() {
		return (TollyCardDateDao) this.getDao();
	}

	public boolean Update(Date firTime) {
		return getTollyCardDateDao().Update(firTime);
	}

}
