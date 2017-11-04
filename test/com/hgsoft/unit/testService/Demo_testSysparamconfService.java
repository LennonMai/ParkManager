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
 * ģ����󹤾�--�汾��EasyMock 3.0 
 * Library: easymock-3.0.jar,objenesis-1.2.jar
 * ʹ��EasyMock����Ԫ���Ե�һ�㲽�裺
 * 1��ʹ�� EasyMock ���� Mock ����
 * 2���趨 Mock �����Ԥ����Ϊ������򷵻�ֵ��
 * 3���� Mock �����л��� Replay ״̬��
 * 4������ Mock ���󷽷����е�Ԫ���ԣ�
 * 5���� Mock �������Ϊ������֤����ѡ����
 * 
 * ������SysparamconfServiceΪ����ģ��SysparamconfDao����
 * @author BruceQin
 */
public class Demo_testSysparamconfService extends TestCase{
	 /**
     * ����Mock����Ŀ�����IMocksControl�Ķ���
     * �ÿ�������������Ҫ�������Mock����ʱ��
     */
	private IMocksControl mocksControl;
	
	private SysparamconfDao MocksysparamconfDao;
	private SysparamconfService sysparamconfService;
	

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
		MocksysparamconfDao=mocksControl.createMock(SysparamconfDao.class);
	    sysparamconfService =new SysparamconfService();
	}

	@After
	public void tearDown() throws Exception {
		//���ڴ˴����ж���ȵ����ٲ���
	}

	/**
	 * Test method readSysparameter_NulltoInit(String, String)}.
	 */
	@Test
	public void testReadSysparameter_NulltoInit() {
		String pname1="testName",pname2=null,pvalue="testValue";
		/**
		 * ����Mock�������ΪԤ�ڵ�������߷���ֵ��
		 * times(count),count�ǵ��ô���
		 */
		EasyMock.expect(MocksysparamconfDao.readSysparameter_NulltoInit(pname1, pvalue)).andReturn(pvalue).times(1);
		EasyMock.expect(MocksysparamconfDao.readSysparameter_NulltoInit(pname2, pvalue)).andReturn("Sysparamconf����д�����ݿ�").times(1);
		
		/**
		 * ��Mock�����л��� Replay ״̬��������Mock����ʹ
		 * Mock �����ܹ������趨���ض��ķ�����������Ԥ�ڵ���Ӧ��
		 * �����ַ�����1��ֱ��ʹ��EasyMock������replay()��
		 *            2��ʹ�ÿ���������������replay()��
		 */
		// EasyMock.replay(MocksysparamconfDao);
		mocksControl.replay();
		
		System.out.println("message1: "+sysparamconfService.readSysparameter_NulltoInit(pname1, pvalue));
		System.out.println("message2: "+sysparamconfService.readSysparameter_NulltoInit(pname2, pvalue));	
		
		/**
		 * �˲���Ϊ��ѡ
		 * ����¼�ƺͻط������������֮�����Ԥ�ں�ʵ�ʽ���ļ�飬
		 * ����verify()������1��ֱ��ʹ��EasyMock������verify()��
		 *                  2��ʹ�ÿ���������������verify()��
		 */
		// EasyMock.verify(sysparamconfServiceMock);
		mocksControl.verify();
	}


}
