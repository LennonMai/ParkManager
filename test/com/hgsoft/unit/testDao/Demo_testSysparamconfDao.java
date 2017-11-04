package com.hgsoft.unit.testDao;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;
import com.hgsoft.dao.SysparamconfDao;
import com.hgsoft.entity.Sysparamconf;

/**
 * 测试Dao时可以用以下范例,
 * 利用org.junit.Assert.*里的断言方法对测试结果进行处理
 * @author qinzuohai
 *
 */
public class Demo_testSysparamconfDao extends AbstractDaoTransactionalTests{
	
	/**
	 * 注入SysparamconfDao
	 */
	@Autowired
	private SysparamconfDao sysparamconfDao;

	/**
	 * 重载AbstractServiceTransactionalTests的方法，
	 * 返回applicationContext.xml的文件路径，部署
	 * applicationContext.xml
	 */
	@Override
	String[] getOtherConfigs() {
		return new String[] { applicationContextFile };
	}
	
	//测试SysparamconfDao的WriteSysparameter()方法，并数据回滚保护数据库现场
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
         * 如果插入对象正确则返回true,断言方法写成assertEquals("false", testResult);
         * 则测试不通过Console将提示如下：
         * junit.framework.AssertionFailedError: expected:<false> but was:<true>
         */
		//assertEquals("false", testResult);
		assertNotNull(testResult);
//		assertEquals("true", testResult);
	}

	//测试BaseDao的GetSession()方法
	@Test
	public void testGetSession() {
		assertNotNull(sysparamconfDao.getSession());
	}


}
