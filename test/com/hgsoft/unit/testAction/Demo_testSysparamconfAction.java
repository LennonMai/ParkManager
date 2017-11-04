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
 * ģ�⹤�ߣ�EasyMock�汾��EasyMock 3.0 
 * Library: easymock-3.0.jar,objenesis-1.2.jar
 * ʹ��EasyMock����Ԫ���Ե�һ�㲽�裺
 * 1��ʹ�� EasyMock ���� Mock ����
 * 2���趨 Mock �����Ԥ����Ϊ������򷵻�ֵ��
 * 3���� Mock �����л��� Replay ״̬��
 * 4������ Mock ���󷽷����е�Ԫ���ԣ�
 * 5���� Mock �������Ϊ������֤����ѡ����
 * 
 *��Action��Ԫ���ԡ�������������Action���漰�����㣩
 * 
 * ˵����
 *   ����
 *   ʹ��EasyMock��ģ��Service��ĵ��ã�Action�Ļ���ʹ��
 * 
 * 
 * 
 * 
 * 
 * ������SysparamconfActionΪ����ģ��SysparamconfService����
 * @author BruceQin
 */
public class Demo_testSysparamconfAction extends StrutsSpringTestCase{
    /**
     * ����Mock����Ŀ�����IMocksControl�Ķ���
     * �ÿ�������������Ҫ�������Mock����ʱ��
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
		 * ����Mock���������ַ�����
		 * 1����ֻ��Ҫ����һ��Mock����ʱ����ֱ�ӵ���EasyMock.createMock(toMock)����;
		 * 2���贴�����Mock����ʱ����Ҫ����Mock�������ഴ��Mock�����磺
		 *    mocksControl=EasyMock.createControl();		
		 *    mock=mocksControl.createMock(toMcok);
		 */
		mocksControl=EasyMock.createControl();		
		sysparamconfService=mocksControl.createMock(SysparamconfService.class);
		mockHttpServletResponse=new MockHttpServletResponse();
		
	}

	@After
	public void tearDown() throws Exception {
		//���ڴ˴����ж���ȵ����ٲ���
	}

	@Test
	public void testDataToExcel() throws ServletException {
		Sysparamconf sysparamconf=new Sysparamconf();
		sysparamconf.setPname("testName1");
		sysparamconf.setPtype(1);
		sysparamconf.setPvalue("testValue1");
		sysparamconf.setRemark("����");
		sysparamconf.setSys_id(1);
		List<Sysparamconf> testList= new ArrayList<Sysparamconf>();
		testList.add(sysparamconf);
		
		/**
		 * ����Mock�������ΪԤ�ڵ�������߷���ֵ��
		 * times(count),count�ǵ��ô���
		 */
		EasyMock.expect(sysparamconfService.findAll()).andReturn(testList).times(2);
		
		/**
		 * ��Mock�����л��� Replay ״̬��������Mock����ʹ
		 * Mock �����ܹ������趨���ض��ķ�����������Ԥ�ڵ���Ӧ��
		 * �����ַ�����1��ֱ��ʹ��EasyMock������replay()��
		 *            2��ʹ�ÿ���������������replay()��
		 */
		// EasyMock.replay(sysparamconfService);
		mocksControl.replay();
		
        //�������ģ�����Ϊ����ֵ��������testList
		System.out.println(sysparamconfService.findAll().get(0).getPname());
		
		//���Խ����ݵ�����Excel����Action����dataToExcel()
		
		List<Sysparamconf> sysparamconfList= new ArrayList<Sysparamconf>();
	    sysparamconfList=sysparamconfService.findAll();
	    
	    System.out.println("ģ���findAll()���������"+sysparamconfList);
	  
	    sysparamconfAction.dataToExcel();
	    
	  
	    
	    
	    
	    
	    
	    
	    /**
		try {

			// ��Ҫ�ɹ���ȡHttpServletResponse���ܳɹ�������Ӧͷ
			//ServletActionContext.getResponse()����Action�л�ȡResponse���ڴ˴�ֱ��ʹ��
			//new MockHttpServletResponse()������Mock����mockHttpServletResponse
			// mockHttpServletResponse=ServletActionContext.getResponse();
			
			mockHttpServletResponse.setContentType("application/octets-stream;charset=gb2312");
			// response.setContentType("octets/stream");//�򵥿�������Ϊ��Ϣ��
			mockHttpServletResponse.addHeader("Content-Disposition",
					"attachment;filename=SystemParameterInformation.xls");
			// �ͻ��˲�����
			mockHttpServletResponse.addHeader("Pragma", "no-cache");
			mockHttpServletResponse.addHeader("Cache-Control", "no-cache");
			ExcelUtil<Sysparamconf> excelUtil = new ExcelUtil<Sysparamconf>();
			String[] headers = { "���", "������", "����ֵ", "���", "��ע" };
			OutputStream out = mockHttpServletResponse.getOutputStream();
			excelUtil.exportExcel(headers, sysparamconfList,out);
			out.close();
			// reset()--Clears any data that exists in the buffer as well as the
			// status code and headers.
			// If the response has been committed, this method throws an
			// IllegalStateException.
			// mockHttpServletResponse.reset();
			 System.out.println("Excel�����ɹ���");
		} catch (IOException e) {
			e.printStackTrace();
		}
 	**/
		
		
		/**
		 * �˲���Ϊ��ѡ
		 * ����¼�ƺͻط������������֮�����Ԥ�ں�ʵ�ʽ���ļ�飬
		 * ����verify()������1��ֱ��ʹ��EasyMock������verify()��
		 *                  2��ʹ�ÿ���������������verify()��
		 */
		// EasyMock.verify(sysparamconfServiceMock);
		//mocksControl.verify();
		
	}

}
