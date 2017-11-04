/**
 * 
 */
package com.hgsoft.service;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.OBUDateDao;
import com.hgsoft.entity.OBUDate;

/**
 * @author qinzuohai
 *
 */
@Service
public class OBUDateService extends BaseService<OBUDate> {

	@Autowired
	public void setDao(OBUDateDao dao) {
		super.setDao(dao);
	}

	private OBUDateDao getOBUDateDao() {
		return (OBUDateDao) this.getDao();
	}

	public boolean Update(Date firTime) {
		return getOBUDateDao().Update(firTime);
	}
}
