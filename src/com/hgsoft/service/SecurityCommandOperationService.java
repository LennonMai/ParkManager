package com.hgsoft.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hgsoft.dao.SecurityCommandOperationDao;
import com.hgsoft.entity.SecurityCommandOperation;

@Service
public class SecurityCommandOperationService {

	@Resource
	private SecurityCommandOperationDao securityCommandOperationDao;

	public void save(SecurityCommandOperation operation) {
		securityCommandOperationDao.save(operation);
	}

	public Long getCount(String commandId) {
		return securityCommandOperationDao.getCount(commandId);
	}

	public Long getAllCount() {
		return securityCommandOperationDao.getAllCount();
	}
}
