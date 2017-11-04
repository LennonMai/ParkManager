package com.hgsoft.service;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.UserCardBillDao;
import com.hgsoft.entity.Admin;
import com.hgsoft.entity.UserCardBill;
import com.hgsoft.util.Pager;

@Service
public class UserCardBillService extends BaseService<UserCardBill> {

	@Autowired
	public void setDao(@Qualifier("userCardBillDao") UserCardBillDao dao) {
		super.setDao(dao);
	}

	private UserCardBillDao getUserCardBillDao() {
		return (UserCardBillDao) this.getDao();
	}

	public List<UserCardBill> getUserCardBillByRecNO(Pager pager, int recNo) {
		return getUserCardBillDao().getUserCardBillByRecNO(pager, recNo);
	}

	public UserCardBill getUserCardBillMaxEndTimeByRecNO(int recNo) {
		return getUserCardBillDao().getUserCardBillMaxEndTimeByRecNO(recNo);
	}

	public List<Admin> getAllAdmin() {
		return getUserCardBillDao().getAllAdmin();
	}

	public UserCardBill getUserCardBillByRecNOAndOptime(int recNo, Timestamp opTime) {
		return getUserCardBillDao().getUserCardBillByRecNOAndOptime(recNo, opTime);
	}

	public void deleteByUserRecNo(int userRecNo) {
		getUserCardBillDao().deleteByUserRecNo(userRecNo);
	}

	public List<Object[]> getAllUserCardBill(Pager pager) {
		return getUserCardBillDao().getAllUserCardBill(pager);
	}

	public List<Object[]> getAllUserCardBillByHql(Pager pager, String cardNo, String vehPlate, String owner) {
		return getUserCardBillDao().getAllUserCardBillByHql(pager, cardNo, vehPlate, owner);
	}

	public long getSumMoney() {
		return getUserCardBillDao().getSumMoney();
	}

	public long getSumMoneyByHql(String cardNo, String vehPlate, String owner) {
		return getUserCardBillDao().getSumMoneyByHql(cardNo, vehPlate, owner);
	}

	public Timestamp getMaxPayEndTimeByRecNO(int recNo) {
		return getUserCardBillDao().getMaxPayEndTimeByRecNO(recNo);
	}

}
