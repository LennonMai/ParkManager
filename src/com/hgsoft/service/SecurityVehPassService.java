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
	 * ��ѯ����������¼
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List query(Pager pager, String startTime, String endTime, String cardNo, String onwer, String parkNo,
			String gateNo, String laneNo, String vehPass) {
		return securityVehPassDao.query(pager, startTime, endTime, cardNo, onwer, parkNo, gateNo, laneNo, vehPass);
	}

	/**
	 * ��ѯ��ʷ��¼
	 */
	@SuppressWarnings("unchecked")
	public List queryHistory(Pager pager, String startTime, String endTime, String parkNo, String gateNo, String laneNo,
			String numberType, String number, String operatorType) {
		return securityVehPassDao.queryHistory(pager, startTime, endTime, parkNo, gateNo, laneNo, numberType, number,
				operatorType);
	}

	/**
	 * ��ѯ��������
	 */
	@SuppressWarnings("unchecked")
	public List query(Pager pager, String vehPassId) {
		return securityVehPassDao.query(pager, vehPassId);
	}

	/**
	 * ��ȡ����С����Ϣ
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List queryParkList() {
		return securityVehPassDao.queryParkList();
	}

	/**
	 * ����С��������ø�С�������д���
	 */
	@SuppressWarnings("unchecked")
	public List queryGateList(String parkNo) {
		return securityVehPassDao.queryGateList(parkNo);
	}

	/**
	 * ����С���źʹ��ź���������еĳ�����Ϣ
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
