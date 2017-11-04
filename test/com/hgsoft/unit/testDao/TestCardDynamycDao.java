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

import com.hgsoft.dao.CardDynamicDao;
import com.hgsoft.dao.SecurityCommandDao;
import com.hgsoft.entity.AllOutList;
import com.hgsoft.entity.SecurityCommand;
import com.hgsoft.util.Pager;

public class TestCardDynamycDao extends AbstractDaoTransactionalTests {

	@Autowired
	private CardDynamicDao dao;
	
	/**
	 * ���ݿ�����������δ������ʱ����Ϣ
	 */
	@Test
	@Rollback
	public void testGetByCardNo(){
		Object obj = dao.getByCardNo("111111");
		assertNull("obj����Ϊ�գ�",obj);
	}
	/**
	 * ������ˮ������������ˮ��ͼ��Ϣ
	 */
	@Test
	@Rollback
	public void testGetByListNo(){
		Object obj = dao.getByListNo("123456789");
		assertNull("obj����Ϊ�գ�",obj);
	}
	
	/**
	 * ������ˮ������ó�����ˮ��ͼ��Ϣ
	 */
	@Test
	@Rollback
	public void testGetByOutListNo(){
		//Object outList = dao.getByOutListNo("123456789546546");
		//assertNull("outList����Ϊ�գ�",outList);	
	}
	/**
	 * ��ó�������
	 */
	@Test
	@Rollback
	public void testQueryByOpTimeAndVehPlate(){
		List list = dao.queryByOpTimeAndVehPlate(new Date(), "1", "50", "��123456");
		assertNotNull("list����Ϊ�գ�",list);
		assertEquals(0,list.size());
	}
	/**
	 *  ��ѯδ������ʱ��
	 */
	@Test
	@Rollback
	public void testQueryCardDynamic(){
		List list = dao.queryCardDynamic(new Pager(), null, null, null, null, null);
		assertNotNull("list����Ϊ�գ�",list);
		System.out.println(list.size());
	}
	
	/**
	 *  �����ˮ��ѯ
	 */
	@Test
	@Rollback
	public void testWatetQuery(){
		//List list = dao.waterQuery(new Pager(), null, null, null, "1", null, null, null, null, null, null, null, null, 
		//		null, null, null, null, "1", null, null, null, "1");
		//assertNotNull("list����Ϊ�գ�",list);

		
	}
	
	@Override
	String[] getOtherConfigs() {
		return new String[]{applicationContextFile};
		
	}

}
