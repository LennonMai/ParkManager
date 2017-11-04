package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.UserCardTypeDao;
import com.hgsoft.entity.UserCardType;
import com.hgsoft.util.Order;

@Service
public class UserCardTypeService extends BaseService<UserCardType> {

	@Autowired
	public void setDao(@Qualifier("userCardTypeDao") UserCardTypeDao dao) {
		super.setDao(dao);
	}

	private UserCardTypeDao getUserCardTypeDao() {
		return (UserCardTypeDao) this.getDao();
	}

	public List<UserCardType> getAllUserCardType() {
		return getUserCardTypeDao().getAllUserCardType();
	}

	public List<UserCardType> findAll() {
		return getUserCardTypeDao().findAll(Order.asc("userCardType"));
	}

	public List<UserCardType> getUserCardTypeByUserCardType(Short userCardType1, Short userCardType2) {
		return getUserCardTypeDao().getUserCardTypeByUserCardType(userCardType1, userCardType2);
	}

	public List<UserCardType> getUserCardTypeByNotEqualUserCardType(Short userCardType1, Short userCardType2,
			Short userCardType3) {
		return getUserCardTypeDao().getUserCardTypeByNotEqualUserCardType(userCardType1, userCardType2, userCardType3);
	}

}
