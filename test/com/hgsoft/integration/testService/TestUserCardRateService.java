/**
 * 
 */
package com.hgsoft.integration.testService;

import javax.annotation.Resource;

import org.junit.Test;

import com.hgsoft.service.UserCardRateService;
import com.hgsoft.util.Pager;

/**
 * @author qinzuohai
 *
 */
public class TestUserCardRateService extends AbstractServiceTransactionalTests{

	@Resource
	private UserCardRateService userCardRateService;


	@Test
	public void testFindByPager() {
		Pager pager=new Pager();
		pager.setTotalSize((short)20);
		assertNotNull(userCardRateService.findByPager(pager));
		System.out.println(userCardRateService.findByPager(pager).size());
	}

	@Override
	String[] getOtherConfigs() {
		// TODO Auto-generated method stub
		return new String[]{applicationContextFile};
	}
}
