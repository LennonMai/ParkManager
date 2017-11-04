package com.hgsoft.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.hgsoft.entity.Operator;

/**
 * ²Ù×÷Ô±DAO
 *
 */

@Repository
public class OperatorDao extends BaseDao<Operator> {
	@SuppressWarnings("unchecked")
	public List<Operator> getAllOperator() {
		String hql = "from Operator operator";
		List resultList = executeQuery(hql);
		if (resultList.isEmpty()) {
			return null;
		} else {
			return resultList;
		}
	}

}
