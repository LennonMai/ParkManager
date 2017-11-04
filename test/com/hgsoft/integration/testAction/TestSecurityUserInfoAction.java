
package com.hgsoft.integration.testAction;

import java.util.List;

import org.junit.Test;
import org.springframework.context.ApplicationContext;

import org.springframework.test.annotation.Rollback;

import com.hgsoft.action.SecurityUserInfoAction;
import com.hgsoft.util.Pager;



public class TestSecurityUserInfoAction extends AbstractActionTransactionalTests{
//public class TestSecurityUserInfoAction extends StrutsSpringTestCase{
	
	/*@Autowired
	private SecurityUserInfoService securityUserInfoService;*/
	private SecurityUserInfoAction action;
	private static ApplicationContext context;
	
	//不能单独放，无法执行回滚
	/*@Override
	protected void onSetUp() throws Exception {
		if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context对象为空！", context);
		action = (SecurityUserInfoAction) context.getBean("securityUserInfoAction");
		assertNotNull("action对象为空！",action);
	}*/
	/**
	 * 测试删除 String regId
	 */
	@Test
	@Rollback
	public void testDelete() {
		if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context对象为空！", context);
		action = (SecurityUserInfoAction) context.getBean("securityUserInfoAction");
		assertNotNull("action对象为空！",action);
		action.setRegId("21");
		String str = action.delete();
		assertEquals("success", str);
	}
	/**
	 * 测试分页查询
	 */
	@Test
	@Rollback
	public void testQuerySecurityUserInfo() {	
		if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context对象为空！", context);
		action = (SecurityUserInfoAction) context.getBean("securityUserInfoAction");
		assertNotNull("action对象为空！",action);
		action.setPager(new Pager());
		String str = action.querySecurityUserInfo();
		assertEquals("success", str);
		List list = action.getList();
		//System.out.println(list.size());
	}
	/**
	 * 测试跳到注册页面 
	 */
	@Test
	@Rollback
	public void testToRegister() {
		if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context对象为空！", context);
		action = (SecurityUserInfoAction) context.getBean("securityUserInfoAction");
		assertNotNull("action对象为空！",action);
		String str = action.toRegister();
		assertEquals("toRegister", str);
	}
	
	/**
	 * 测试注册
	 */
	@Test
	@Rollback
	public void testRegister() {	
		if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context对象为空！", context);
		action = (SecurityUserInfoAction) context.getBean("securityUserInfoAction");
		assertNotNull("action对象为空！",action);
		action.setCallNum("13728058624");
		action.setCardNo("123456");
		action.setPassword("123456");
		String str = action.register();
		assertEquals("success", str);
	}
	
	/**
	 * 测试获取要更新的对象 string regId
	 */
	@Test
	@Rollback
	public void testToUpdate() {	
		if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context对象为空！", context);
		action = (SecurityUserInfoAction) context.getBean("securityUserInfoAction");
		assertNotNull("action对象为空！",action);
		action.setRegId("18");
		String str = action.toUpdate();
		assertEquals("toUpdate",str);
	}
	/**
	 * 测试更新
	 */
	@Test
	@Rollback
	public void testUpdate() {	
		if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context对象为空！", context);
		action = (SecurityUserInfoAction) context.getBean("securityUserInfoAction");
		assertNotNull("action对象为空！",action);
		action.setRegId("21");
		action.setCallNum("1111111111");
		String str = action.update();
		assertEquals("success", str);
	}
	
	@Override
	String[] getOtherConfigs() {
		return new String[]{applicationContextFile};
	}
}
