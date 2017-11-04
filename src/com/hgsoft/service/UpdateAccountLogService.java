package com.hgsoft.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.UpdateAccountLogDao;
import com.hgsoft.entity.UpdateAccountLog;
import com.hgsoft.util.Pager;

@Service
public class UpdateAccountLogService extends BaseService<UpdateAccountLog> {

	@Autowired
	public void setDao(@Qualifier("updateAccountLogDao") UpdateAccountLogDao dao) {
		super.setDao(dao);
	}

	private UpdateAccountLogDao getUpdateAccountLogDao() {
		return (UpdateAccountLogDao) this.getDao();
	}

	public int getSeqNoByAccountNo(int accountNo) {
		UpdateAccountLog updateAccountLog = getUpdateAccountLogDao().getUpdateAccountLogByAccountNoOrder(accountNo);
		if (updateAccountLog == null) {
			return 0;
		} else {
			return updateAccountLog.getSeqNo() + 1;
		}
		/*
		 * List resultList=((UpdateAccountLogDao)getDao()).
		 * getUpdateAccountLogByAccountNo(accountNo); if(resultList.isEmpty()){
		 * return 0; } else{ // int size=resultList.size(); UpdateAccountLog
		 * updateAccountLog=(UpdateAccountLog)resultList.get(0); return
		 * updateAccountLog.getSeqNo()+1; }
		 */

	}

	public UpdateAccountLog getUpdateAccountLogByAccountNo(int accountNo) {
		return getUpdateAccountLogDao().getUpdateAccountLogByAccountNoOrder(accountNo);
	}

	public List<UpdateAccountLog> findAllItemByHql(Pager pager, Integer accountNo, String cardNo, String userName,
			Integer credentialsType, String credentialsNo, String vehPlate, Integer status) {

		return getUpdateAccountLogDao().findAllItemByHql(pager, accountNo, cardNo, userName, credentialsType,
				credentialsNo, vehPlate, status);
	}

	public List<UpdateAccountLog> findAllItemByHqlAndTime(Pager pager, Integer accountNo, String cardNo,
			String userName, Integer credentialsType, String credentialsNo, String vehPlate, Integer status,
			Date startTime1, Date endTime1) {
		return getUpdateAccountLogDao().findAllItemByHqlAndTime(pager, accountNo, cardNo, userName, credentialsType,
				credentialsNo, vehPlate, status, startTime1, endTime1);
	}

	public UpdateAccountLog getUpdateAccountLogByAccountNoAndSeqNo(int accountNo, int seqNo) {
		return getUpdateAccountLogDao().getUpdateAccountLogByAccountNoAndSeqNo(accountNo, seqNo);
	}
}
