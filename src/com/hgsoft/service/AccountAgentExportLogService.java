package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.AccountAgentExportLogDao;
import com.hgsoft.entity.AccountAgentExportLog;
import com.hgsoft.util.Pager;

/**
 * 粤通卡接口数据导出日志Service
 * 
 * @author caijunhua
 *
 */

@Service
public class AccountAgentExportLogService extends BaseService<AccountAgentExportLog> {

	@Autowired
	public void setDao(@Qualifier("accountAgentExportLogDao") AccountAgentExportLogDao dao) {
		super.setDao(dao);
	}

	private AccountAgentExportLogDao getAccountAgentExportLogDao() {
		return (AccountAgentExportLogDao) this.getDao();
	}

	/**
	 * 根据查询条件查询粤通卡接口数据导出日志
	 * 
	 * @param pager
	 * @param startTime
	 *            开始时间
	 * @param endTime
	 *            结束时间
	 * @return
	 */
	public List<AccountAgentExportLog> findAccountAgentExportLogByHql(Pager pager, String startTime, String endTime,
			String PackNo) {
		return getAccountAgentExportLogDao().findAccountAgentExportLogByHql(pager, startTime, endTime, PackNo);
	}

	public List<String> getPackNo() {
		return getAccountAgentExportLogDao().getPackNo();
	}

}
