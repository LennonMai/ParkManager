package com.hgsoft.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.OutListDao;
import com.hgsoft.entity.OutList;
import com.hgsoft.util.Pager;

/**
 * 入口流水Service
 * 
 * @author caijunhua
 *
 */

@Service
public class OutListService extends BaseService<OutList> {

	@Autowired
	public void setDao(@Qualifier("outListDao") OutListDao dao) {
		super.setDao(dao);
	}

	private OutListDao getOutListDao() {
		return (OutListDao) this.getDao();
	}

	/**
	 * 根据查询条件查询出口流水
	 * 
	 * @param pager
	 * @param cardNo
	 *            卡号
	 * @param vehPlate
	 *            车牌号
	 * @param listNo
	 *            流水号
	 * @param vehClass
	 *            车种
	 * @param startTime1
	 *            开始时间
	 * @param endTime1
	 *            结束时间
	 * @return
	 */
	public List<OutList> findAllOutListByHql(Pager pager, String cardNo, String vehPlate, String listNo, Short vehClass,
			Date startTime1, Date endTime1) {
		return getOutListDao().findAllOutListByHql(pager, cardNo, vehPlate, listNo, vehClass, startTime1, endTime1);
	}

}
