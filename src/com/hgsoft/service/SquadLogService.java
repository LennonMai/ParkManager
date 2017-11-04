package com.hgsoft.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.SquadLogDao;
import com.hgsoft.entity.SquadLog;
import com.hgsoft.util.Pager;

/**
 * 合计数修改Service
 * 
 * @author caijunhua
 *
 */

@Service
public class SquadLogService extends BaseService<SquadLog> {

	@Autowired
	public void setDao(@Qualifier("squadLogDao") SquadLogDao dao) {
		super.setDao(dao);
	}

	private SquadLogDao getSquadLogDao() {
		return (SquadLogDao) this.getDao();
	}

	public List<SquadLog> fillAllSquadLog(Pager pager) {
		return getSquadLogDao().fillAllSquadLog(pager);
	}

	/**
	 * 根据查询条件查询合计数
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
	 * @param operatorNo
	 *            收费员工号
	 * @return
	 */
	public List<SquadLog> fillAllSquadLogByHql(Pager pager, Short gateNo, Short laneNo, Date squadDate, Short squadNo,
			Integer operatorNo) {
		return getSquadLogDao().fillAllSquadLogByHql(pager, gateNo, laneNo, squadDate, squadNo, operatorNo);
	}

	// 通过区域、小区、大门、车道编码，工班日期和工班号 查询交接班信息
	public List<SquadLog> loadSquadLog(Short areaNo, Short parkNo, Short gateNo, Short laneNo, Integer operatorNo,
			Date squadDate, Short squadNo, Date loginTime) {
		return getSquadLogDao().loadSquadLog(areaNo, parkNo, gateNo, laneNo, operatorNo, squadDate, squadNo, loginTime);
	}

	// 统计中心流水数和通行费
	@SuppressWarnings("unchecked")
	public List loadCenterData(String month, Short areaNO, Short parkNo, Short gateNo, Short laneNo, Date squadDate,
			Short squadNo, Short listName) {
		return getSquadLogDao().loadCenterData(month, areaNO, parkNo, gateNo, laneNo, squadDate, squadNo, listName);
	}

}
