package com.hgsoft.unit.testDao;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.hgsoft.dao.SquadLogDao;
import com.hgsoft.util.Pager;

public class TestSquadLogDao extends AbstractDaoTransactionalTests{

	@Autowired
	private SquadLogDao squadLogDao;
	
	/**
	 * 根据查询条件查询合计数
	 * @param pager
	 * @param gateNo 大门编码
	 * @param laneNo 车道编码
	 * @param squadDate 工班日期
	 * @param squadNo 工班号
	 * @param operatorNo 收费员工号
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@Test
	public void testFillAllSquadLogByHql() {
		List list = squadLogDao.fillAllSquadLogByHql(new Pager(), null, null, null, null, null);
		assertNotNull("list数组为空", list);
	}
	
	//通过区域、小区、大门、车道编码，操作员号，工班日期，工班号，登录时间 查询合计数信息
	@SuppressWarnings("unchecked")
	@Test
	public void testLoadSquadLog() {
		List list = squadLogDao.loadSquadLog(null, null, null, null, null, null, null, null);
		assertNull("list数组不为空", list);
	}
	
	//统计中心流水数和通行费
	@SuppressWarnings("unchecked")
	@Test
	public void testLoadCenterData() {
		//List list = squadLogDao.loadCenterData(null, null, null, null, null);
		//assertNull("list数组不为空", list);
	}
	
	@Override
	String[] getOtherConfigs() {
		return new String[] {applicationContextFile};
	}

}
