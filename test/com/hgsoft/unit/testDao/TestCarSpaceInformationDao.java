package com.hgsoft.unit.testDao;


import org.junit.Test;

import com.hgsoft.dao.CarSpaceInformationDao;

public class TestCarSpaceInformationDao extends AbstractDaoTransactionalTests{

   private CarSpaceInformationDao carSpaceInformationDao;

	@Test
	public void testIshascarSpace() {
		short parkNo=101;
		System.out.println("test :"+carSpaceInformationDao.ishascarSpace(parkNo));
	
	}

	@Override
	String[] getOtherConfigs() {
		return new String[]{applicationContextFile};
	}

}
