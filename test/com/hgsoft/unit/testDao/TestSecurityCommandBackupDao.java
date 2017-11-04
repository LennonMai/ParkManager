package com.hgsoft.unit.testDao;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;

import com.hgsoft.dao.SecurityCommandBackupDao;
import com.hgsoft.util.Pager;



public class TestSecurityCommandBackupDao extends AbstractDaoTransactionalTests{
	
	@Autowired
	SecurityCommandBackupDao securityCommandBackupDao;
	
	/**
	 * 分页查询
	 */
	@Test
	@Rollback
	public void testQuery(){
		List list  = securityCommandBackupDao.query(new Pager(), null, null, null, null, null);
		assertNotNull(list);
		System.out.println("findPaperByHql size:" +list.size());
	}
	
	/**
	 * 获得一条命令备份的条数(String)
	 */
	@Test
	@Rollback
	public void testGetCount(){
		String commandId = "0";
		Long count = securityCommandBackupDao.getCount(commandId);
		assertNotNull("count数据对象为空！",count);
		
		assertEquals(0,count.intValue());
	}
	
	/**
	 * 显示某条命令备份的次数（String,String,String）
	 */
	@Test
	@Rollback
	public void testShow(){
		List list = securityCommandBackupDao.show(new Pager(), "0", "1");
		assertNotNull("list数据对象为空！",list);
		
		assertEquals(0, list.size());
	}
	
	@Override
	String[] getOtherConfigs() {
		// TODO Auto-generated method stub
		return new String[]{applicationContextFile};
		
	}
}
