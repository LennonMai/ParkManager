/**
 * 
 */
package com.hgsoft.unit.testService;

import junit.framework.TestCase;

import org.easymock.EasyMock;
import org.easymock.IMocksControl;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.hgsoft.dao.SysparamconfDao;
import com.hgsoft.service.SysparamconfService;

/**
 * 模拟对象工具--版本：EasyMock 3.0 
 * Library: easymock-3.0.jar,objenesis-1.2.jar
 * 使用EasyMock做单元测试的一般步骤：
 * 1、使用 EasyMock 生成 Mock 对象；
 * 2、设定 Mock 对象的预期行为和输出或返回值；
 * 3、将 Mock 对象切换到 Replay 状态；
 * 4、调用 Mock 对象方法进行单元测试；
 * 5、对 Mock 对象的行为进行验证（可选）。
 * 
 * 以下以SysparamconfService为例，模拟SysparamconfDao对象
 * @author BruceQin
 */
public class Demo_testSysparamconfService extends TestCase{
	 /**
     * 创建Mock对象的控制器IMocksControl的对象，
     * 该控制器适用于需要创建多个Mock对象时。
     */
	private IMocksControl mocksControl;
	
	private SysparamconfDao MocksysparamconfDao;
	private SysparamconfService sysparamconfService;
	

	@Before
	public void setUp() throws Exception {
		/**
		 * 创建Mock对象，有两种方法：
		 * 1、如只需要创建一个Mock对象时，可直接调用EasyMock.createMock(toMock)方法;
		 * 2、需创建多个Mock对象时，需要利用Mock控制器类创建Mock对象，如：
		 *    mocksControl=EasyMock.createControl();		
		 *    mock=mocksControl.createMock(toMcok);
		 */
		mocksControl=EasyMock.createControl();
		MocksysparamconfDao=mocksControl.createMock(SysparamconfDao.class);
	    sysparamconfService =new SysparamconfService();
	}

	@After
	public void tearDown() throws Exception {
		//可在此处进行对象等的销毁操作
	}

	/**
	 * Test method readSysparameter_NulltoInit(String, String)}.
	 */
	@Test
	public void testReadSysparameter_NulltoInit() {
		String pname1="testName",pname2=null,pvalue="testValue";
		/**
		 * 设置Mock对象的行为预期的输出或者返回值。
		 * times(count),count是调用次数
		 */
		EasyMock.expect(MocksysparamconfDao.readSysparameter_NulltoInit(pname1, pvalue)).andReturn(pvalue).times(1);
		EasyMock.expect(MocksysparamconfDao.readSysparameter_NulltoInit(pname2, pvalue)).andReturn("Sysparamconf对象写入数据库").times(1);
		
		/**
		 * 将Mock对象切换到 Replay 状态，即激活Mock对象，使
		 * Mock 对象能够根据设定对特定的方法调用作出预期的响应。
		 * 有两种方法：1、直接使用EasyMock来调用replay()；
		 *            2、使用控制器对象来调用replay()。
		 */
		// EasyMock.replay(MocksysparamconfDao);
		mocksControl.replay();
		
		System.out.println("message1: "+sysparamconfService.readSysparameter_NulltoInit(pname1, pvalue));
		System.out.println("message2: "+sysparamconfService.readSysparameter_NulltoInit(pname2, pvalue));	
		
		/**
		 * 此步骤为可选
		 * 当在录制和回放两个步骤完成之后进行预期和实际结果的检查，
		 * 调用verify()方法：1、直接使用EasyMock来调用verify()；
		 *                  2、使用控制器对象来调用verify()。
		 */
		// EasyMock.verify(sysparamconfServiceMock);
		mocksControl.verify();
	}


}
