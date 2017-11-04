package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.SendParaResultDao;
import com.hgsoft.entity.SendParaResult;
import com.hgsoft.util.Pager;

@Service
public class SendParaResultService extends BaseService<SendParaResult> {

	@Autowired
	public void setDao(@Qualifier("sendParaResultDao") SendParaResultDao dao) {
		super.setDao(dao);
	}

	private SendParaResultDao getSendParaResultDao() {
		return (SendParaResultDao) this.getDao();
	}

	public List<SendParaResult> findByCondition(Pager pager, String fieldName, Short sendType, String fieldValue,
			Short laneNo, String laneComputerIp, String tableName, String fileName, Short sendResult, String startTime,
			String endTime) {
		return getSendParaResultDao().findByCondition(pager, fieldName, sendType, fieldValue, laneNo, laneComputerIp,
				tableName, fileName, sendResult, startTime, endTime);
	}

	public boolean delete(Object fieldValue, Object laneNo, Object laneComputerIp, Object tableName) {
		return getSendParaResultDao().delete(fieldValue, laneNo, laneComputerIp, tableName);
	}

	public boolean deleteByCondition(String fieldName, Short sendType, String fieldValue, Short laneNo,
			String laneComputerIp, String tableName, String fileName, Short sendResult, String startTime,
			String endTime) {
		return getSendParaResultDao().deleteByCondition(fieldName, sendType, fieldValue, laneNo, laneComputerIp,
				tableName, fileName, sendResult, startTime, endTime);
	}
}
