package com.hgsoft.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hgsoft.dao.SecurityCommandBackupDao;
import com.hgsoft.entity.SecurityCommandBackup;
import com.hgsoft.util.Pager;

@Service
public class SecurityCommandBackupService {

	@Resource
	private SecurityCommandBackupDao securityCommandBackupDao;

	@SuppressWarnings("unchecked")
	public List query(Pager pager, String type, String validType, String owner, String cardNo, String vehPlate) {
		return securityCommandBackupDao.query(pager, type, validType, owner, cardNo, vehPlate);
	}

	public void save(SecurityCommandBackup backup) {
		securityCommandBackupDao.save(backup);
	}

	public Long getCount(String commandId) {
		return securityCommandBackupDao.getCount(commandId);
	}

	@SuppressWarnings("unchecked")
	public List show(Pager pager, String commandId, String modId) {
		return securityCommandBackupDao.show(pager, commandId, modId);
	}
}
