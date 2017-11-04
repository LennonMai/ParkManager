package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.OwnerIncomeSumDao;
import com.hgsoft.entity.OwnerIncomeSum;
import com.hgsoft.util.Pager;

/**
 * 业主收支金额汇总Service
 * 
 * @author caijunhua
 *
 */

@Service
public class OwnerIncomeSumService extends BaseService<OwnerIncomeSum> {

	@Autowired
	public void setDao(@Qualifier("ownerIncomeSumDao") OwnerIncomeSumDao dao) {
		super.setDao(dao);
	}

	private OwnerIncomeSumDao getOwnerIncomeSumDao() {
		return (OwnerIncomeSumDao) this.getDao();
	}

	/**
	 * 根据查询条件查询业主收支金额汇总
	 * 
	 * @param pager
	 * @param startTime
	 *            开始时间
	 * @param endTime
	 *            结束时间
	 * @return
	 */
	public List<OwnerIncomeSum> findOwnerIncomeSumByHql(Pager pager, String startTime, String endTime) {
		return getOwnerIncomeSumDao().findOwnerIncomeSumByHql(pager, startTime, endTime);
	}

}
