/**
*CopyRight (c) ������ (kevin)  ���ݻ�����Ϣ������޹�˾ http://www.hgsoft.com.cn
*Email:rabitt450@163.com
*ת����ע����Ȩ����
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
	 * ����ܵ�ָ������
	 */
	@Test
	@Rollback
	public void testGetAllCount(){
		Long count = dao.getAllCount();
		assertNotNull("count����Ϊ�գ�",count);
		System.out.println(count);
	}
	
	/**
	 * ����ָ��commandId
	 */
	@Test
	@Rollback
	public void testGetCount(){
		Long count = dao.getCount("100");
		assertNotNull("count����Ϊ�գ�",count);
		assertEquals(0,count.intValue());
		System.out.println(count);
	}
	
	
	
	@Override
	String[] getOtherConfigs() {
		return new String[]{applicationContextFile};
		
	}

}
