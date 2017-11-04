package com.hgsoft.service;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.UserCardInfoDao;
import com.hgsoft.entity.UserCardInfo;
import com.hgsoft.util.Pager;

@Service
public class UserCardInfoService extends BaseService<UserCardInfo> {

	@Autowired
	public void setDao(@Qualifier("userCardInfoDao") UserCardInfoDao dao) {
		super.setDao(dao);
	}

	private UserCardInfoDao getUserCardInfoDao() {
		return (UserCardInfoDao) this.getDao();
	}

	public UserCardInfo getUserCardInfoByCardNo(String cardNo) {
		return getUserCardInfoDao().getUserCardInfoByCardNo(cardNo);
	}

	public UserCardInfo getUserCardInfoByVehPlate(String vehPlate) {
		return getUserCardInfoDao().getUserCardInfoByVehPlate(vehPlate);
	}

	public List<UserCardInfo> findAllItemByHql(Pager pager, String cardNo, Short status, Short userCardType,
			String vehPlate, String owner, String idcard, Short feeRuleType, String whtherPayType,
			Timestamp payEndTimestamp, String mobileNumber, Integer carType, String parkingSpace,
			Integer ownerIdentity) {
		return getUserCardInfoDao().findAllItemByHql(pager, cardNo, status, userCardType, vehPlate, owner, idcard,
				feeRuleType, whtherPayType, payEndTimestamp, mobileNumber, carType, parkingSpace, ownerIdentity);
	}

	public List<UserCardInfo> findAllItemByHqlToPayment(Pager pager, String cardNo, Short status, Short userCardType,
			String vehPlate, String owner, String idcard, Short feeRuleType, String whtherPayType,
			Timestamp payEndTimesStarttamp, Timestamp payEndTimestamp, String mobileNumber, Integer carType,
			String parkingSpace, Integer ownerIdentity) {
		return getUserCardInfoDao().findAllItemByHqlToPayment(pager, cardNo, status, userCardType, vehPlate, owner,
				idcard, feeRuleType, whtherPayType, payEndTimesStarttamp, payEndTimestamp, mobileNumber, carType,
				parkingSpace, ownerIdentity);
	}

	public Long countFindAllItemByHqlToPayment(String cardNo, Short status, Short userCardType, String vehPlate,
			String owner, String idcard, Short feeRuleType, String whtherPayType, Timestamp payEndTimesStarttamp,
			Timestamp payEndTimestamp, String mobileNumber, Integer carType, String parkingSpace,
			Integer ownerIdentity) {
		return getUserCardInfoDao().countFindAllItemByHqlToPayment(cardNo, status, userCardType, vehPlate, owner,
				idcard, feeRuleType, whtherPayType, payEndTimesStarttamp, payEndTimestamp, mobileNumber, carType,
				parkingSpace, ownerIdentity);
	}

	public Integer getMaxRecNO() {
		return getUserCardInfoDao().getMaxRecNO();
	}

	public UserCardInfo getUserCardInfoByRecNO(Integer recNO) {
		return getUserCardInfoDao().getUserCardInfoByRecNO(recNO);
	}

	public List<UserCardInfo> findItemByHql(Pager pager, String cardNo, String vehPlate, String groupName,
			String isGroup, Short userCardType, String whtherPayType) {
		return getUserCardInfoDao().findItemByHql(pager, cardNo, vehPlate, groupName, isGroup, userCardType,
				whtherPayType);
	}

	@SuppressWarnings("unchecked")
	public List findAllUserCardInfoHistoryBySql(Pager pager, Integer recNo, String cardNo, Short status,
			Short userCardType, String vehPlate, String owner, String idcard, Short feeRuleType, Timestamp modifyTime,
			Timestamp exactModifyTime, Integer carType, String parkingSpace, Integer ownerIdentity) {
		return getUserCardInfoDao().findAllUserCardInfoHistoryBySql(pager, recNo, cardNo, status, userCardType,
				vehPlate, owner, idcard, feeRuleType, modifyTime, exactModifyTime, carType, parkingSpace,
				ownerIdentity);
	}

	public void updateExtendPayEndTimeAffirm(int recNo, int extendPayEndTime) {// 延长缴费期限需要update的函数
		getUserCardInfoDao().updateExtendPayEndTimeAffirm(recNo, extendPayEndTime);
	}

	public List findUserCarInfoByCarType(Integer carType, Integer carSmallType) {
		return getUserCardInfoDao().findUserCarInfoByCarType(carType, carSmallType);
	}
}
