package com.hgsoft.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hgsoft.dao.SecurityVehPassDao;
import com.hgsoft.util.Pager;

@Service
public class SecurityVehPassService {

	@Resource
	private SecurityVehPassDao securityVehPassDao;

	/**
	 * 查询车道过车记录
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List query(Pager pager, String startTime, String endTime, String cardNo, String onwer, String parkNo,
			String gateNo, String laneNo, String vehPass) {
		return securityVehPassDao.query(pager, startTime, endTime, cardNo, onwer, parkNo, gateNo, laneNo, vehPass);
	}

	/**
	 * 查询历史记录
	 */
	@SuppressWarnings("unchecked")
	public List queryHistory(Pager pager, String startTime, String endTime, String parkNo, String gateNo, String laneNo,
			String numberType, String number, String operatorType) {
		return securityVehPassDao.queryHistory(pager, startTime, endTime, parkNo, gateNo, laneNo, numberType, number,
				operatorType);
	}

	/**
	 * 查询过车依据
	 */
	@SuppressWarnings("unchecked")
	public List query(Pager pager, String vehPassId) {
		return securityVehPassDao.query(pager, vehPassId);
	}

	/**
	 * 获取所有小区信息
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List queryParkList() {
		return securityVehPassDao.queryParkList();
	}

	/**
	 * 根据小区号来获得该小区的所有大门
	 */
	@SuppressWarnings("unchecked")
	public List queryGateList(String parkNo) {
		return securityVehPassDao.queryGateList(parkNo);
	}

	/**
	 * 根据小区号和大门号来获得所有的车道信息
	 * 
	 * @param parkNo
	 * @param gateNo
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List queryLaneList(String parkNo, String gateNo) {
		return securityVehPassDao.queryLaneList(parkNo, gateNo);
	}
}
