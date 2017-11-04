package com.hgsoft.dao;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.hgsoft.entity.UserCardFeeRuleType;
import com.hgsoft.entity.UserCardType;

@SuppressWarnings("unchecked")
@Repository
public class UserCardFeeRuleTypeDao extends BaseDao<UserCardFeeRuleType> {

	private UserCardFeeRuleType userCardFeeRuleTypeTemp;
	private UserCardType userCardType;
	private List<UserCardFeeRuleType> resultList = new ArrayList();
	@Resource
	private UserCardTypeDao userCardTypeDao;

	public List<UserCardFeeRuleType> getUserCardFeeRuleTypeAndTypeName() {
		resultList.clear();
		String hql = "from UserCardFeeRuleType userCardFeeRuleType ";
		List list = executeQuery(hql);
		if (list.isEmpty()) {
			return null;
		} else {
			for (int i = 0; i < list.size(); i++) {
				userCardFeeRuleTypeTemp = (UserCardFeeRuleType) list.get(i);
				userCardType = userCardTypeDao.get(userCardFeeRuleTypeTemp.getUserCardType());
				if (userCardType != null) {
					userCardFeeRuleTypeTemp.setTypeName(userCardType.getTypeName());
					resultList.add(userCardFeeRuleTypeTemp);
				}
			}
			return resultList;

		}
	}

}
