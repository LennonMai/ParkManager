
package com.hgsoft.integration.testAction;

import java.util.List;

import org.junit.Test;
import org.springframework.context.ApplicationContext;

import org.springframework.test.annotation.Rollback;

import com.hgsoft.action.SecurityCommandBackupAction;
import com.hgsoft.entity.SecurityCommand;
import com.hgsoft.util.Pager;


public class TestSecurityCommandBackupAction extends AbstractActionTransactionalTests{

	private SecurityCommandBackupAction action;
	private static ApplicationContext context;

	/**
	 * 
	 */
	@Test
	@Rollback
	public void testQuery(){
		if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context����Ϊ�գ�", context);
		action = (SecurityCommandBackupAction) context.getBean("securityCommandBackupAction");
		assertNotNull("action����Ϊ�գ�",action);
		action.setPager(new Pager());
		//action.setOwner("����");
		String str = action.query();
		assertEquals("success",str);
		List list = action.getList();
		assertNotNull("list����Ϊ��!",list);
		//System.out.println(list.size());
		
		
	}
	/**
	 * 
	 */
	@Test
	@Rollback
	public void testShow() {
		if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context����Ϊ�գ�", context);
		action = (SecurityCommandBackupAction) context.getBean("securityCommandBackupAction");
		assertNotNull("action����Ϊ�գ�",action);
		action.setPager(new Pager());
		action.setCommandId("110");
		action.setModId("1");
		String str = action.show();
		assertEquals("show",str);
		List list = action.getList();
		assertNotNull("list����Ϊ�գ�",list);
		//System.out.println(list.size());
		
	
	}
	
	@Override
	String[] getOtherConfigs() {
		return new String[]{applicationContextFile};
	}
}
