package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.OwnerIdentityDao;
import com.hgsoft.entity.OwnerIdentity;

@Service
public class OwnerIdentityService extends BaseService<OwnerIdentity> {

	@Autowired
	public void setDao(@Qualifier("ownerIdentityDao") OwnerIdentityDao dao) {
		super.setDao(dao);
	}

	private OwnerIdentityDao getOwnerIdentityDao() {
		return (OwnerIdentityDao) this.getDao();
	}

	public List<OwnerIdentity> getAllOwnerIdentity() {
		return getOwnerIdentityDao().getAllOwnerIdentity();
	}
}
