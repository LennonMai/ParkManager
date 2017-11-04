package com.hgsoft.integration.testService;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.hgsoft.service.HandInMoneyService;
import com.hgsoft.util.Pager;

public class TestHandInMoneyService extends AbstractServiceTransactionalTests{

	@Autowired
	private HandInMoneyService handInMoneyService;
	
	@SuppressWarnings("unchecked")
	@Test
	public void testFindAllHandInMoneyByHql() {
		List list = handInMoneyService.findAllHandInMoneyByHql(new Pager(), null, null, null, null);
		assertNotNull("list数组为空" ,list);
		System.out.println("FindAllHandInMoneyByHql_list:"+list.size());
	}
	
	@SuppressWarnings({ "unchecked", "unchecked" })
	@Test
	public void testLoadHandInMoney() {
		List list = handInMoneyService.loadHandInMoney(null, null, null, null, null, null);
		assertNull("list数组不为空", list);
//		System.out.println("LoadHandInMoney_list:"+list.size());
		
		SimpleDateFormat formate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date squadDate = null;
		try {
			Date temp = formate.parse("2009-06-03 00:00:00");
			String sTemp = formate.format(temp);
			squadDate = formate.parse(sTemp);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		@SuppressWarnings("unused")
		List list1 = handInMoneyService.loadHandInMoney(Short.parseShort("4430"), Short.parseShort("101"),
				Short.parseShort("60"), Short.parseShort("62"), squadDate, Short.parseShort("1"));
		assertNull("list数组不为空", list);
	}
	
	@Test
	public void testDeleteHandInMoney() {
		Boolean test = handInMoneyService.deleteHandInMoney(null, null, null, null, null, null);
		assertFalse("删除对象存在", test);
	}
	
	
	@Override
	String[] getOtherConfigs() {
		return new String[] {applicationContextFile};
	}
	
}
