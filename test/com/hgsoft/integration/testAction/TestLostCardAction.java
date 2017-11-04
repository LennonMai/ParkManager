
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
	 * 查询未回收临时卡
	 */
	@Test
	@Rollback
	public void testQueryCardDynamic() {
		if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context对象为空！", context);
		action = (LostCardAction) context.getBean("lostCardAction");
		assertNotNull("action对象为空！",action);
		action.setPager(new Pager());
		action.setStartTime("2010-11-11 12:12:12");
		action.setEndTime("2010-11-11 12:12:13");
		String str = action.queryCardDynamic();
		assertEquals("cardDynamic",str);
		List list = action.getList();
		assertNotNull("list对象为空!",list);
		//System.out.println(list.size());
	}
	/**
	 * 状态确认
	 */
	@Test
	@Rollback
	public void testCardDynamicOk() {	
		if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context对象为空！", context);
		action = (LostCardAction) context.getBean("lostCardAction");
		assertNotNull("action对象为空！",action);
		action.setListNo("6528294AEC37CCF7");
		action.setCardNo("123456");
		//String str = action.cardDynamicOk();
		//assertEquals("ok",str);
		//System.out.println(action.getImagSrc());
		
	}
	/**
	 * 异步获得出口信息（车牌号、操作时间） 
	 */
	@Test
	@Rollback
	public void testQueryByOpTimeAndVehPlate() {
		if(null == context){		
			context = this.getApplicationContext();
		}
		assertNotNull("context对象为空！", context);
		action = (LostCardAction) context.getBean("lostCardAction");
		assertNotNull("action对象为空！",action);
		action.setOpTime(new Date());
		action.setVehPlate("粤A12564");
		action.setDays("2");
		action.setBackNums("50");
		//HttpServletResponse response = ServletActionContext.getResponse();获得的对象为空！
		//String str = action.queryByOpTimeAndVehPlate();
		//assertEquals(null,str);
		List list = action.getAllOutList();
		assertNull("list对象不为空!",list);
		//System.out.println(list.size());
		
	}
	
	/**
	 * 更新车牌号（通过Ajax）
	 */
	@Test
	@Rollback
	public void testUpdateVehPlate() {	
		if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context对象为空！", context);
		action = (LostCardAction) context.getBean("lostCardAction");
		assertNotNull("action对象为空！",action);
		
	}
	
	/**
	 * 更新状态（通过Ajax）
	 */
	@Test
	@Rollback
	public void testUpdateStatus() {	
		if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context对象为空！", context);
		action = (LostCardAction) context.getBean("lostCardAction");
		assertNotNull("action对象为空！",action);
	}
	/**
	 * 根据入口流水号和出口流水号得出出口对象和入口对象
	 */
	@Test
	@Rollback
	public void testHistoryMessage() {	
		if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context对象为空！", context);
		action = (LostCardAction) context.getBean("lostCardAction");
		assertNotNull("action对象为空！",action);
		action.setInListNo("6528294A679887EF");
		action.setOutListNo("651E1F4A68B36F4B");
		//String str = action.historyMessage();
		//assertEquals("message",str);
		Object obj = action.getInList();
		assertNotNull("obj对象为空！",obj);
		Object temp = action.getOutList();
		assertNotNull("temp对象为空！",temp);
		//System.out.println(action.getImagSrc());
		//System.out.println(action.getOutSrc());
	}
	
	
	/**
	 * 查询再识别图片确认
	 */
	@Test
	@Rollback
	public void testQueryIndentify() {	
		if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context对象为空！", context);
		action = (LostCardAction) context.getBean("lostCardAction");
		assertNotNull("action对象为空！",action);
		action.setSign("2");
		action.setPager(new Pager());
		String str = action.queryIndentify();
		assertEquals("identify",str);
		List parkList = action.getParkList();
		assertNotNull("parkList对象为空！",parkList);
		//System.out.println(parkList.size());
	}
	/**
	 * 跳到修改车牌号
	 */
	@Test
	@Rollback
	public void testToUpdateIdentify() {	
		if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context对象为空！", context);
		action = (LostCardAction) context.getBean("lostCardAction");
		assertNotNull("action对象为空！",action);
		action.setSign("1");
		action.setListNo("6501014974235B01");
		String str = action.toUpdateIdentify();
		assertEquals("updateIdentify", str);
	}
	/**
	 * 修改车牌号
	 */
	@Test
	@Rollback
	public void testUpdateIdentify() {	
		if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context对象为空！", context);
		action = (LostCardAction) context.getBean("lostCardAction");
		assertNotNull("action对象为空！",action);
		IdentifyResult result = new IdentifyResult();
		result.setListNo("6501014974282F06");
		result.setVehPlate("粤123456");
		action.setIdentifyResult(result);
		String str = action.updateIdentify();
		assertEquals("identify",str);
		String message = action.getMessage();
		assertEquals("1",message);
	}
	/**
	 * 异步获得小区大门信息
	 */
	@Test
	@Rollback
	public void testAjaxGate() {	
		if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context对象为空！", context);
		action = (LostCardAction) context.getBean("lostCardAction");
		assertNotNull("action对象为空！",action);
	}
	/**
	 * 异步获得大门车道信息
	 */
	@Test
	@Rollback
	public void testAjaxLane() {	
		if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context对象为空！", context);
		action = (LostCardAction) context.getBean("lostCardAction");
		assertNotNull("action对象为空！",action);
	}
	
	/**
	 * 查询卡丢卡历史记录
	 */
	@Test
	@Rollback
	public void testQueryHistory() {	
		if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context对象为空！", context);
		action = (LostCardAction) context.getBean("lostCardAction");
		assertNotNull("action对象为空！",action);
		String str = action.queryHistory();
		assertEquals("history",str);
		List list = action.getList();
		assertNotNull("list对象为空！",list);
		//System.out.println(list.size());
	}
	
	@Override
	String[] getOtherConfigs() {
		return new String[]{applicationContextFile};
	}
}
