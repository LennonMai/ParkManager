package com.hgsoft.integration.testService;
import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;

import com.hgsoft.entity.CardDynamic;
import com.hgsoft.service.CardDynamicService;
import com.hgsoft.util.Pager;



public class TestCardDynamicService extends AbstractServiceTransactionalTests{

	@Autowired
	private CardDynamicService service;
	
	/**
	 * ��ѯδ������ʱ��
	 */
	@Test
	@Rollback
	public void testQueryCardDynamic(){
		List list = service.queryCardDynamic(new Pager(), null, null, null, null, null);
		assertNotNull("list����Ϊ�գ�",list);
		assertEquals(15,list.size());
	}
	/**
	 * ������ˮ������������ˮ��ͼ��Ϣ string listNo
	 */
	@Test
	@Rollback
	public void testGetByListNo(){
		Object obj = service.getByListNo("65010B4B3C83A100");
		assertNotNull("obj����Ϊ�գ�",obj);
	}
	/**
	 * ������ˮ������ó�����ˮ��ͼ��Ϣ string listNo 
	 */
	@Test
	@Rollback
	public void testGetByOutListNo(){
		//Object obj = service.getByOutListNo("6501104B3C839700");
		//assertNotNull("obj����Ϊ�գ�",obj);
	}
	/**
	 * ���ݿ�����������δ������ʱ����Ϣ string cardNo
	 */
	@Test
	@Rollback
	public void testGetByCardNo(){
		CardDynamic cardDynamic = service.getByCardNo("152169427");
		assertNotNull("cardDynamic����Ϊ�գ�",cardDynamic);
	}
	/**
	 * ���£��ö���CardDynamic cardDynamic
	 */
	@Test
	@Rollback
	public void testUpdate(){
		CardDynamic cardDynamic = service.getByCardNo("152169427");
		assertNotNull("cardDynamic����Ϊ�գ�",cardDynamic);
		service.update(cardDynamic);
	}
	
	/**
	 * ��ó�������
	 */
	@Test
	@Rollback
	public void testQueryByOpTimeAndVehPlate(){
		List list = service.queryByOpTimeAndVehPlate(new Date(), "5", "50", "��1233");
		assertNotNull("list����Ϊ�գ�",list);
		assertEquals(0,list.size());
	}
	
	/**
	 * ��ѯ��ˮ��Ϣ
	 */
	@Test
	@Rollback
	public void testWaterQuery(){
		/*List list = service.waterQuery(new Pager(), null, null, null, "1", null, null, null, null, null, null, null, null, null, null, null, null, "1", null, null, null);
		assertNotNull("list����Ϊ�գ�",list);
		assertEquals(15,list.size());*/
	}
	
	
	@Override
	String[] getOtherConfigs() {
		// TODO Auto-generated method stub
		return new String[]{applicationContextFile};
	}

}
