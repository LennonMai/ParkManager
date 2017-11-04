
package com.hgsoft.integration.testAction;

import java.util.List;

import org.junit.Test;
import org.springframework.context.ApplicationContext;

import org.springframework.test.annotation.Rollback;

import com.hgsoft.action.SecurityCommandAction;
import com.hgsoft.entity.SecurityCommand;
import com.hgsoft.util.Pager;


public class TestSecurityCommandAction extends AbstractActionTransactionalTests{

	private SecurityCommandAction action;
	private static ApplicationContext context;
	//private static ActionContext ac;
	/**
	 * @throws IllegalAccessException 
	 * @throws InstantiationException 
	 * 
	 */
	@Test
	@Rollback
	public void testQuery(){
		if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context对象为空！", context);
		/*Map session = new HashMap();
		Admin operator = new Admin();
		session.put("operator", operator);
		
		MockServletContext servlet = new MockServletContext();
		ServletContext servletContext = servlet;
		Dispatcher dispatcher = new Dispatcher(servletContext, new HashMap());	
		assertNotNull("dispatcher对象为空!",dispatcher);
		//System.out.println(dispatcher.getConfigurationManager());
        dispatcher.init();  
        Dispatcher.setInstance(dispatcher); 
        
		Container container = dispatcher.getContainer();   
        ValueStack stack = container.getInstance(ValueStackFactory.class).createValueStack();   
        ActionContext.setContext(new ActionContext(stack.getContext()));   
		MockHttpServletRequest mockRequest = new MockHttpServletRequest();   
        mockRequest.setSession(new MockHttpSession());
        mockRequest.getSession().setAttribute("operator", operator); 
        ServletActionContext.setRequest(mockRequest);*/
		action = (SecurityCommandAction) context.getBean("securityCommandAction");
		assertNotNull("action对象为空！",action);
		action.setPager(new Pager());
		action.setOwner("曾根宝");
		String str = action.query();
		assertEquals("success",str);
		List list = action.getList();
		assertNotNull("list对象为空!",list);
		//System.out.println(list.size());
		/*Admin admin = action.getCurrentOperator();
		assertNotNull("admin对象为空!",admin);*/
		
	}
	/**
	 * 
	 */
	@Test
	@Rollback
	public void testToAddCommand() {
		if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context对象为空！", context);
		action = (SecurityCommandAction) context.getBean("securityCommandAction");
		assertNotNull("action对象为空！",action);
		String str = action.toAddCommand();
		assertEquals("addCommand",str);
	}
	/**
	 * 
	 */
	@Test
	@Rollback
	public void testToUpdateCommand() {
		if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context对象为空！", context);
		action = (SecurityCommandAction) context.getBean("securityCommandAction");
		assertNotNull("action对象为空！",action);
		action.setCommandId("12");
		String str = action.toUpdateCommand();
		assertEquals("update",str);
		Object obj = action.getSecurityCommand();
		assertNull("obj对象不为空!",obj);
	}
	/**
	 * 
	 */
	@Test
	@Rollback
	public void testUpdateCommand() {
		if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context对象为空！", context);
		action = (SecurityCommandAction) context.getBean("securityCommandAction");
		assertNotNull("action对象为空！",action);
		action.setCommandId("27");
		action.setDayEndTime("10:10:10");
		action.setDayStartTime("10:10:10");
		action.setStartTime1("2010-10-10 10:10:10");
		action.setEndTime1("2010-09-01 10:10:10");
		String str = action.updateCommand();
		assertEquals("success",str);
		String message = action.getMessage();
		assertEquals("7",message);
	}
	/**
	 * 
	 */
	@Test
	@Rollback
	public void testDelete() {
		if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context对象为空！", context);
		action = (SecurityCommandAction) context.getBean("securityCommandAction");
		assertNotNull("action对象为空！",action);
		action.setCommandId("26");
		String str = action.delete();
		assertEquals("success",str);
		String message = action.getMessage();
		assertEquals("9",message);
	}
	/**
	 * 
	 */
	@Test
	@Rollback
	public void testAddCommand() {
		if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context对象为空！", context);
		action = (SecurityCommandAction) context.getBean("securityCommandAction");
		assertNotNull("action对象为空！",action);
		SecurityCommand command = new SecurityCommand();
		command.setValidType(Short.parseShort("1"));
		action.setDayStartTime("10:10:10");
		action.setDayEndTime("12:10:10");
		action.setSecurityCommand(command);
		String str = action.addCommand();
		assertEquals("success",str);
		String message = action.getMessage();
		assertEquals("1",message);
	}
	
	@Override
	String[] getOtherConfigs() {
		return new String[]{applicationContextFile};
	}
}
