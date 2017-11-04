/**
*CopyRight (c) ������ (kevin)  ���ݻ�����Ϣ������޹�˾ http://www.hgsoft.com.cn
*Email:rabitt450@163.com
*ת����ע����Ȩ����
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
		assertNull("obj����Ϊ�գ�",obj);
	}
	/**
	 * 
	 */
	@Test
	@Rollback
	public void testGetInAutoByListNo(){
		Object obj = dao.getInAutoByListNo("123456789");
		assertNull("obj����Ϊ�գ�",obj);
	}
	
	/**
	 * 
	 */
	@Test
	@Rollback
	public void testGetOutAutoByListNo(){
		Object obj = dao.getOutAutoByListNo("123456789");
		assertNull("obj����Ϊ�գ�",obj);
	}
	/**
	 * 
	 */
	@Test
	@Rollback
	public void testQuery(){
		List list = dao.query(new Pager(), null, null, null, null, null, "1");
		assertNotNull("list����Ϊ�գ�",list);
		System.out.println(list.size());
		List list1 = dao.query(new Pager(), null, null, null, null, null, "2");
		assertNotNull("list1����Ϊ�գ�",list1);
		System.out.println(list1.size());
	}
	
	
	@Override
	String[] getOtherConfigs() {
		return new String[]{applicationContextFile};
		
	}

}
