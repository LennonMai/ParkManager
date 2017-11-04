/**
*CopyRight (c) 曾根宝 (kevin)  广州华工信息软件有限公司 http://www.hgsoft.com.cn
*Email:rabitt450@163.com
*转载请注明版权所有
*/
package com.hgsoft.unit.testDao;

import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;

import com.hgsoft.dao.CardDynamicDao;
import com.hgsoft.dao.SecurityCommandDao;
import com.hgsoft.entity.AllOutList;
import com.hgsoft.entity.SecurityCommand;
import com.hgsoft.util.Pager;

public class TestCardDynamycDao extends AbstractDaoTransactionalTests {

	@Autowired
	private CardDynamicDao dao;
	
	/**
	 * 根据卡表面号来获得未回收临时卡信息
	 */
	@Test
	@Rollback
	public void testGetByCardNo(){
		Object obj = dao.getByCardNo("111111");
		assertNull("obj对象不为空！",obj);
	}
	/**
	 * 根据流水号来获得入口流水视图信息
	 */
	@Test
	@Rollback
	public void testGetByListNo(){
		Object obj = dao.getByListNo("123456789");
		assertNull("obj对象不为空！",obj);
	}
	
	/**
	 * 根据流水号来获得出口流水视图信息
	 */
	@Test
	@Rollback
	public void testGetByOutListNo(){
		//Object outList = dao.getByOutListNo("123456789546546");
		//assertNull("outList对象不为空！",outList);	
	}
	/**
	 * 获得出口数据
	 */
	@Test
	@Rollback
	public void testQueryByOpTimeAndVehPlate(){
		List list = dao.queryByOpTimeAndVehPlate(new Date(), "1", "50", "粤123456");
		assertNotNull("list对象为空！",list);
		assertEquals(0,list.size());
	}
	/**
	 *  查询未回收零时卡
	 */
	@Test
	@Rollback
	public void testQueryCardDynamic(){
		List list = dao.queryCardDynamic(new Pager(), null, null, null, null, null);
		assertNotNull("list数组为空！",list);
		System.out.println(list.size());
	}
	
	/**
	 *  获得流水查询
	 */
	@Test
	@Rollback
	public void testWatetQuery(){
		//List list = dao.waterQuery(new Pager(), null, null, null, "1", null, null, null, null, null, null, null, null, 
		//		null, null, null, null, "1", null, null, null, "1");
		//assertNotNull("list数组为空！",list);

		
	}
	
	@Override
	String[] getOtherConfigs() {
		return new String[]{applicationContextFile};
		
	}

}
