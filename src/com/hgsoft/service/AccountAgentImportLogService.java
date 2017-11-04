package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.AccountAgentImportLogDao;
import com.hgsoft.entity.AccountAgentImportLog;
import com.hgsoft.util.Pager;

/**
 * ��ͨ���ӿ����ݵ�����־Service
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
	 * ���ݲ�ѯ������ѯ��ͨ���ӿ����ݵ�����־
	 * 
	 * @param pager
	 * @param startTime
	 *            ��ʼʱ��
	 * @param endTime
	 *            ����ʱ��
	 * @return
	 */
	public List<AccountAgentImportLog> findAccountAgentImportLogByHql(Pager pager, String startTime, String endTime) {
		return getAccountAgentImportLogDao().findAccountAgentImportLogByHql(pager, startTime, endTime);
	}

}
