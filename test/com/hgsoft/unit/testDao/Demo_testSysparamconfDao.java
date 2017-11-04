package com.hgsoft.unit.testDao;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;
import com.hgsoft.dao.SysparamconfDao;
import com.hgsoft.entity.Sysparamconf;

/**
 * ����Daoʱ���������·���,
 * ����org.junit.Assert.*��Ķ��Է����Բ��Խ�����д���
 * @author qinzuohai
 *
 */
public class Demo_testSysparamconfDao extends AbstractDaoTransactionalTests{
	
	/**
	 * ע��SysparamconfDao
	 */
	@Autowired
	private SysparamconfDao sysparamconfDao;

	/**
	 * ����AbstractServiceTransactionalTests�ķ�����
	 * ����applicationContext.xml���ļ�·��������
	 * applicationContext.xml
	 */
	@Override
	String[] getOtherConfigs() {
		return new String[] { applicationContextFile };
	}
	
	//����SysparamconfDao��WriteSysparameter()�����������ݻع��������ݿ��ֳ�
	@Test
	@Rollback(true)
	public void testWriteSysparameter() {
		
		boolean testResult;
		Sysparamconf sysparamconf = new Sysparamconf();
		sysparamconf.setPname("testName2");
		sysparamconf.setPtype(1);
		sysparamconf.setPvalue("testName2_value2");
		testResult = sysparamconfDao.writeSysparameter(sysparamconf);
        /**
         * ������������ȷ�򷵻�true,���Է���д��assertEquals("false", testResult);
         * ����Բ�ͨ��Console����ʾ���£�
         * junit.framework.AssertionFailedError: expected:<false> but was:<true>
         */
		//assertEquals("false", testResult);
		assertNotNull(testResult);
//		assertEquals("true", testResult);
	}

	//����BaseDao��GetSession()����
	@Test
	public void testGetSession() {
		assertNotNull(sysparamconfDao.getSession());
	}


}
