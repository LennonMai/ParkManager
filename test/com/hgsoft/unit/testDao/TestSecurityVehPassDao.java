/**
*CopyRight (c) 曾根宝 (kevin)  广州华工信息软件有限公司 http://www.hgsoft.com.cn
*Email:rabitt450@163.com
*转载请注明版权所有
*/
package com.hgsoft.unit.testDao;


import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;

import com.hgsoft.dao.SecurityVehPassDao;
import com.hgsoft.util.Pager;


public class TestSecurityVehPassDao extends AbstractDaoTransactionalTests {

	@Autowired
	private SecurityVehPassDao dao;
	
	/**
	 * 查看过车依据
	 */
	@Test
	@Rollback
	public void testQuery1(){
		List list = dao.query(new Pager(), "1");
		assertNotNull("list数组为空",list);
		System.out.println(list.size());
	}
	
	/**
	 * 查看车道过车记录
	 */
	@Test
	@Rollback
	public void testQuery2(){
		List list = dao.query(new Pager(), null, null, null, null, null, null, null, null);
		assertNotNull("list数组为空！",list);
		System.out.println(list.size());
	}
	
	/**
	 * 根据小区号来获得该小区的所有大门
	 */
	@Test
	@Rollback
	public void testQueryGateList(){
		List list = dao.queryGateList("110");
		assertNotNull("list数组为为空！",list);
		assertEquals(0,list.size());
		System.out.println(list.size());
	}
	
	/**
	 * 查询历史记录
	 */
	@Test
	@Rollback
	public void testQueryHistory(){
		List list = dao.queryHistory(new Pager(), null, null, null, null, null, null, null, null);
		assertNotNull("list数组为空！",list);
		System.out.println(list.size());
	}
	
	/**
	 * 根据小区号和大门号来获得所有的车道信息
	 */
	@Test
	@Rollback
	public void testQueryLaneList(){
		List list = dao.queryLaneList("110", "1");
		assertNotNull("list数组不空！",list);
		assertEquals(0, list.size());
		System.out.println(list.size());
	}
	
	
	/**
	 * 获取所有小区信息
	 */
	@Test
	@Rollback
	public void testQueryParkList(){
		List list = dao.queryParkList();
		assertNotNull("list数组为空！",list);
		System.out.println(list.size());
	}
	
	
	
	@Override
	String[] getOtherConfigs() {
		return new String[]{applicationContextFile};
		
	}

}
