package com.hgsoft.integration.testService;

import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;
import com.hgsoft.service.SecurityVehPassService;
import com.hgsoft.util.Pager;



public class TestSecurityVehPassService extends AbstractServiceTransactionalTests{

	@Autowired
	private SecurityVehPassService service;
	
	/**
	 * 
	 */
	@Test
	@Rollback
	public void testQuery(){
		List list = service.query(new Pager(), null, null, null, "刘备", null, null, null, null);
		assertNotNull("list对象为空！",list);
		assertEquals(0,list.size());
	}
	/**
	 * 
	 */
	@Test
	@Rollback
	public void testQueryHistory(){
		List list = service.queryHistory(new Pager(), null, null, null, null, null, null, null, null);
		assertNotNull("list对象为空",list);
		assertEquals(15,list.size());
	}
	/**
	 * 
	 */
	@Test
	@Rollback
	public void testQueryPass(){
		List list = service.query(new Pager(),"1");
		assertNotNull("list对象为空",list);
		assertEquals(0,list.size());
	}
	/**
	 * 
	 */
	@Test
	@Rollback
	public void testQueryParkList(){
		List list = service.queryParkList();
		assertNotNull("list对象为空",list);
	}
	
	/**
	 * 
	 */
	@Test
	@Rollback
	public void testQueryGateList(){
		List list = service.queryGateList("101");
		assertNotNull("list对象为空",list);
	}
	/**
	 * 
	 */
	@Test
	@Rollback
	public void testQueryLaneList(){
		List list = service.queryLaneList("101", "1");
		assertNotNull("list对象为空",list);
		assertEquals(4,list.size());
	}
	@Override
	String[] getOtherConfigs() {
		// TODO Auto-generated method stub
		return new String[]{applicationContextFile};
	}

}
