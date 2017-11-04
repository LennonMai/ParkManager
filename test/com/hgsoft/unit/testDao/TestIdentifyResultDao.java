/**
*CopyRight (c) 曾根宝 (kevin)  广州华工信息软件有限公司 http://www.hgsoft.com.cn
*Email:rabitt450@163.com
*转载请注明版权所有
*/
package com.hgsoft.unit.testDao;

import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;

import com.hgsoft.dao.IdentifyResultDao;
import com.hgsoft.util.Pager;

public class TestIdentifyResultDao extends AbstractDaoTransactionalTests {

	@Autowired
	private IdentifyResultDao dao;
	
	/**
	 * 
	 */
	@Test
	@Rollback
	public void testGetById(){
		Object obj = dao.getById("08740521321363465");
		assertNull("obj对象不为空！",obj);
	}
	/**
	 * 
	 */
	@Test
	@Rollback
	public void testGetInAutoByListNo(){
		Object obj = dao.getInAutoByListNo("123456789");
		assertNull("obj对象不为空！",obj);
	}
	
	/**
	 * 
	 */
	@Test
	@Rollback
	public void testGetOutAutoByListNo(){
		Object obj = dao.getOutAutoByListNo("123456789");
		assertNull("obj对象不为空！",obj);
	}
	/**
	 * 
	 */
	@Test
	@Rollback
	public void testQuery(){
		List list = dao.query(new Pager(), null, null, null, null, null, "1");
		assertNotNull("list对象为空！",list);
		System.out.println(list.size());
		List list1 = dao.query(new Pager(), null, null, null, null, null, "2");
		assertNotNull("list1对象为空！",list1);
		System.out.println(list1.size());
	}
	
	
	@Override
	String[] getOtherConfigs() {
		return new String[]{applicationContextFile};
		
	}

}
