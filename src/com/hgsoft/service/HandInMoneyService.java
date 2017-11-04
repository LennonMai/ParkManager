package com.hgsoft.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.HandInMoneyDao;
import com.hgsoft.entity.HandInMoney;
import com.hgsoft.util.Pager;

/**
 * 交接班管理Service
 * 
 * @author caijunhua
 *
 */

@Service
public class HandInMoneyService extends BaseService<HandInMoney> {

	@Autowired
	public void setDao(@Qualifier("handInMoneyDao") HandInMoneyDao dao) {
		super.setDao(dao);
	}

	private HandInMoneyDao getHandInMoneyDao() {
		return (HandInMoneyDao) this.getDao();
	}

	/**
	 * 根据查询条件查询交接班
	 * 
	 * @param pager
	 * @param gateNo
	 *            大门编码
	 * @param laneNo
	 *            车道编码
	 * @param squadDate
	 *            工班日期
	 * @param squadNo
	 *            工班号
	 * @return
	 */
	public List<HandInMoney> findAllHandInMoneyByHql(Pager pager, Short gateNo, Short laneNo, Date squadDate,
			Short squadNo) {
		return getHandInMoneyDao().findAllHandInMoneyByHql(pager, gateNo, laneNo, squadDate, squadNo);
	}

	// 通过区域、小区、大门、车道编码，工班日期和工班号查询交接班信息
	public List<HandInMoney> loadHandInMoney(Short areaNo, Short parkNo, Short gateNo, Short laneNo, Date squadDate,
			Short squadNo) {
		return getHandInMoneyDao().loadHandInMoney(areaNo, parkNo, gateNo, laneNo, squadDate, squadNo);
	}

	// 通过区域、小区、大门、车道编码，工班日期和工班号删除交接班信息
	public boolean deleteHandInMoney(Short areaNo, Short parkNo, Short gateNo, Short laneNo, Date squadDate,
			Short squadNo) {
		return getHandInMoneyDao().deleteHandInMoney(areaNo, parkNo, gateNo, laneNo, squadDate, squadNo);
	}

}
