package com.hgsoft.integration.testService;

import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;

import com.hgsoft.entity.SecurityCommand;
import com.hgsoft.service.SecurityCommandService;
import com.hgsoft.util.Pager;



public class TestSecurityCommandService extends AbstractServiceTransactionalTests{

	@Autowired
	private SecurityCommandService service;
	
	/**
	 * 
	 */
	@Test
	@Rollback
	public void testQuerySecurityCommand(){
		List list =service.querySecurityCommand(new Pager(), "����", null, null, null, null);
		assertNotNull("list����Ϊ�գ�",list);
		assertEquals(0,list.size());
	}
	/**
	 * 
	 */
	@Test
	@Rollback
	public void testQueryCommand(){
		List list = service.queryCommand(null, null, null);
		assertNotNull("list����Ϊ�գ�",list);
		
	}
	/**
	 * 
	 */
	@Test
	@Rollback
	public void testGetCheckUserCardInfo(){
		boolean flag = service.getByCardNoTypeValidType("123456",Short.parseShort("1"), Short.parseShort("1"));
		assertEquals(false,flag);
	}
	/**
	 * ���Ӱ�ȫָ��
	 */
	@Test
	@Rollback
	public void testSave(){
		SecurityCommand command = new SecurityCommand();
		command.setAttribute(Short.parseShort("1"));
		command.setCardNo("111111");
		command.setEndTime("20101214");
		command.setOperatorType(Short.parseShort("1"));
		command.setOpTime(new Date());
		command.setStartTime("20101214");
		command.setStatus(Short.parseShort("1"));
		command.setType(Short.parseShort("1"));
		command.setUseType(Short.parseShort("1"));
		command.setValidType(Short.parseShort("1"));
		service.save(command);
	}
	/**
	 * ����Ƿ�Ϊ����ʱ
	 */
	@Test
	@Rollback
	public void testGetByCardNoTypeValidType(){
		boolean flag = service.getByCardNoTypeValidType("123456", Short.parseShort("1"), Short.parseShort("1"));
		assertEquals(false,flag);
	}
	/**
	 * ����commandId����ö���
	 */
	@Test
	@Rollback
	public void testGetByCommandId(){
		Object obj = service.getByCommandId("1");
		assertNotNull("obj����Ϊ�գ�",obj);
	}
	/**
	 * ����
	 */
	@Test
	@Rollback
	public void testUpdate(){
		SecurityCommand obj = service.getByCommandId("1");
		obj.setOperatorNo(10000000);
		service.update(obj);
	}
	/**
	 * ɾ��
	 */
	@Test
	@Rollback
	public void testDelete(){
		SecurityCommand obj = service.getByCommandId("1");
		service.delete(obj);
	}
	@Override
	String[] getOtherConfigs() {
		// TODO Auto-generated method stub
		return new String[]{applicationContextFile};
	}

}
