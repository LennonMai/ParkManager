package com.hgsoft.unit.testDao;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;

import com.hgsoft.dao.GenerateSumDao;
import com.hgsoft.util.Pager;

public class TestGenerateSumDao extends AbstractDaoTransactionalTests {

	@Autowired
	private GenerateSumDao generateSumDao;
	
	//查询大门总合计数列表
	@SuppressWarnings("unchecked")
	@Test
	@Rollback(true)
	public void testQueryGateSum() {
		List list = generateSumDao.queryGateSum(new Pager(), null, null, null, null, null);
		assertNotNull("list数组为空", list);
//		System.out.println("list_size:" + list.size());
	}
	
	//查询车道合计数列表
	@SuppressWarnings("unchecked")
	@Test
	@Rollback(true)
	public void testQueryLaneSum() {
		List list = generateSumDao.queryLaneSum(null, null, null, null);
		assertNotNull("list数组为空", list);
	}
	
	//查询没合计车道总列表
	@SuppressWarnings("unchecked")
	@Test
	@Rollback(true)
	public void testLaneNotSum() {
		List list = generateSumDao.queryLaneNotSum(null, null, null, null);
		assertNotNull("list数组为空", list);
	}
	
	//计算中心数据
	@SuppressWarnings("unchecked")
	@Test
	@Rollback(true)
	public void testCountCenterLaneData() {
		List list = generateSumDao.countCenterLaneData(null, null, null, null, null, null, null);
		assertNull("list数组不为空", list);
	}
	
	//生成车道合计数
	@Test
	@Rollback(true)
	public void testGenerateLaneSum() {
		boolean test = generateSumDao.generateLaneSum(null, null, null, null, null, null, null, null, null);
		assertFalse("插入对象成功", test);
	}
	
	//生成大门合计数
	@Test
	@Rollback(true)
	public void testGenerateGateSum() {
		boolean test =  generateSumDao.generateGateSum(null, null, null, null);
		assertFalse("插入对象成功", test);
	}
	
	//查询车道合计数是否存在
	@Test
	@Rollback(true)
	public void testSelectLaneSum() {
		int size = generateSumDao.selectLaneSum(null, null, null, null, null, null);
		assertEquals("记录数不为0", 0, size);
	}
	
	//计算工班数
	@Test
	@Rollback(true)
	public void testCountSquad() {
		int squadCount = generateSumDao.countSquad();
		System.out.println("squadCount:"+squadCount);
//		assertEquals("工班数不为3", 3, squadCount);
	}
	
	//计算大门出口车道数
	@Test
	@Rollback(true)
	public void testCountLane() {
		int outLane = generateSumDao.countLane(null);
		System.out.println("outLane:"+outLane);
//		assertEquals("出口车道数不为3", 3, outLane);
	}
	
	//计算已经合计的大门车道数
	@Test
	@Rollback(true)
	public void testCountLaneSummation() {
		int laneSummationCount = generateSumDao.countLaneSummation(null, null, null, null);
		System.out.println("laneSummationCount:"+laneSummationCount);
//		assertEquals("合计的大门车道数不为3", 3, laneSummationCount);
	}
	
	//计算车道工班表中的记录数
	@Test
	@Rollback(true)
	public void testCountSquadLog() {
		int squadLogCount = generateSumDao.countSquadLog(null, null, null, null);
		System.out.println("squadLogCount:"+squadLogCount);
//		assertEquals("合计的大门车道数不为3", 3, squadCount);
	}

	@Override
	String[] getOtherConfigs() {
		return new String[] {applicationContextFile};
	}
}
