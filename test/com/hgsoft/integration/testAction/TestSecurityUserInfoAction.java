
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
	
	//���ܵ����ţ��޷�ִ�лع�
	/*@Override
	protected void onSetUp() throws Exception {
		if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context����Ϊ�գ�", context);
		action = (SecurityUserInfoAction) context.getBean("securityUserInfoAction");
		assertNotNull("action����Ϊ�գ�",action);
	}*/
	/**
	 * ����ɾ�� String regId
	 */
	@Test
	@Rollback
	public void testDelete() {
		if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context����Ϊ�գ�", context);
		action = (SecurityUserInfoAction) context.getBean("securityUserInfoAction");
		assertNotNull("action����Ϊ�գ�",action);
		action.setRegId("21");
		String str = action.delete();
		assertEquals("success", str);
	}
	/**
	 * ���Է�ҳ��ѯ
	 */
	@Test
	@Rollback
	public void testQuerySecurityUserInfo() {	
		if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context����Ϊ�գ�", context);
		action = (SecurityUserInfoAction) context.getBean("securityUserInfoAction");
		assertNotNull("action����Ϊ�գ�",action);
		action.setPager(new Pager());
		String str = action.querySecurityUserInfo();
		assertEquals("success", str);
		List list = action.getList();
		//System.out.println(list.size());
	}
	/**
	 * ��������ע��ҳ�� 
	 */
	@Test
	@Rollback
	public void testToRegister() {
		if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context����Ϊ�գ�", context);
		action = (SecurityUserInfoAction) context.getBean("securityUserInfoAction");
		assertNotNull("action����Ϊ�գ�",action);
		String str = action.toRegister();
		assertEquals("toRegister", str);
	}
	
	/**
	 * ����ע��
	 */
	@Test
	@Rollback
	public void testRegister() {	
		if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context����Ϊ�գ�", context);
		action = (SecurityUserInfoAction) context.getBean("securityUserInfoAction");
		assertNotNull("action����Ϊ�գ�",action);
		action.setCallNum("13728058624");
		action.setCardNo("123456");
		action.setPassword("123456");
		String str = action.register();
		assertEquals("success", str);
	}
	
	/**
	 * ���Ի�ȡҪ���µĶ��� string regId
	 */
	@Test
	@Rollback
	public void testToUpdate() {	
		if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context����Ϊ�գ�", context);
		action = (SecurityUserInfoAction) context.getBean("securityUserInfoAction");
		assertNotNull("action����Ϊ�գ�",action);
		action.setRegId("18");
		String str = action.toUpdate();
		assertEquals("toUpdate",str);
	}
	/**
	 * ���Ը���
	 */
	@Test
	@Rollback
	public void testUpdate() {	
		if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context����Ϊ�գ�", context);
		action = (SecurityUserInfoAction) context.getBean("securityUserInfoAction");
		assertNotNull("action����Ϊ�գ�",action);
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
