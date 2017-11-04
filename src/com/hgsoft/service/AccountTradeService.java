package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.AccountTradeDao;
import com.hgsoft.entity.AccountTrade;
import com.hgsoft.util.Pager;

@Service
public class AccountTradeService extends BaseService<AccountTrade> {

	private AccountTrade accountTrade;

	@Autowired
	public void setDao(@Qualifier("accountTradeDao") AccountTradeDao dao) {
		super.setDao(dao);
	}

	private AccountTradeDao getAccountTradeDao() {
		return (AccountTradeDao) this.getDao();
	}

	public AccountTradeService() {

	}

	public int getSeqNoByTwelveAccountTrade(int month, int accountNo) {
		return getAccountTradeDao().getSeqNoByTwelveAccountTrade(month, accountNo);
	}

	public int updateBackoutedMark(int month, String listNo) {
		return getAccountTradeDao().updateBackoutedMark(month, listNo);
	}

	@SuppressWarnings("unchecked")
	public List getAccountTradeByMonthAndListNo(int month, String listNo) {
		return getAccountTradeDao().getAccountTradeByMonthAndListNo(month, listNo);
	}

	@SuppressWarnings("unchecked")
	public List findAllItemBySql(Pager pager, Integer sys_id, String cardNo, String userName, Integer tradeType,
			String credentialsNo, String vehPlate, Integer status, String startTime, String endTime, int sign) {
		return getAccountTradeDao().findAllItemBySql(pager, sys_id, cardNo, userName, tradeType, credentialsNo,
				vehPlate, status, startTime, endTime, sign);
	}

	@SuppressWarnings("unchecked")
	public List findAllUnusualAccountTradeBySql(Pager pager, Integer sys_id, String cardNo, String userName,
			Integer tradeType, String credentialsNo, String vehPlate, Integer status, String startTime,
			String endTime) {
		return getAccountTradeDao().findAllUnusualAccountTradeBySql(pager, sys_id, cardNo, userName, tradeType,
				credentialsNo, vehPlate, status, startTime, endTime);
	}

	@SuppressWarnings("unchecked")
	public List findVerifyAccountTrade(Pager pager, String keyMD5, String startTime, String endTime, String userName,
			String cardNo, String vehPlate, Integer tradeType, String validateCheck) {
		return getAccountTradeDao().findVerifyAccountTrade(pager, keyMD5, startTime, endTime, userName, cardNo,
				vehPlate, tradeType, validateCheck);
	}

	/*
	 * public List<AccountTrade> findAllItemByHql(Pager pager, Integer
	 * sys_id,String cardNo, String userName, Integer tradeType,String
	 * credentialsNo, String vehPlate,Integer status) { return
	 * ((AccountTradeDao) getDao()).findAllItemByHql(pager, sys_id,cardNo,
	 * userName, tradeType, credentialsNo, vehPlate,status); } public
	 * List<AccountTrade> findAllItemByHql3(Pager pager,Integer sys_id,String
	 * cardNo,String userName,Integer tradeType,String credentialsNo,String
	 * vehPlate,Integer status){ return ((AccountTradeDao)
	 * getDao()).findAllItemByHql3(pager, sys_id, cardNo, userName, tradeType,
	 * credentialsNo, vehPlate, status); } public List<AccountTrade>
	 * findAllItemByHql4(Pager pager){ return ((AccountTradeDao)
	 * getDao()).findAllItemByHql4(pager); } public List<AccountTrade>
	 * findAllItemByHqlAndTime(Pager pager,Integer sys_id,String cardNo,String
	 * userName,Integer tradeType,String credentialsNo,String vehPlate,Integer
	 * status,String startTime1,String endTime1){ return ((AccountTradeDao)
	 * getDao()).findAllItemByHqlAndTime(pager, sys_id, cardNo, userName,
	 * tradeType, credentialsNo, vehPlate, status, startTime1, endTime1); }
	 * public List<Object[]> findAllItemByHql1(Pager pager,Integer sys_id,String
	 * cardNo,String userName,Integer tradeType,String vehPlate,String
	 * credentialsNo,Integer status){ return ((AccountTradeDao)
	 * getDao()).findAllItemByHql1(pager, sys_id, cardNo, userName, tradeType,
	 * vehPlate, credentialsNo,status); } public List<Object[]>
	 * findAllItemByHql2(Pager pager,Integer sys_id,String cardNo,String
	 * userName,Integer tradeType,String vehPlate,String credentialsNo,Integer
	 * status){ return ((AccountTradeDao) getDao()).findAllItemByHql2(pager,
	 * sys_id, cardNo, userName, tradeType, vehPlate, credentialsNo,status); }
	 */
	public String deleteNull(Integer sys_id, Integer seqNo, Integer tradeType, Integer fee, Integer balance,
			String cardNo, Integer cardType, String vehPlate, String listNo, Integer operatorId, String possword,
			String tradeTime, String opTime) {
		return getAccountTradeDao().deleteNull(sys_id, seqNo, tradeType, fee, balance, cardNo, cardType, vehPlate,
				listNo, operatorId, possword, tradeTime, opTime);
	}

	public AccountTrade getAccountTradeByAccountNoOrder(int accountNo) {
		return getAccountTradeDao().getAccountTradeByAccountNoOrder(accountNo);
	}
	/*
	 * public AccountTrade getAccountTradeByAccountNoOrderAndTradeType(int
	 * accountNo) { return
	 * getAccountTradeDao().getAccountTradeByAccountNoOrderAndTradeType(
	 * accountNo); }
	 * 
	 * public AccountTrade getAccountTradeByAccountNoAndSeqNo(int accountNo, int
	 * seqNo) { return getAccountTradeDao().getAccountTradeByAccountNoAndSeqNo(
	 * accountNo, seqNo); }
	 */

	public AccountTrade getAccountTradeByAccountNoAndTradeType(int accountNo, int tradeType) {
		return getAccountTradeDao().getAccountTradeByAccountNoAndTradeType(accountNo, tradeType);
	}

	/*
	 * public String getTradeListNo(Integer accountNo,Date opTime) {
	 * SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss"); String
	 * nowdate = sdf.format(new Date()); String s1 = getNo(accountNo,opTime);
	 * String nowdate2 = "T" + nowdate + s1; return nowdate2; }
	 * 
	 * public String getMaxTradeTime(Integer accountNo){ return
	 * getAccountTradeDao().getMaxTradeTime(accountNo); }
	 * 
	 * public AccountTrade getAccountTradeByAccountNoAndTradeTime(int
	 * accountNo,String tradeTime ) { return
	 * getAccountTradeDao().getAccountTradeByAccountNoAndTradeTime(accountNo,
	 * tradeTime); }
	 */
	/*
	 * public String getNo(Integer accountNo,Date opTime) { String No = "001";
	 * Calendar calendar=Calendar.getInstance(); calendar.setTime(opTime); int
	 * month=calendar.get(Calendar.MONTH)+1;
	 * System.out.println("-------------------month-------"+month); String
	 * s=getAccountTradeDao().getListNoByTwelveAccountTrade(month, accountNo);
	 * System.out.println("------------------slistNo---------"+s);
	 * if("".equals(s)) { No="001"; } else{ String s1 = s.substring(15, 18);
	 * Long a = Long.parseLong(s1) + 1; if (a >= 1 && a <= 9) { No = "00" +
	 * a.toString(); } if (a >= 10 && a <= 99) { No = "0" + a.toString(); } if
	 * (a >= 100 && a <= 999) { No = a.toString(); } if (a == 999) { No = "001";
	 * }
	 * 
	 * } return No; }
	 */

	public AccountTrade getAccountTrade() {
		return accountTrade;
	}

	public void setAccountTrade(AccountTrade accountTrade) {
		this.accountTrade = accountTrade;
	}
}
