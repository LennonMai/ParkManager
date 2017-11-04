/**
*CopyRight (c) 曾根宝 (kevin)  广州华工信息软件有限公司 http://www.hgsoft.com.cn
*Email:rabitt450@163.com
*转载请注明版权所有
*/
package com.hgsoft.unit.testDao;


import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;

import com.hgsoft.dao.SecurityCommandOperationDao;


public class TestSecurityCommandOperationDao extends AbstractDaoTransactionalTests {

	@Autowired
	private SecurityCommandOperationDao dao;
	
	/**
	 * 获得总的指令条数
	 */
	@Test
	@Rollback
	public void testGetAllCount(){
		Long count = dao.getAllCount();
		assertNotNull("count对象为空！",count);
		System.out.println(count);
	}
	
	/**
	 * 根据指令commandId
	 */
	@Test
	@Rollback
	public void testGetCount(){
		Long count = dao.getCount("100");
		assertNotNull("count对象为空！",count);
		assertEquals(0,count.intValue());
		System.out.println(count);
	}
	
	
	
	@Override
	String[] getOtherConfigs() {
		return new String[]{applicationContextFile};
		
	}

}
