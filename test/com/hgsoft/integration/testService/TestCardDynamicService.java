package com.hgsoft.integration.testService;
import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;

import com.hgsoft.entity.CardDynamic;
import com.hgsoft.service.CardDynamicService;
import com.hgsoft.util.Pager;



public class TestCardDynamicService extends AbstractServiceTransactionalTests{

	@Autowired
	private CardDynamicService service;
	
	/**
	 * 查询未回收零时卡
	 */
	@Test
	@Rollback
	public void testQueryCardDynamic(){
		List list = service.queryCardDynamic(new Pager(), null, null, null, null, null);
		assertNotNull("list对象为空！",list);
		assertEquals(15,list.size());
	}
	/**
	 * 根据流水号来获得入口流水视图信息 string listNo
	 */
	@Test
	@Rollback
	public void testGetByListNo(){
		Object obj = service.getByListNo("65010B4B3C83A100");
		assertNotNull("obj对象为空！",obj);
	}
	/**
	 * 根据流水号来获得出口流水视图信息 string listNo 
	 */
	@Test
	@Rollback
	public void testGetByOutListNo(){
		//Object obj = service.getByOutListNo("6501104B3C839700");
		//assertNotNull("obj对象为空！",obj);
	}
	/**
	 * 根据卡表面号来获得未回收临时卡信息 string cardNo
	 */
	@Test
	@Rollback
	public void testGetByCardNo(){
		CardDynamic cardDynamic = service.getByCardNo("152169427");
		assertNotNull("cardDynamic对象为空！",cardDynamic);
	}
	/**
	 * 更新（用对象）CardDynamic cardDynamic
	 */
	@Test
	@Rollback
	public void testUpdate(){
		CardDynamic cardDynamic = service.getByCardNo("152169427");
		assertNotNull("cardDynamic对象为空！",cardDynamic);
		service.update(cardDynamic);
	}
	
	/**
	 * 获得出口数据
	 */
	@Test
	@Rollback
	public void testQueryByOpTimeAndVehPlate(){
		List list = service.queryByOpTimeAndVehPlate(new Date(), "5", "50", "粤1233");
		assertNotNull("list对象为空！",list);
		assertEquals(0,list.size());
	}
	
	/**
	 * 查询流水信息
	 */
	@Test
	@Rollback
	public void testWaterQuery(){
		/*List list = service.waterQuery(new Pager(), null, null, null, "1", null, null, null, null, null, null, null, null, null, null, null, null, "1", null, null, null);
		assertNotNull("list对象为空！",list);
		assertEquals(15,list.size());*/
	}
	
	
	@Override
	String[] getOtherConfigs() {
		// TODO Auto-generated method stub
		return new String[]{applicationContextFile};
	}

}
