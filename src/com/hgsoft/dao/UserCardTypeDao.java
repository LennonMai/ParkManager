package com.hgsoft.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.hgsoft.entity.AreaInformation;
import com.hgsoft.entity.CardGroup;
import com.hgsoft.entity.UserCardFeeRuleType;
import com.hgsoft.entity.UserCardType;
import com.hgsoft.util.Pager;

@SuppressWarnings("unused")
@Repository 
public class UserCardTypeDao extends BaseDao<UserCardType> {
	@SuppressWarnings("unchecked")
	public List<UserCardType> getAllUserCardType() {
		String hql = "from UserCardType userCardType";
		List resultList = executeQuery(hql);
		if(resultList.isEmpty()) {
			return null;
		} else {
			return resultList;
		}
	}
	@SuppressWarnings("unchecked")
	public List<UserCardType> getUserCardTypeByUserCardType(Short userCardType1,Short userCardType2){
		String hql = "from UserCardType userCardType where userCardType.userCardType=? or userCardType.userCardType=?";
		List list = executeQuery(hql,userCardType1,userCardType2);
		if (list.isEmpty()) {
			return null;
		} else {
			return list;
		}
	}
	@SuppressWarnings("unchecked")
	public List<UserCardType> getUserCardTypeByNotEqualUserCardType(Short userCardType1,Short userCardType2,Short userCardType3){
		String hql = "from UserCardType userCardType where userCardType.userCardType!=? and userCardType.userCardType!=? and userCardType.userCardType!=?";
		List list = executeQuery(hql,userCardType1,userCardType2,userCardType3);
		if (list.isEmpty()) {
			return null;
		} else {
			return list;
		}
	}

}
