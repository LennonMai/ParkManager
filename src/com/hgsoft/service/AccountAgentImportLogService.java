package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.AccountAgentImportLogDao;
import com.hgsoft.entity.AccountAgentImportLog;
import com.hgsoft.util.Pager;

/**
 * 粤通卡接口数据导入日志Service
 * 
 * @author caijunhua
 *
 */

@Service
public class AccountAgentImportLogService extends BaseService<AccountAgentImportLog> {

	@Autowired
	public void setDao(@Qualifier("accountAgentImportLogDao") AccountAgentImportLogDao dao) {
		super.setDao(dao);
	}

	private AccountAgentImportLogDao getAccountAgentImportLogDao() {
		return (AccountAgentImportLogDao) this.getDao();
	}

	/**
	 * 根据查询条件查询粤通卡接口数据导入日志
	 * 
	 * @param pager
	 * @param startTime
	 *            开始时间
	 * @param endTime
	 *            结束时间
	 * @return
	 */
	public List<AccountAgentImportLog> findAccountAgentImportLogByHql(Pager pager, String startTime, String endTime) {
		return getAccountAgentImportLogDao().findAccountAgentImportLogByHql(pager, startTime, endTime);
	}

}
