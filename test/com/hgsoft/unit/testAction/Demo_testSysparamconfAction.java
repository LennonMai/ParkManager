package com.hgsoft.unit.testAction;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.StrutsSpringTestCase;
import org.easymock.EasyMock;
import org.easymock.IMocksControl;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.mock.web.MockHttpServletResponse;

import com.hgsoft.action.SysparamconfAction;
import com.hgsoft.entity.Sysparamconf;
import com.hgsoft.service.SysparamconfService;

/**
 * 模拟工具：EasyMock版本：EasyMock 3.0 
 * Library: easymock-3.0.jar,objenesis-1.2.jar
 * 使用EasyMock做单元测试的一般步骤：
 * 1、使用 EasyMock 生成 Mock 对象；
 * 2、设定 Mock 对象的预期行为和输出或返回值；
 * 3、将 Mock 对象切换到 Replay 状态；
 * 4、调用 Mock 对象方法进行单元测试；
 * 5、对 Mock 对象的行为进行验证（可选）。
 * 
 *【Action单元测试】（即单独测试Action不涉及其他层）
 * 
 * 说明：
 *   包：
 *   使用EasyMock来模拟Service层的调用；Action的环境使用
 * 
 * 
 * 
 * 
 * 
 * 以下以SysparamconfAction为例，模拟SysparamconfService对象
 * @author BruceQin
 */
public class Demo_testSysparamconfAction extends StrutsSpringTestCase{
    /**
     * 创建Mock对象的控制器IMocksControl的对象，
     * 该控制器适用于需要创建多个Mock对象时。
     */
	private IMocksControl mocksControl;
	
	private HttpServletResponse mockHttpServletResponse; 
	private ServletActionContext mockServletActionContext;
	@Resource
	private SysparamconfService sysparamconfService;
	private SysparamconfAction sysparamconfAction;
	
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
		sysparamconfService=mocksControl.createMock(SysparamconfService.class);
		mockHttpServletResponse=new MockHttpServletResponse();
		
	}

	@After
	public void tearDown() throws Exception {
		//可在此处进行对象等的销毁操作
	}

	@Test
	public void testDataToExcel() throws ServletException {
		Sysparamconf sysparamconf=new Sysparamconf();
		sysparamconf.setPname("testName1");
		sysparamconf.setPtype(1);
		sysparamconf.setPvalue("testValue1");
		sysparamconf.setRemark("测试");
		sysparamconf.setSys_id(1);
		List<Sysparamconf> testList= new ArrayList<Sysparamconf>();
		testList.add(sysparamconf);
		
		/**
		 * 设置Mock对象的行为预期的输出或者返回值。
		 * times(count),count是调用次数
		 */
		EasyMock.expect(sysparamconfService.findAll()).andReturn(testList).times(2);
		
		/**
		 * 将Mock对象切换到 Replay 状态，即激活Mock对象，使
		 * Mock 对象能够根据设定对特定的方法调用作出预期的响应。
		 * 有两种方法：1、直接使用EasyMock来调用replay()；
		 *            2、使用控制器对象来调用replay()。
		 */
		// EasyMock.replay(sysparamconfService);
		mocksControl.replay();
		
        //测试输出模拟的行为返回值，将返回testList
		System.out.println(sysparamconfService.findAll().get(0).getPname());
		
		//测试将数据导出到Excel表格的Action方法dataToExcel()
		
		List<Sysparamconf> sysparamconfList= new ArrayList<Sysparamconf>();
	    sysparamconfList=sysparamconfService.findAll();
	    
	    System.out.println("模拟的findAll()方法结果："+sysparamconfList);
	  
	    sysparamconfAction.dataToExcel();
	    
	  
	    
	    
	    
	    
	    
	    
	    /**
		try {

			// 需要成功获取HttpServletResponse才能成功配置响应头
			//ServletActionContext.getResponse()是在Action中获取Response，在此处直接使用
			//new MockHttpServletResponse()创建的Mock对象mockHttpServletResponse
			// mockHttpServletResponse=ServletActionContext.getResponse();
			
			mockHttpServletResponse.setContentType("application/octets-stream;charset=gb2312");
			// response.setContentType("octets/stream");//简单可以设置为信息流
			mockHttpServletResponse.addHeader("Content-Disposition",
					"attachment;filename=SystemParameterInformation.xls");
			// 客户端不缓存
			mockHttpServletResponse.addHeader("Pragma", "no-cache");
			mockHttpServletResponse.addHeader("Cache-Control", "no-cache");
			ExcelUtil<Sysparamconf> excelUtil = new ExcelUtil<Sysparamconf>();
			String[] headers = { "序号", "参数名", "参数值", "类别", "备注" };
			OutputStream out = mockHttpServletResponse.getOutputStream();
			excelUtil.exportExcel(headers, sysparamconfList,out);
			out.close();
			// reset()--Clears any data that exists in the buffer as well as the
			// status code and headers.
			// If the response has been committed, this method throws an
			// IllegalStateException.
			// mockHttpServletResponse.reset();
			 System.out.println("Excel导出成功！");
		} catch (IOException e) {
			e.printStackTrace();
		}
 	**/
		
		
		/**
		 * 此步骤为可选
		 * 当在录制和回放两个步骤完成之后进行预期和实际结果的检查，
		 * 调用verify()方法：1、直接使用EasyMock来调用verify()；
		 *                  2、使用控制器对象来调用verify()。
		 */
		// EasyMock.verify(sysparamconfServiceMock);
		//mocksControl.verify();
		
	}

}
