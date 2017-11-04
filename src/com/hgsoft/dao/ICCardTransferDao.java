package com.hgsoft.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.hgsoft.entity.ICCardTransfer;



@Repository
public class ICCardTransferDao extends BaseDao<ICCardTransfer>{
	@SuppressWarnings("unchecked")
	public Integer getICCardTransferRecNo() {
		String hql = "from ICCardTransfer iCCardTransfer order by iCCardTransfer.recNO desc";
		List resultList = executeQuery(hql);
		if (resultList.isEmpty()) {
			return 1;
		} else {
			
			return ((ICCardTransfer) resultList.get(0)).getRecNO() + 1;
		}

	}

}
