/**
 * 
 */
package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.SendParaDao;
import com.hgsoft.entity.SendPara;
import com.hgsoft.entity.SystemPara;
import com.hgsoft.util.Pager;

/**
 * @author qinzuohai
 *
 */
@Service
public class SendParaService extends BaseService<SendPara> {

	@Autowired
	public void setDao(@Qualifier("sendParaDao") SendParaDao dao) {
		super.setDao(dao);
	}

	private SendParaDao getSendParaDao() {
		return (SendParaDao) this.getDao();
	}

	public List<SystemPara> findSystemPara() {
		return getSendParaDao().findSystemPara();
	}

	public List<SendPara> findTypeOnePara() {
		return getSendParaDao().findTypeOnePara();
	}

	public List<SendPara> findTypeTwoPara() {
		return getSendParaDao().findTypeTwoPara();
	}

	public String findItemByItemValue(String itemValue) {
		return getSendParaDao().findItemByItemValue(itemValue);
	}

	public List<SendPara> ishasSendMission(Short laneNo, String laneComputerIp, String tableName) {
		return getSendParaDao().ishasSendMission(laneNo, laneComputerIp, tableName);
	}

	public boolean deletehasSendMission(Short laneNo, String laneComputerIp, String tableName) {
		return getSendParaDao().deletehasSendMission(laneNo, laneComputerIp, tableName);
	}

	public String findTXTdata(String tableName) {
		return getSendParaDao().findTXTdata(tableName);
	}

	public String findTXTdataToLane(String tableName) {
		return getSendParaDao().findTXTdataToLane(tableName);
	}

	public List<SendPara> findFailSendParaByCondition(Pager pager, String fieldName, Short sendType, String fieldValue,
			Short laneNo, String laneComputerIp, String tableName) {
		return getSendParaDao().findFailSendParaByCondition(pager, fieldName, sendType, fieldValue, laneNo,
				laneComputerIp, tableName);
	}

	public boolean deleteFailSendParaByCondition(String fieldName, Short sendType, String fieldValue, Short laneNo,
			String laneComputerIp, String tableName) {
		return getSendParaDao().deleteFailSendParaByCondition(fieldName, sendType, fieldValue, laneNo, laneComputerIp,
				tableName);
	}

	public List<SendPara> findFailSendParaByTypeTwo(Pager pager) {
		return getSendParaDao().findFailSendParaByTypeTwo(pager);
	}

	public boolean delete(Object fieldValue, Object laneNo, Object laneComputerIp, Object tableName) {
		return getSendParaDao().delete(fieldValue, laneNo, laneComputerIp, tableName);
	}

	public List<SendPara> findFailSendParaByTypeOne(Pager pager) {
		return getSendParaDao().findFailSendParaByTypeOne(pager);
	}

	public void sendParaToLane(String tablename) {
		getSendParaDao().sendParaToLane(tablename);
	}
}
