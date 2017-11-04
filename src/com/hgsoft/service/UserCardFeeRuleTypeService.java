package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.UserCardFeeRuleTypeDao;
import com.hgsoft.entity.UserCardFeeRuleType;
import com.hgsoft.util.Order;

@Service
public class UserCardFeeRuleTypeService extends BaseService<UserCardFeeRuleType> {

	@Autowired
	public void setDao(@Qualifier("userCardFeeRuleTypeDao") UserCardFeeRuleTypeDao dao) {
		super.setDao(dao);
	}

	private UserCardFeeRuleTypeDao getUserCardFeeRuleTypeDao() {
		return (UserCardFeeRuleTypeDao) this.getDao();
	}

	public List<UserCardFeeRuleType> getUserCardFeeRuleTypeAndTypeName() {
		return getUserCardFeeRuleTypeDao().getUserCardFeeRuleTypeAndTypeName();

	}

	public List<UserCardFeeRuleType> findAll() {
		return getUserCardFeeRuleTypeDao().findAll(Order.asc("userCardType"));
	}
}
