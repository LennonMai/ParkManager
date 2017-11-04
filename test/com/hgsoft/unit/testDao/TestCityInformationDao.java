package com.hgsoft.unit.testDao;

import static org.junit.Assert.*;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.hgsoft.dao.CityInformationDao;

public class TestCityInformationDao extends AbstractDaoTransactionalTests{

	@Autowired
	private CityInformationDao cityInformationDao;

	@Test
	public void testIshasCityNo() {
		short cityNo=20;
		cityInformationDao.ishasCityNo(cityNo);;
	}

	@Override
	String[] getOtherConfigs() {
		// TODO Auto-generated method stub
		return new String[]{applicationContextFile};
	}

}
