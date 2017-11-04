package com.hgsoft.unit.testDao;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;

import com.hgsoft.dao.ParkInformationDao;

public class TestParkInformationDao extends AbstractDaoTransactionalTests{

	@Autowired
    private ParkInformationDao parkInformationDao;
	
	//≤‚ ‘∏˘æ›parkNoº”‘ÿParkInformation
	@Test
	public void testLoadParkInfo() {
		short parkNo=101;
		assertNotNull(parkInformationDao.LoadParkInfo(parkNo));
	}
	
	@Test
	@Rollback(true)
	public void testDeleteByparkNo(){
		short parkNo=222;
		assertTrue(parkInformationDao.deleteByparkNo(parkNo));
	}		
		
		
	@Override
	String[] getOtherConfigs() {
		// TODO Auto-generated method stub
		return new String[]{applicationContextFile};
	}

}
