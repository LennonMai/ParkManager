/**
*CopyRight (c) ������ (kevin)  ���ݻ�����Ϣ������޹�˾ http://www.hgsoft.com.cn
*Email:rabitt450@163.com
*ת����ע����Ȩ����
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
	 * �鿴��������
	 */
	@Test
	@Rollback
	public void testQuery1(){
		List list = dao.query(new Pager(), "1");
		assertNotNull("list����Ϊ��",list);
		System.out.println(list.size());
	}
	
	/**
	 * �鿴����������¼
	 */
	@Test
	@Rollback
	public void testQuery2(){
		List list = dao.query(new Pager(), null, null, null, null, null, null, null, null);
		assertNotNull("list����Ϊ�գ�",list);
		System.out.println(list.size());
	}
	
	/**
	 * ����С��������ø�С�������д���
	 */
	@Test
	@Rollback
	public void testQueryGateList(){
		List list = dao.queryGateList("110");
		assertNotNull("list����ΪΪ�գ�",list);
		assertEquals(0,list.size());
		System.out.println(list.size());
	}
	
	/**
	 * ��ѯ��ʷ��¼
	 */
	@Test
	@Rollback
	public void testQueryHistory(){
		List list = dao.queryHistory(new Pager(), null, null, null, null, null, null, null, null);
		assertNotNull("list����Ϊ�գ�",list);
		System.out.println(list.size());
	}
	
	/**
	 * ����С���źʹ��ź���������еĳ�����Ϣ
	 */
	@Test
	@Rollback
	public void testQueryLaneList(){
		List list = dao.queryLaneList("110", "1");
		assertNotNull("list���鲻�գ�",list);
		assertEquals(0, list.size());
		System.out.println(list.size());
	}
	
	
	/**
	 * ��ȡ����С����Ϣ
	 */
	@Test
	@Rollback
	public void testQueryParkList(){
		List list = dao.queryParkList();
		assertNotNull("list����Ϊ�գ�",list);
		System.out.println(list.size());
	}
	
	
	
	@Override
	String[] getOtherConfigs() {
		return new String[]{applicationContextFile};
		
	}

}
