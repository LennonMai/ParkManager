package com.hgsoft.unit.testDao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;

import com.hgsoft.dao.HandInMoneyDao;
import com.hgsoft.entity.HandInMoney;
import com.hgsoft.util.Pager;


public class TestHandInMoneyDao extends AbstractDaoTransactionalTests {
	@Autowired
	private HandInMoneyDao handInMoneyDao;
	
	private HandInMoney handInMoney;
	
	Date d;
	
	@Test
	@Rollback
	public void onSetUpBeforeTransaction() {
		handInMoney = new HandInMoney();
		handInMoney.setAreaNo((short)4430);
		handInMoney.setParkNo((short)101);
		handInMoney.setGateNo((short)1);
		handInMoney.setLaneNo((short)1);
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd"); 
		try {
			d = format.parse("2011-06-01");
		} catch (ParseException e) {
			e.printStackTrace();
		}
		handInMoney.setSquadDate(d);
		handInMoney.setSquadNo((short)1);
		handInMoney.setMoney(100.0);
		handInMoney.setHandInMoney(100.0);
		handInMoney.setMoneyTypeNo((short)1);
		handInMoney.setLaneOperatorNo(2001);
		handInMoney.setOperatorName("陈金贵");
		handInMoney.setOpTime(d);
	}
	
	@SuppressWarnings("unchecked")
	@Test
	@Rollback
	public void testFindAllHandInMoneyByHql() {
		List list = handInMoneyDao.findAllHandInMoneyByHql(new Pager(), null, null, null, null);
		assertNotNull("list数组为空" ,list);
		System.out.println("FindAllHandInMoneyByHql_list:"+list.size());
	}
	
	@SuppressWarnings({ "unchecked", "unchecked" })
	@Test
	@Rollback
	public void testLoadHandInMoney() {
		List list = handInMoneyDao.loadHandInMoney(null, null, null, null, null, null);
		assertNull("list数组不为空", list);
		
		if(null == handInMoneyDao.loadHandInMoney((short)4430, (short)101, (short)1, (short)1, d, (short)1)) {
			handInMoneyDao.save(handInMoney);
		}
		
		List list1 = handInMoneyDao.loadHandInMoney((short)4430, (short)101, (short)1, (short)1, d, (short)1);
		assertNotNull("list数组为空", list1);
	}
	
	@Test
	@Rollback
	public void testDeleteHandInMoney() {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd"); 
		try {
			d = format.parse("2011-06-01");
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		if(null == handInMoneyDao.loadHandInMoney((short)4430, (short)101, (short)1, (short)1, d, (short)1)) {
			handInMoneyDao.save(handInMoney);
		}
		
		Boolean test1 = handInMoneyDao.deleteHandInMoney((short)4430, (short)101, (short)1, (short)1, d, (short)1);
		assertTrue("删除对象不成功", test1);
		
		Boolean test2 = handInMoneyDao.deleteHandInMoney(null, null, null, null, null, null);
		assertFalse("删除对象存在", test2);
	}

	@Override
	String[] getOtherConfigs() {
		return new String[]{applicationContextFile};
	}

}
