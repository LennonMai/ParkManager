package com.hgsoft.integration.testService;

import static org.junit.Assert.*;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.hgsoft.service.ParkInformationService;
import com.hgsoft.util.Pager;

public class TestParkInformationService extends AbstractServiceTransactionalTests{


	@Autowired ParkInformationService parkInformationService;
	@Test
	public void testFindAllPager() {
		Pager pager=new Pager();
		pager.setPageSize("15");
//		parkInformationService.findAll(pager);
	}

	@Override
	String[] getOtherConfigs() {
		// TODO Auto-generated method stub
		return new String[]{applicationContextFile};
	}

}
