package com.hgsoft.integration.testService;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;

import com.hgsoft.service.SquadLogService;
import com.hgsoft.util.Pager;

public class TestSquadLogService extends AbstractServiceTransactionalTests {
	
	@Autowired
	private SquadLogService squadLogService;

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
	@Rollback(true)
	public void testFillAllSquadLogByHql() {
		List list = squadLogService.fillAllSquadLogByHql(new Pager(), null, null, null, null, null);
		assertNotNull("list对象为空！",list);
	}

	//通过区域、小区、大门、车道编码，工班日期和工班号 查询交接班信息
	@SuppressWarnings("unchecked")
	@Test
	@Rollback(true)
	public void testLoadSquadLog() {
		List list = squadLogService.loadSquadLog(null, null, null, null, null, null, null, null);
		assertNotNull("list对象为空！",list);
	}

	//统计中心流水数和通行费
	@SuppressWarnings("unchecked")
	@Test
	@Rollback(true)
	public void testLoadCenterData() {
		//List list = squadLogService.loadCenterData(null, null, null, null, null);
		//assertNotNull("list对象为空！",list);
	}

	@Override
	String[] getOtherConfigs() {
		return new String[] {applicationContextFile};
	}

}
