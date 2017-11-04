
package com.hgsoft.integration.testAction;

import java.util.List;

import org.junit.Test;
import org.springframework.context.ApplicationContext;

import org.springframework.test.annotation.Rollback;

import com.hgsoft.action.WaterQueryAction;
import com.hgsoft.util.Pager;


public class TestWaterQueryAction extends AbstractActionTransactionalTests{

	private WaterQueryAction action;
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
		action = (WaterQueryAction) context.getBean("waterQueryAction");
		assertNotNull("action对象为空！",action);
		action.setPager(new Pager());
		String str = action.query();
		assertEquals("waterQuery",str);
		List list = action.getList();
		assertNull("list对象不为空!",list);	
		List parkList = action.getParkList();
		assertNotNull("parkList对象为空！",parkList);
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
		assertNotNull("context对象为空！", context);
		action = (WaterQueryAction) context.getBean("waterQueryAction");
		assertNotNull("action对象为空！",action);
		action.setStatusOutIn("2");
		action.setListNo("650C0C4B3D2C0500");
		//String str = action.show();
		//assertEquals("outShow",str);
		Object obj = action.getAllOutList();
		assertNotNull("obj对象为空！",obj);
	}
	/**
	 * 
	 */
	@Test
	@Rollback
	public void testComplate() {
		if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context对象为空！", context);
		action = (WaterQueryAction) context.getBean("waterQueryAction");
		assertNotNull("action对象为空！",action);
		action.setListNo("650C0C4B3D38B008");
		//String str = action.complate();
		//assertEquals("complate",str);
		Object outObj = action.getAllOutList();
		assertNotNull("outObj对象为空！",outObj);
		Object inObj = action.getAllInList();
		assertNull("inObj对象不为空！",inObj);
	}
	/**
	 * 
	 */
	/*@Test
	@Rollback
	public void testRemoveLeft() {
		if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context对象为空！", context);
		action = (WaterQueryAction) context.getBean("waterQueryAction");
		assertNotNull("action对象为空！",action);
		String temp = action.removeLeft("2");
		assertEquals("2",temp);
	}*/
	/**
	 * 
	 */
	@Test
	@Rollback
	public void testIntToBin() {
		if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context对象为空！", context);
		action = (WaterQueryAction) context.getBean("waterQueryAction");
		assertNotNull("action对象为空！",action);
		action.setStatusOutIn("1");
		action.setQueryStatus("1");
		action.query();
		List list = action.getList();
		assertNotNull("list对象为空！",list);
		//List tempList = action.intToBin(list);
		//assertNotNull("tempList对象为空！",tempList);
	}
	/**
	 * 
	 */
	@Test
	@Rollback
	public void testObjToBin() {
		if(null == context){
			context = this.getApplicationContext();
		}
		assertNotNull("context对象为空！", context);
		action = (WaterQueryAction) context.getBean("waterQueryAction");
		assertNotNull("action对象为空！",action);
		action.setStatusOutIn("2");
		action.setListNo("650C0C4B3D2C0500");
		//action.show();
		Object obj = action.getAllOutList();
		assertNotNull("obj对象为空！",obj);
		//Object tempObj = action.objToBin(obj);
		//assertNotNull("tempObj对象为空！",tempObj);
		
	}
	@Override
	String[] getOtherConfigs() {
		return new String[]{applicationContextFile};
	}
}
