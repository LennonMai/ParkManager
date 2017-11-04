
package com.hgsoft.integration.testAction;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.junit.Test;
import org.springframework.context.ApplicationContext;

import org.springframework.test.annotation.Rollback;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import com.hgsoft.action.LostCardAction;
import com.hgsoft.entity.IdentifyResult;
import com.hgsoft.util.Pager;
import com.opensymphony.xwork2.ActionContext;



public class TestLostCardAction extends AbstractActionTransactionalTests{

	private LostCardAction action;
	private static ApplicationContext context;
	private static ServletActionContext context1;
	/**
	 * ��ѯδ������ʱ��
	 */
	@Test
	@Rollback
	public void testQueryCardDynamic() {
		if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context����Ϊ�գ�", context);
		action = (LostCardAction) context.getBean("lostCardAction");
		assertNotNull("action����Ϊ�գ�",action);
		action.setPager(new Pager());
		action.setStartTime("2010-11-11 12:12:12");
		action.setEndTime("2010-11-11 12:12:13");
		String str = action.queryCardDynamic();
		assertEquals("cardDynamic",str);
		List list = action.getList();
		assertNotNull("list����Ϊ��!",list);
		//System.out.println(list.size());
	}
	/**
	 * ״̬ȷ��
	 */
	@Test
	@Rollback
	public void testCardDynamicOk() {	
		if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context����Ϊ�գ�", context);
		action = (LostCardAction) context.getBean("lostCardAction");
		assertNotNull("action����Ϊ�գ�",action);
		action.setListNo("6528294AEC37CCF7");
		action.setCardNo("123456");
		//String str = action.cardDynamicOk();
		//assertEquals("ok",str);
		//System.out.println(action.getImagSrc());
		
	}
	/**
	 * �첽��ó�����Ϣ�����ƺš�����ʱ�䣩 
	 */
	@Test
	@Rollback
	public void testQueryByOpTimeAndVehPlate() {
		if(null == context){		
			context = this.getApplicationContext();
		}
		assertNotNull("context����Ϊ�գ�", context);
		action = (LostCardAction) context.getBean("lostCardAction");
		assertNotNull("action����Ϊ�գ�",action);
		action.setOpTime(new Date());
		action.setVehPlate("��A12564");
		action.setDays("2");
		action.setBackNums("50");
		//HttpServletResponse response = ServletActionContext.getResponse();��õĶ���Ϊ�գ�
		//String str = action.queryByOpTimeAndVehPlate();
		//assertEquals(null,str);
		List list = action.getAllOutList();
		assertNull("list����Ϊ��!",list);
		//System.out.println(list.size());
		
	}
	
	/**
	 * ���³��ƺţ�ͨ��Ajax��
	 */
	@Test
	@Rollback
	public void testUpdateVehPlate() {	
		if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context����Ϊ�գ�", context);
		action = (LostCardAction) context.getBean("lostCardAction");
		assertNotNull("action����Ϊ�գ�",action);
		
	}
	
	/**
	 * ����״̬��ͨ��Ajax��
	 */
	@Test
	@Rollback
	public void testUpdateStatus() {	
		if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context����Ϊ�գ�", context);
		action = (LostCardAction) context.getBean("lostCardAction");
		assertNotNull("action����Ϊ�գ�",action);
	}
	/**
	 * ���������ˮ�źͳ�����ˮ�ŵó����ڶ������ڶ���
	 */
	@Test
	@Rollback
	public void testHistoryMessage() {	
		if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context����Ϊ�գ�", context);
		action = (LostCardAction) context.getBean("lostCardAction");
		assertNotNull("action����Ϊ�գ�",action);
		action.setInListNo("6528294A679887EF");
		action.setOutListNo("651E1F4A68B36F4B");
		//String str = action.historyMessage();
		//assertEquals("message",str);
		Object obj = action.getInList();
		assertNotNull("obj����Ϊ�գ�",obj);
		Object temp = action.getOutList();
		assertNotNull("temp����Ϊ�գ�",temp);
		//System.out.println(action.getImagSrc());
		//System.out.println(action.getOutSrc());
	}
	
	
	/**
	 * ��ѯ��ʶ��ͼƬȷ��
	 */
	@Test
	@Rollback
	public void testQueryIndentify() {	
		if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context����Ϊ�գ�", context);
		action = (LostCardAction) context.getBean("lostCardAction");
		assertNotNull("action����Ϊ�գ�",action);
		action.setSign("2");
		action.setPager(new Pager());
		String str = action.queryIndentify();
		assertEquals("identify",str);
		List parkList = action.getParkList();
		assertNotNull("parkList����Ϊ�գ�",parkList);
		//System.out.println(parkList.size());
	}
	/**
	 * �����޸ĳ��ƺ�
	 */
	@Test
	@Rollback
	public void testToUpdateIdentify() {	
		if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context����Ϊ�գ�", context);
		action = (LostCardAction) context.getBean("lostCardAction");
		assertNotNull("action����Ϊ�գ�",action);
		action.setSign("1");
		action.setListNo("6501014974235B01");
		String str = action.toUpdateIdentify();
		assertEquals("updateIdentify", str);
	}
	/**
	 * �޸ĳ��ƺ�
	 */
	@Test
	@Rollback
	public void testUpdateIdentify() {	
		if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context����Ϊ�գ�", context);
		action = (LostCardAction) context.getBean("lostCardAction");
		assertNotNull("action����Ϊ�գ�",action);
		IdentifyResult result = new IdentifyResult();
		result.setListNo("6501014974282F06");
		result.setVehPlate("��123456");
		action.setIdentifyResult(result);
		String str = action.updateIdentify();
		assertEquals("identify",str);
		String message = action.getMessage();
		assertEquals("1",message);
	}
	/**
	 * �첽���С��������Ϣ
	 */
	@Test
	@Rollback
	public void testAjaxGate() {	
		if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context����Ϊ�գ�", context);
		action = (LostCardAction) context.getBean("lostCardAction");
		assertNotNull("action����Ϊ�գ�",action);
	}
	/**
	 * �첽��ô��ų�����Ϣ
	 */
	@Test
	@Rollback
	public void testAjaxLane() {	
		if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context����Ϊ�գ�", context);
		action = (LostCardAction) context.getBean("lostCardAction");
		assertNotNull("action����Ϊ�գ�",action);
	}
	
	/**
	 * ��ѯ��������ʷ��¼
	 */
	@Test
	@Rollback
	public void testQueryHistory() {	
		if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context����Ϊ�գ�", context);
		action = (LostCardAction) context.getBean("lostCardAction");
		assertNotNull("action����Ϊ�գ�",action);
		String str = action.queryHistory();
		assertEquals("history",str);
		List list = action.getList();
		assertNotNull("list����Ϊ�գ�",list);
		//System.out.println(list.size());
	}
	
	@Override
	String[] getOtherConfigs() {
		return new String[]{applicationContextFile};
	}
}
