package com.hgsoft.integration.testService;

import javax.annotation.Resource;

import org.junit.Test;

import com.hgsoft.service.PriceBaseService;



public class TestPriceBaseService extends AbstractServiceTransactionalTests{

	@Resource
	private PriceBaseService priceBaseService;


	@Test
	public void testfindMaxfeeNo() {
	
		System.out.println(priceBaseService.findMaxFeeNo());
	}

	@Override
	String[] getOtherConfigs() {
		// TODO Auto-generated method stub
		return new String[]{applicationContextFile};
	}
}
