package com.hgsoft.service;

import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.VAccountTradeDao;
import com.hgsoft.entity.VAccountTrade;
import com.hgsoft.util.Pager;

@Service
public class VAccountTradeService extends BaseService<VAccountTrade> {

	@Autowired
	public void setDao(VAccountTradeDao dao) {
		super.setDao(dao);
	}

	private VAccountTradeDao getVAccountTradeDao() {
		return (VAccountTradeDao) this.getDao();
	}

	public List<VAccountTrade> findAllItem(Pager pager) {
		return getVAccountTradeDao().findAllItem(pager);
	}

	public List<VAccountTrade> findAllItemByHql(Pager pager, Integer sys_id, String cardNo, String userName,
			Integer tradeType, String credentialsNo, String vehPlate, Integer status, String startTime,
			String endTime) {
		return getVAccountTradeDao().findAllItemByHql(pager, sys_id, cardNo, userName, tradeType, credentialsNo,
				vehPlate, status, startTime, endTime);
	}

	public VAccountTrade getVAccountTradeByAccountNoAndlistNo(int accountNo, String listNo) {
		return getVAccountTradeDao().getVAccountTradeByAccountNoAndlistNo(accountNo, listNo);
	}

	public List<VAccountTrade> findAllItemToQueryByHql(Pager pager, Integer sys_id, String cardNo, String userName,
			Integer tradeType, String credentialsNo, String vehPlate, Integer status, String startTime,
			String endTime) {
		return getVAccountTradeDao().findAllItemToQueryByHql(pager, sys_id, cardNo, userName, tradeType, credentialsNo,
				vehPlate, status, startTime, endTime);
	}

	// 根据用户输入条件查询账户最新余额
	public List<VAccountTrade> findLatestAccountBalanceForSingle(Pager pager, String userName, String vehPlate,
			Integer sys_id, String cardNo) {
		return getVAccountTradeDao().findLatestAccountBalanceForSingle(pager, userName, vehPlate, sys_id, cardNo);
	}

	// 根据账户查询流水中对应的最新余额
	public List<VAccountTrade> findAllLatestBalance(Pager pager) {
		return getVAccountTradeDao().findAllLatestBalance(pager);
	}

	// 查询某时间段的流水
	public List<VAccountTrade> findAccountTradeStartTimeToEndTime(Pager pager, Date verify_startTime,
			Date verify_endTime) {
		return getVAccountTradeDao().findAccountTradeStartTimeToEndTime(pager, verify_startTime, verify_endTime);
	}

	// 输出效验全部的流水记录
	public LinkedHashMap<String, VAccountTrade> findAllValidateAccountTrade(Pager pager, String keyMD5,
			Date verify_startTime, Date verify_endTime, String userName, String cardNo, String vehPlate,
			Integer tradeType) {
		return getVAccountTradeDao().findAllValidateAccountTrade(pager, keyMD5, verify_startTime, verify_endTime,
				userName, cardNo, vehPlate, tradeType);
	}

	// 输出不通过效验的流水记录
	public List<VAccountTrade> findFailValidateAccountTrade(Pager pager, String keyMD5, Date verify_startTime,
			Date verify_endTime, String userName, String cardNo, String vehPlate, Integer tradeType) {
		return getVAccountTradeDao().findFailValidateAccountTrade(pager, keyMD5, verify_startTime, verify_endTime,
				userName, cardNo, vehPlate, tradeType);
	}

	// 输出通过效验的流水记录
	public List<VAccountTrade> findPassValidateAccountTrade(Pager pager, String keyMD5, Date verify_startTime,
			Date verify_endTime, String userName, String cardNo, String vehPlate, Integer tradeType) {
		return getVAccountTradeDao().findPassValidateAccountTrade(pager, keyMD5, verify_startTime, verify_endTime,
				userName, cardNo, vehPlate, tradeType);
	}

	// 根据输入信息查询流水信息总条数
	public Long findAccountTradeStartTimeToEndTime(String keyMD5, Date verify_startTime, Date verify_endTime,
			String userName, String cardNo, String vehPlate, Integer tradeType) {
		return getVAccountTradeDao().findAccountTradeStartTimeToEndTime(keyMD5, verify_startTime, verify_endTime,
				userName, cardNo, vehPlate, tradeType);
	}
}
