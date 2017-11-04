package com.hgsoft.integration.testService;

import javax.annotation.Resource;

import org.junit.Test;

import com.hgsoft.service.PriceRuleService;
import com.hgsoft.util.Pager;

public class TestPriceRuleService extends AbstractServiceTransactionalTests{

	@Resource
	private PriceRuleService priceRuleService;


	@Test
	public void testFindByPager() {
		Pager pager=new Pager();
		pager.setTotalSize((short)20);
		assertNotNull(priceRuleService.findByPager(pager));
		System.out.println(priceRuleService.findByPager(pager).size());
	}

	@Override
	String[] getOtherConfigs() {
		// TODO Auto-generated method stub
		return new String[]{applicationContextFile};
	}

}
