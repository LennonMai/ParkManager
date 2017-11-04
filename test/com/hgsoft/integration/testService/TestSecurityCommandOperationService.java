package com.hgsoft.integration.testService;


import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;

import com.hgsoft.entity.SecurityCommandOperation;
import com.hgsoft.service.SecurityCommandOperationService;




public class TestSecurityCommandOperationService extends AbstractServiceTransactionalTests{

	@Autowired
	private SecurityCommandOperationService service;
	
	/**
	 * 
	 */
	@Test
	@Rollback
	public void testSave(){
		SecurityCommandOperation operation = new SecurityCommandOperation();
		operation.setCommandId(1);
		operation.setOperationId(100);
		operation.setOperationType(Short.parseShort("1"));
		operation.setPostModId(1);
		operation.setPreModId(2);
		service.save(operation);
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
	public void testGetAllCount(){
		long count = service.getAllCount();
		assertEquals(true,count>0);
	}
	
	@Override
	String[] getOtherConfigs() {
		// TODO Auto-generated method stub
		return new String[]{applicationContextFile};
	}

}
