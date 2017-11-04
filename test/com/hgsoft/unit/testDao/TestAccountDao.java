package com.hgsoft.unit.testDao;

import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;

import com.hgsoft.dao.AccountDao;
import com.hgsoft.entity.Account;
import com.hgsoft.service.AccountService;
import com.hgsoft.util.JdbcUtil;
import com.hgsoft.util.Pager;

public class TestAccountDao extends AbstractDaoTransactionalTests{
	@Resource
	private AccountService accountService;
	@Autowired
	private AccountDao accountDao;
	@Resource
	private JdbcUtil jdbcUtil;
	@Override
	String[] getOtherConfigs() {
		return new String[] { applicationContextFile };
	}
	@Test
	@Rollback(true)
	public void testGetAccount() {//²âÊÔpublic Account getAccount(String cardNo) º¯Êý£¬×´Ì¬²»µÈÓÚ5
		String cardNo=jdbcUtil.selectForString("select CardNo from t_park_account where CardNo='123' and Status!=5");
		if(cardNo.equals("")){
			Account account = new Account();
			account.setStatus(5);
			account.setCardType(1);
			account.setParkNo(1);
			account.setLowestBalanceAfterConsume(0);
			account.setTollyLowestBalanceAC(0);
			account.setNoEntryBalance(0);
			account.setLowBalanceNotice(0);
			account.setCost(10);
			account.setBalance(0);
			account.setCardNo("123");
			Date date = new Date();
			account.setOpenAccountTime(date);
			account.setStatusUpdateTime(date);
			account.setRemark("chenfuyuanRemarkTest");
			accountService.save(account);
			Account accountTemp = new Account();
			accountTemp.setStatus(7);
			accountTemp.setCardType(1);
			accountTemp.setParkNo(1);
			accountTemp.setLowestBalanceAfterConsume(0);
			accountTemp.setTollyLowestBalanceAC(0);
			accountTemp.setNoEntryBalance(0);
			accountTemp.setLowBalanceNotice(0);
			accountTemp.setCost(10);
			accountTemp.setBalance(0);
			accountTemp.setCardNo("123");
			Date dateTemp = new Date();
			accountTemp.setOpenAccountTime(dateTemp);
			accountTemp.setStatusUpdateTime(dateTemp);
			accountTemp.setRemark("kdfjklda");
			accountService.save(accountTemp);
		    account=accountService.getAccount("123");
		    assertNotNull(account);
		    assertEquals("kdfjklda",account.getRemark());
		}else{
			Account  account=accountService.getAccount("123");
			 assertEquals(cardNo,account.getCardNo());
		}
		
		
	}
	@SuppressWarnings("unchecked")
	@Test
	@Rollback(true)
	public void testGetAccountByIdOrCardNo() {// ²âÊÔppublic List<Account> getAccountByIdOrCardNo(Integersys_id, String cardNo) º¯Êý
		List list = jdbcUtil.selectForList("select sys_id from t_park_account where CardNo = '25' or sys_id=11");
		if (list.isEmpty()) {
			Account account = new Account();
			account.setStatus(7);
			account.setCardType(1);
			account.setParkNo(1);
			account.setLowestBalanceAfterConsume(0);
			account.setTollyLowestBalanceAC(0);
			account.setNoEntryBalance(0);
			account.setLowBalanceNotice(0);
			account.setCost(10);
			account.setBalance(0);
			account.setCardNo("25");
			Date date = new Date();
			account.setOpenAccountTime(date);
			account.setStatusUpdateTime(date);
			account.setRemark("chenfuyuanRemarkTest");
			accountService.save(account);
			Account accountTemp = new Account();
			accountTemp.setStatus(7);
			accountTemp.setCardType(1);
			accountTemp.setParkNo(1);
			accountTemp.setLowestBalanceAfterConsume(0);
			accountTemp.setTollyLowestBalanceAC(0);
			accountTemp.setNoEntryBalance(0);
			accountTemp.setLowBalanceNotice(0);
			accountTemp.setCost(10);
			accountTemp.setBalance(0);
			accountTemp.setCardNo("25");
			Date dateTemp = new Date();
			accountTemp.setOpenAccountTime(dateTemp);
			accountTemp.setStatusUpdateTime(dateTemp);
			accountTemp.setRemark("kdfjklda");
			accountService.save(accountTemp);
			int size = accountDao.getAccountByIdOrCardNo(11, "25").size();
			assertEquals(2, size);
			account = (Account) accountDao.getAccountByIdOrCardNo(11, "25").get(0);
			String remark = account.getRemark();
			assertEquals("chenfuyuanRemarkTest", remark);
		} else {
			int size = accountDao.getAccountByIdOrCardNo(11, "25").size();
			int sizeList = list.size();
			System.out.println("testGetAccountByIdOrCardNo-----size------------:"+size);
			System.out.println("testGetAccountByIdOrCardNo-----sizeList------------:"+sizeList);
			assertEquals(size, sizeList);
			Account account=(Account)accountDao.getAccountByIdOrCardNo(11, "25").get(0);
			Iterator it = list.iterator();
			
		  // while(it.hasNext()) {
				Map obj = (Map)it.next();
				int sys_id = (Integer) obj.get("sys_id");
			//}

			//Account accountTemp=(Account)list.get(0);
			
			int sys_idTemp=account.getSys_id();
			System.out.println("testGetAccountByIdOrCardNo-----sys_idTemp------------:"+sys_idTemp);
			System.out.println("testGetAccountByIdOrCardNo-----sys_id------------:"+sys_id);
			assertEquals(sys_idTemp, sys_id);

		}

	}
	
	@SuppressWarnings("unchecked")
	@Test
	@Rollback(true)
	public void testFindAllItemByHql() {
		//System.out.println("test AccountDao_testFindAllItemByHql...");
		Pager pager = new Pager();
		pager.setPageSize("15");
		List list = jdbcUtil.selectForList("select top 15 * from t_park_account where CardNo like '%cardNo%'");
		if (list.isEmpty()) {
			Account account = new Account();
			account.setStatus(7);
			account.setCardType(1);
			account.setParkNo(1);
			account.setLowestBalanceAfterConsume(0);
			account.setTollyLowestBalanceAC(0);
			account.setNoEntryBalance(0);
			account.setLowBalanceNotice(0);
			account.setCost(10);
			account.setBalance(0);
			account.setCardNo("cardNo");
			Date date = new Date();
			account.setOpenAccountTime(date);
			account.setStatusUpdateTime(date);
			account.setRemark("chenfuyuanRemarkTest");
			accountService.save(account);
			Account accountTemp = new Account();
			accountTemp.setStatus(7);
			accountTemp.setCardType(1);
			accountTemp.setParkNo(1);
			accountTemp.setLowestBalanceAfterConsume(0);
			accountTemp.setTollyLowestBalanceAC(0);
			accountTemp.setNoEntryBalance(0);
			accountTemp.setLowBalanceNotice(0);
			accountTemp.setCost(10);
			accountTemp.setBalance(0);
			accountTemp.setCardNo("cardNo");
			Date dateTemp = new Date();
			accountTemp.setOpenAccountTime(dateTemp);
			accountTemp.setStatusUpdateTime(dateTemp);
			accountTemp.setRemark("kdfjklda");
			accountService.save(accountTemp);
			//int size = accountDao.findAllItemByHql(pager, null, "cardNo", "", null, "", "", null).size();
			//assertEquals(2, size);
			//account = (Account) accountDao.findAllItemByHql(pager, null, "cardNo", "", null, "", "", null).get(0);
			String remark = account.getRemark();
			assertEquals("chenfuyuanRemarkTest", remark);
		} else {
			//int size = accountDao.findAllItemByHql(pager, null, "cardNo", "", null, "", "", null).size();
			int sizeList=list.size();
			//System.out.println("testFindAllItemByHql----size------------:"+size);
			System.out.println("testFindAllItemByHql----sizeList------------:"+sizeList);
			//assertEquals(size,sizeList);

		}
	}

}
