package com.hgsoft.integration.testService;
import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;

import com.hgsoft.entity.IdentifyResult;
import com.hgsoft.service.IdentifyResultService;
import com.hgsoft.util.Pager;



public class TestIdentifyResultService extends AbstractServiceTransactionalTests{

	@Autowired
	private IdentifyResultService service;
	
	/**
	 * ��ҳ��ѯ��ʶ��ͼƬȷ��
	 */
	@Test
	@Rollback
	public void testQuery(){
		List list = service.query(new Pager(), null, null, null, null, null, "1");
		assertNotNull("list����Ϊ�գ�",list);
		assertEquals(15,list.size());
	}
	/**
	 * String listNo
	 */
	@Test
	@Rollback
	public void testGetById(){
		Object obj = service.getById("65010B4705F7FF10");
		assertNotNull("obj����Ϊ�գ�",obj);
	}
	/**
	 * IdentifyResult result
	 */
	@Test
	@Rollback
	public void testUpdate(){
		IdentifyResult obj = service.getById("65010B4705F7FF10");
		assertNotNull("obj����Ϊ�գ�",obj);
		obj.setVehPlate("��123456");
		service.update(obj);
	}
	/**
	 * ���InListForAuto���е�һ������
	 */
	@Test
	@Rollback
	public void testGetInAutoByListNo(){
		Object obj = service.getInAutoByListNo("010165460F56C300");
		assertNotNull("obj����Ϊ�գ�",obj);
	}
	/**
	 * ���OutListForAuto���е�һ������
	 */
	@Test
	@Rollback
	public void testGetOutAutoByListNo(){
		Object obj = service.getOutAutoByListNo("01012F46011DDB00");
		assertNotNull("obj����Ϊ�գ�",obj);
	}
	
	@Override
	String[] getOtherConfigs() {
		// TODO Auto-generated method stub
		return new String[]{applicationContextFile};
	}

}
