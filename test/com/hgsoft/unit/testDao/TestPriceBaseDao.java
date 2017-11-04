package com.hgsoft.unit.testDao;

import javax.annotation.Resource;

import org.junit.Test;
import com.hgsoft.dao.PriceBaseDao;


public class TestPriceBaseDao extends AbstractDaoTransactionalTests{
	@Resource
	private PriceBaseDao priceBaseDao;

	@Test
	public void testFindMaxFeeNo() {
		System.out.println(priceBaseDao.findMaxFeeNo());;
	}


	
	@Override
	String[] getOtherConfigs() {
		// TODO Auto-generated method stub
		return new String[]{applicationContextFile};
	}

}
