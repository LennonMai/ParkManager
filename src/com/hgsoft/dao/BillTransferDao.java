package com.hgsoft.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.hgsoft.entity.BillTransfer;

@Repository
public class BillTransferDao extends BaseDao<BillTransfer> {
	@SuppressWarnings("unchecked")
	public Integer getMaxRecNO() {
		String hql = "from BillTransfer billTransfer order by billTransfer.recNo desc";
		List resultList = executeQuery(hql);
		if (resultList.isEmpty())
			return 1;
		else {
			return ((BillTransfer) resultList.get(0)).getRecNo() + 1;
		}

	}

}
