package com.hgsoft.service;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hgsoft.dao.CardDynamicDao;
import com.hgsoft.entity.AllInList;
import com.hgsoft.entity.CardDynamic;
import com.hgsoft.entity.WaterQuery;
import com.hgsoft.util.Pager;

@Service
public class CardDynamicService {

	@Resource
	private CardDynamicDao cardDynamicDao;

	/**
	 * 查询卡分布情况
	 */
	@SuppressWarnings("unchecked")
	public List queryCardScatter() {
		return cardDynamicDao.queryCardScatter();
	}

	/**
	 * 查询用户卡类型分布情况
	 */
	@SuppressWarnings("unchecked")
	public List queryUserCardTypeScatter() {
		return cardDynamicDao.queryUserCardTypeScatter();
	}

	/**
	 * 查询通行劵类型分布情况
	 */
	@SuppressWarnings("unchecked")
	public List queryTicketTypeScatter() {
		return cardDynamicDao.queryTicketTypeScatter();
	}

	/**
	 * 查询未回收零时卡
	 */
	@SuppressWarnings("unchecked")
	public List queryCardDynamic(Pager pager, String startTime, String endTime, String cardNo, String status,
			String vehPlate) {
		return cardDynamicDao.queryCardDynamic(pager, startTime, endTime, cardNo, status, vehPlate);

	}

	/**
	 * 根据流水号来获得入口流水视图信息
	 */
	@SuppressWarnings("unchecked")
	public List getInListByListNo(String squadTime, String listNo) {
		return cardDynamicDao.getInListByListNo(squadTime, listNo);
	}

	@SuppressWarnings("unchecked")
	public List getInListByInOpTimeAndListNo(String inOpTime, String inlistNo) {
		return cardDynamicDao.getInListByInOpTimeAndListNo(inOpTime, inlistNo);
	}

	/**
	 * 根据流水号来获得出口流水视图信息
	 */
	@SuppressWarnings("unchecked")
	public List getOutListByListNo(String squadTime, String listNo) {
		return cardDynamicDao.getOutListByListNo(squadTime, listNo);
	}

	/**
	 * 根据流水号来获得入口流水视图信息
	 */

	public AllInList getByListNo(String listNo) {
		return cardDynamicDao.getByListNo(listNo);
	}

	/**
	 * 根据卡表面号来获得未回收临时卡信息
	 */
	public CardDynamic getByCardNo(String cardNo) {
		return cardDynamicDao.getByCardNo(cardNo);
	}

	/**
	 * 更新（用对象）
	 */
	public void update(CardDynamic cardDynamic) {
		cardDynamicDao.update(cardDynamic);
	}

	/**
	 * 获得出口数据
	 */
	@SuppressWarnings("unchecked")
	public List queryByOpTimeAndVehPlate(Date opTime, String days, String backNums, String vehPlate) {
		return cardDynamicDao.queryByOpTimeAndVehPlate(opTime, days, backNums, vehPlate);
	}

	/**
	 * 查询流水信息
	 */
	@SuppressWarnings("unchecked")
	public List waterQuery(Pager pager, String cardNo, String vehPlate, String listNo, String statusOutIn,
			String squadDate, String spEvent, String ticketType, String operatorNo, String operatorName, String vehType,
			String vehClass, String parkNo, String gateNo, String laneNo, String squadNo, String opTime,
			String queryStatus, String timeStatus, String squadTime_start, String squadTime_end, String startTime,
			String endTime, String cashMoneyMin, String cashMoneyMax, String etcMoneyMin, String etcMoneyMax,
			String fuzzySearch, String userCardType, String cardType, String queryType) {
		return cardDynamicDao.waterQuery(pager, cardNo, vehPlate, listNo, statusOutIn, squadDate, spEvent, ticketType,
				operatorNo, operatorName, vehType, vehClass, parkNo, gateNo, laneNo, squadNo, opTime, queryStatus,
				timeStatus, squadTime_start, squadTime_end, startTime, endTime, cashMoneyMin, cashMoneyMax, etcMoneyMin,
				etcMoneyMax, fuzzySearch, userCardType, cardType, queryType);
	}

	@SuppressWarnings("unchecked")
	public List getAllTicketType() {
		return cardDynamicDao.getAllTicketType();
	}

	@SuppressWarnings("unchecked")
	public List getAllVehType() {
		return cardDynamicDao.getAllVehType();
	}

	@SuppressWarnings("unchecked")
	public List getAllVehClass() {
		return cardDynamicDao.getAllVehClass();
	}

	@SuppressWarnings("unchecked")
	public List getAllSpEvent() {
		return cardDynamicDao.getAllSpEvent();
	}

	public List printQuery(Pager pager, WaterQuery waterQuery) {
		// TODO Auto-generated method stub
		return cardDynamicDao.printQuery(pager, waterQuery);

	}

	public List<CardDynamic> queryAllNoRecycle() {
		return cardDynamicDao.queryAllNoRecycle();
	}
}
