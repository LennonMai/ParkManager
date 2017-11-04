
package com.hgsoft.integration.testAction;

import java.util.List;

import org.junit.Test;
import org.springframework.context.ApplicationContext;

import org.springframework.test.annotation.Rollback;

import com.hgsoft.action.SecurityCommandBackupAction;
import com.hgsoft.action.SecurityVehPassAction;
import com.hgsoft.entity.SecurityCommand;
import com.hgsoft.util.Pager;


public class TestSecurityVehPassAction extends AbstractActionTransactionalTests{

	private SecurityVehPassAction action;
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
		assertNotNull("context对象为空！", context);
		action = (SecurityVehPassAction) context.getBean("securityVehPassAction");
		assertNotNull("action对象为空！",action);
		action.setPager(new Pager());
		action.setOnwer("李白");
		String str = action.query();
		assertEquals("success",str);
		List list = action.getList();
		assertNotNull("list对象为空!",list);
		List parkList = action.getParkList();
		assertNotNull("parkList对象为空！",parkList);
		
		
	}
	/**
	 * 
	 */
	@Test
	@Rollback
	public void testQueryVehPass() {
		if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context对象为空！", context);
		action = (SecurityVehPassAction) context.getBean("securityVehPassAction");
		assertNotNull("action对象为空！",action);
		action.setPager(new Pager());
		action.setVehPassId("111111111");
		String str = action.queryVehPass();
		assertEquals("vehPass",str);
		List list = action.getList();
		assertNotNull("list对象为空！",list);
	}
	/**
	 * 
	 */
	@Test
	@Rollback
	public void testQueryHistory() {
		if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context对象为空！", context);
		action = (SecurityVehPassAction) context.getBean("securityVehPassAction");
		assertNotNull("action对象为空！",action);
		action.setPager(new Pager());
		String str = action.queryHistory();
		assertEquals("history",str);
		List list = action.getList();
		assertNotNull("list对象为空！",list);
		List parkList = action.getParkList();
		assertNotNull("parkList对象为空！",parkList);
		
	
	}
	
	@Override
	String[] getOtherConfigs() {
		return new String[]{applicationContextFile};
	}
}
