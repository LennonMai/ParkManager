package com.hgsoft.integration.testService;

import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;

import com.hgsoft.entity.SecurityCommandBackup;
import com.hgsoft.service.SecurityCommandBackupService;
import com.hgsoft.util.Pager;



public class TestSecurityCommandBackupService extends AbstractServiceTransactionalTests{

	@Autowired
	private SecurityCommandBackupService service;
	
	/**
	 * 
	 */
	@Test
	@Rollback
	public void testSave(){
		SecurityCommandBackup backup = new SecurityCommandBackup();
		backup.setCommandId(123466788);
		backup.setCardNo("123");
		backup.setAddTime(new Date());
		backup.setAttribute(Short.parseShort("1"));
		backup.setEndTime("123456");
		backup.setIsValid(Short.parseShort("1"));
		backup.setModId(1);
		backup.setOperatorNo(123);
		backup.setOperatorType(Short.parseShort("1"));
		backup.setOpTime(new Date());
		backup.setStartTime("13254");
		backup.setStatus(Short.parseShort("1"));
		backup.setType(Short.parseShort("1"));
		backup.setUseType(Short.parseShort("1"));
		backup.setValidType(Short.parseShort("1"));
		service.save(backup);
	}
	/**
	 * 
	 */
	@Test
	@Rollback
	public void testGetCount(){
		long count = service.getCount("1");
		assertEquals(3,count);
	}
	/**
	 * 
	 */
	@Test
	@Rollback
	public void testShow(){
		List list = service.show(new Pager(), "1", "1");
		assertNotNull("list对象为空！",list);
		assertEquals(3,list.size());
	}
	/**
	 * 
	 */
	@Test
	@Rollback
	public void testQuery(){
		/*List list = service.query(new Pager(), null, null, null, null, null);
		assertNotNull("list对象为空！",list);
		assertEquals(15,list.size());*/
		List temp = service.query(new Pager(), null, null, "刘备", null, null);
		assertNotNull("temp对象为空！",temp);
		assertEquals(0,temp.size());
	}
	
	@Override
	String[] getOtherConfigs() {
		// TODO Auto-generated method stub
		return new String[]{applicationContextFile};
	}

}
