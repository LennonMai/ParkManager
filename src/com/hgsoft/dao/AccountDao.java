package com.hgsoft.dao;

import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Repository;
import com.hgsoft.entity.Account;
import com.hgsoft.entity.AccountTrade;
import com.hgsoft.entity.Car;
import com.hgsoft.util.Pager;

@Repository
public class AccountDao extends BaseDao<Account> {
	private AccountTrade accountTrade;
	private Account account;	

	@SuppressWarnings("unchecked")
	public Account getAccount(String cardNo) {// 通过卡号查询账户
		account = null;
		String hql = "from Account account where  account.cardNo=?";
		List resultList = executeQuery(hql, cardNo);
		if (resultList.isEmpty())
			return null;
		else {
			for (int i = 0; i < resultList.size(); i++) {
				Account accountTemp = (Account) resultList.get(i);
				if (accountTemp.getStatus() != 5) {
					account = accountTemp;
					break;
				}
			}

		}
		return account;
	}
	@SuppressWarnings("unchecked")
	public Account getAccountByVehPlateToAjax(String vehPlate) {// 通过卡号查询账户
		account = null;
		String hql = "from Account account where  account.car.vehPlate=?";
		List resultList = executeQuery(hql, vehPlate);
		if (resultList.isEmpty())
			return null;
		else {
			for (int i = 0; i < resultList.size(); i++) {
				Account accountTemp = (Account) resultList.get(i);
				if (accountTemp.getStatus() != 5) {
					account = accountTemp;
					break;
				}
			}

		}
		return account;
	}
	@SuppressWarnings("unchecked")
	public Account getAccountBySysID(int sys_id) {// 通过账号查询账户
		account = null;
		String hql = "from Account account where  account.sys_id=?";
		List resultList = executeQuery(hql, sys_id);
		if (resultList.isEmpty())
			return null;
		else
			return (Account)resultList.get(0);
	}
		

	@SuppressWarnings("unchecked")
	public List<Account> getAccountByIdOrCardNo(Integer sys_id, String cardNo) {// 通过账号和卡号查询账户
		String hql = "from Account account where account.sys_id=? or account.cardNo=?";
		List resultList = executeQuery(hql, sys_id, cardNo);
		if (resultList.isEmpty())
			return null;
		else
			return resultList;
	}
	
	@SuppressWarnings("unchecked")
	public Account getAccountByUserID(Integer user_id) {// 通过用户编号查询账户
		String hql = "from Account account where account.user.sys_id=?";
		List resultList = executeQuery(hql, user_id);
		if (resultList.isEmpty())
			return null;
		else
			return (Account)resultList.get(0);
	}

	@SuppressWarnings("unchecked")
	public List<Account> getAccountByVehPlate(String vehPlate) {// 通过车牌好查询账户
		String hql = "from Car car where  car.vehPlate=?";
		List resultList = executeQuery(hql, vehPlate);
		if (resultList.isEmpty())
			return null;
		Car car = (Car) resultList.get(0);
		String hql1 = "from Account account where  account.car.sys_id=?";
		List resultList1 = executeQuery(hql1, car.getSys_id());
		if (resultList1.isEmpty())
			return null;
		else
			return resultList1;

	}

	@SuppressWarnings("unchecked")
	public List<Account> findAllItemByHql(Pager pager, Integer sys_id, String cardNo, String userName, Integer credentialsType, String credentialsNo, String vehPlate, Integer status, Integer parkNo) {

		StringBuffer sf = new StringBuffer("from Account account where");// 查询，多条件查询，先判断是不是空，为空时不加入查询条件，否则添加
		List<Object> obj = new ArrayList<Object>();
		if (sys_id != null) {
			sf.append(" account.sys_id =? and");

			obj.add(sys_id);

		}
		if (!"".equals(cardNo)) {

			sf.append(" account.cardNo like? and");
			obj.add("%" + cardNo + "%");
		}

		if (!"".equals(userName)) {
			sf.append(" account.user.userName like ? and");
			obj.add("%" + userName + "%");

		}
		if (credentialsType != null) {
			sf.append(" account.user.credentialsType=? and");
			obj.add(credentialsType);
		}
		if (!"".equals(credentialsNo)) {
			sf.append(" account.user.credentialsNo like? and");
			obj.add("%" + credentialsNo + "%");
		}

		if (!"".equals(vehPlate)) {
			sf.append(" account.car.vehPlate like? and");
			obj.add("%" + vehPlate + "%");
		}
		if (status != null) {
			sf.append(" account.status =? and");
			obj.add(status);
		}
		if (parkNo != null) {
			sf.append(" account.parkNo =? and");
			obj.add(parkNo);
		}
		sf = sf.replace(sf.length() - 4, sf.length(), "");
		// 查出总行数，对分页进行设置
		//System.out.println(sf.toString()+"obj"+obj.get(0));
		//System.out.println(sf.toString()+" order by openAccountTime desc");
		Long count = executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);

		return this.executeQuery(pager, sf.toString()+" order by openAccountTime desc", obj.toArray());
	}
/*
	
	@SuppressWarnings("unchecked")
	public List<Object[]> findAllItemByHql1(Pager pager, Integer sys_id, String cardNo, String userName, Integer credentialsType, String credentialsNo, String vehPlate, Integer status) {
		List myList = new ArrayList();

		// StringBuffer sf = new
		// StringBuffer("from Account account where");//查询，多条件查询，先判断是不是空，为空时不加入查询条件，否则添加
		StringBuffer sf = new StringBuffer(" from AccountTrade accountTrade,Account account where"); 
		List<Object> obj = new ArrayList<Object>();
		if (sys_id != null) {
			sf.append(" account.sys_id =? and");

			obj.add(sys_id);

		}
		if (!"".equals(cardNo)) {

			sf.append(" account.cardNo like? and");
			obj.add("%" + cardNo + "%");
		}

		if (!"".equals(userName)) {
			sf.append(" account.user.userName like ? and");
			obj.add("%" + userName + "%");

		}
		if (credentialsType != null) {
			sf.append(" account.user.credentialsType=? and");
			obj.add(credentialsType);
		}
		if (!"".equals(credentialsNo)) {
			sf.append(" account.user.credentialsNo like? and");
			obj.add("%" + credentialsNo + "%");
		}

		if (!"".equals(vehPlate)) {
			sf.append(" account.car.vehPlate like? and");
			obj.add("%" + vehPlate + "%");
		}
		if (status != null) {
			sf.append(" account.status =? and");
			obj.add(status);
		}
		// sf = sf.replace(sf.length() - 4, sf.length(), "");

		sf.append(" accountTrade.account.sys_id=account.sys_id and accountTrade.seqNo = (select max(accountTrade1.seqNo) from AccountTrade accountTrade1 where accountTrade1.account.sys_id=account.sys_id group by accountTrade1.account.sys_id) ");

		// 查出总行数，对分页进行设置
		// System.out.println(sf.toString()+"obj"+obj.get(0));

		Long count = executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);

		List list1 = this.executeQuery(pager, sf.toString(), obj.toArray());
		Iterator iterator1 = list1.iterator();
		while (iterator1.hasNext()) {
			Object[] o = (Object[]) iterator1.next();
			AccountTrade accountTrade = (AccountTrade) o[0];
			Account account = (Account) o[1];
			Object ay = new Object[] { account, accountTrade };
			myList.add(ay);
		}

		return myList;
	}

	@SuppressWarnings("unchecked")
	public List<Object[]> findAllItemByHql2(Pager pager, Integer sys_id, String cardNo, String userName, Integer credentialsType, String credentialsNo, String vehPlate, Integer status) {
		List myList = new ArrayList();

		// StringBuffer sf = new
		// StringBuffer("from Account account where");//查询，多条件查询，先判断是不是空，为空时不加入查询条件，否则添加
		StringBuffer sf = new StringBuffer(" from AccountTrade accountTrade,Account account where"); 
		List<Object> obj = new ArrayList<Object>();
		if (sys_id != null) {
			sf.append(" account.sys_id =? and");

			obj.add(sys_id);

		}
		if (!"".equals(cardNo)) {

			sf.append(" account.cardNo like? and");
			obj.add("%" + cardNo + "%");
		}

		if (!"".equals(userName)) {
			sf.append(" account.user.userName like ? and");
			obj.add("%" + userName + "%");

		}
		if (credentialsType != null) {
			sf.append(" account.user.credentialsType=? and");
			obj.add(credentialsType);
		}
		if (!"".equals(credentialsNo)) {
			sf.append(" account.user.credentialsNo like? and");
			obj.add("%" + credentialsNo + "%");
		}

		if (!"".equals(vehPlate)) {
			sf.append(" account.car.vehPlate like? and");
			obj.add("%" + vehPlate + "%");
		}
		if (status != null) {
			sf.append(" account.status =? and");
			obj.add(status);
		}
		// sf = sf.replace(sf.length() - 4, sf.length(), "");

		sf.append(" accountTrade.account.sys_id=account.sys_id and accountTrade.opTime = (select max(accountTrade1.opTime) from AccountTrade accountTrade1 where accountTrade1.account.sys_id=account.sys_id group by accountTrade1.account.sys_id) ");

		// 查出总行数，对分页进行设置
		// System.out.println(sf.toString()+"obj"+obj.get(0));

		Long count = executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);

		List list1 = this.executeQuery(pager, sf.toString(), obj.toArray());
		Iterator iterator1 = list1.iterator();
		while (iterator1.hasNext()) {
			Object[] o = (Object[]) iterator1.next();
			AccountTrade accountTrade = (AccountTrade) o[0];
			Account account = (Account) o[1];
			Object ay = new Object[] { account, accountTrade };
			myList.add(ay);
		}

		return myList;
	}

	@SuppressWarnings("unchecked")
	public List<Object[]> findAllItemToPayment(Pager pager) {// 记账卡充值的查询
		List myList = new ArrayList();
		StringBuffer sf = new StringBuffer(" from AccountTrade accountTrade,Account account where accountTrade.account.sys_id=account.sys_id and accountTrade.seqNo = (select max(accountTrade1.seqNo) from AccountTrade accountTrade1 where accountTrade1.account.sys_id=account.sys_id group by accountTrade1.account.sys_id) ");
		List<Object> obj = new ArrayList<Object>();

		Long count = executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
		List list1 = this.executeQuery(pager, sf.toString(), obj.toArray());
		Iterator iterator1 = list1.iterator();
		while (iterator1.hasNext()) {
			Object[] o = (Object[]) iterator1.next();
			AccountTrade accountTrade = (AccountTrade) o[0];
			Account account = (Account) o[1];
			Object ay = new Object[] { account, accountTrade };
			myList.add(ay);
		}

		return myList;
	}

	@SuppressWarnings("unchecked")
	public List<Object[]> findAllItemToPayment1(Pager pager) {// 储值卡充值的查询
		List myList = new ArrayList();
		StringBuffer sf = new StringBuffer(" from AccountTrade accountTrade,Account account where accountTrade.account.sys_id=account.sys_id and accountTrade.opTime = (select max(accountTrade1.opTime) from AccountTrade accountTrade1 where accountTrade1.account.sys_id=account.sys_id group by accountTrade1.account.sys_id) ");
		List<Object> obj = new ArrayList<Object>();
		// sf = sf.replace(sf.length() - 4, sf.length(), "");
		// 查出总行数，对分页进行设置
		// System.out.println(sf.toString()+"obj"+obj.get(0));
		Long count = executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
		List list1 = this.executeQuery(pager, sf.toString(), obj.toArray());
		Iterator iterator1 = list1.iterator();
		while (iterator1.hasNext()) {
			Object[] o = (Object[]) iterator1.next();
			AccountTrade accountTrade = (AccountTrade) o[0];
			Account account = (Account) o[1];
			Object ay = new Object[] { account, accountTrade };
			myList.add(ay);
		}

		return myList;
	}*/

	// StringBuffer sf1 = new
	// StringBuffer("select at.* from tb_AccountTrade at,t_park_account tpa where tpa.sys_id="+account.getSys_id()+"and at.accountNo="+account.getSys_id()+"and at.seqNo = (select max(at.seqNo) from tb_AccountTrade at,t_park_account tpa where at.accountNo="+account.getSys_id()+")");
	// List<Object> obj1 = new ArrayList<Object>();

	/*
	 * Set<AccountTrade> set=account.getAccountTrades();
	 * 
	 * Iterator it = set.iterator();
	 * 
	 * while(it.hasNext()&&bool==true){ accountTrade=(AccountTrade)it.next();
	 * if(accountTrade!=null){accountTrade1=accountTrade;bool=false;} }
	 * account.setBalance1(accountTrade1.getBalance()); } return
	 * this.executeQuery(pager,sf.toString(), obj.toArray());
	 */
	// }

	/*
	 * @SuppressWarnings("unchecked") public List<Account>
	 * findAllItemToPayment1(Pager pager){ System.out.println("dfdsfafdafd1");
	 * StringBuffer sf = new StringBuffer("from Account account "); List<Object>
	 * obj = new ArrayList<Object>(); Long count = executeCount(sf.toString(),
	 * obj.toArray()); pager.setTotalSize(count); List
	 * list1=this.executeQuery(pager,sf.toString(), obj.toArray());
	 * accountTrade1=new AccountTrade(); SimpleDateFormat sdf = new
	 * SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); for(int i=0;i<list1.size();i++){
	 * Date time; long temp=0; long t=0; Calendar
	 * calendar=Calendar.getInstance(); Account account=(Account)list1.get(i);
	 * Set<AccountTrade> set=account.getAccountTrades(); Iterator it =
	 * set.iterator(); while(it.hasNext()){
	 * accountTrade=(AccountTrade)it.next(); try {
	 * time=sdf.parse(accountTrade.getTradeTime()); calendar.setTime(time);
	 * t=calendar.getTimeInMillis(); if(t>temp){ accountTrade1=accountTrade;
	 * temp=t; } } catch (ParseException e) { // TODO Auto-generated catch block
	 * 
	 * e.printStackTrace(); } } account.setBalance1(accountTrade1.getBalance());
	 * } return this.executeQuery(pager,sf.toString(), obj.toArray()); }
	 */

	public AccountTrade getAccountTrade() {
		return accountTrade;
	}

	public void setAccountTrade(AccountTrade accountTrade) {
		this.accountTrade = accountTrade;
	}
	
	public Account getAccount() {
		return account;
	}

	public void setAccount(Account account) {
		this.account = account;
	}

	

}
