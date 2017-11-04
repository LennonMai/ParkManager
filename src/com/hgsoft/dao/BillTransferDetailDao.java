package com.hgsoft.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.hgsoft.entity.BillTransferDetail;

@Repository
public class BillTransferDetailDao extends BaseDao<BillTransferDetail> {
	@SuppressWarnings("unchecked")
	public Integer getMaxRecNO() {
		String hql = "from BillTransferDetail billTransferDetail order by billTransferDetail.recNo desc";
		List resultList = executeQuery(hql);
		if (resultList.isEmpty())
			return 1;
		else {
			return ((BillTransferDetail) resultList.get(0)).getRecNo() + 1;
		}

	}

}
