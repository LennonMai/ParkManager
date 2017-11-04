package com.hgsoft.dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import javax.annotation.Resource;
import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.hgsoft.entity.Account;
import com.hgsoft.entity.AccountTrade;
import com.hgsoft.util.HashUtil;
import com.hgsoft.util.JdbcUtil;
import com.hgsoft.util.Pager;

@Repository
public class AccountTradeDao extends BaseDao<AccountTrade> {
	@Resource
	private JdbcUtil jdbcUtil;
	@Resource
	private AccountDao accountDao;

	@SuppressWarnings("unchecked")
	public int getSeqNoByTwelveAccountTrade(int month, int accountNo) {
		String month1 = String.valueOf(month);
		if (month1.length() < 2) {
			month1 = "0" + month1;
		}
		String sql = "select max(seqNo) from tb_accountTrade" + month1 + " where accountNo=" + accountNo;
		String sql1 = "select * from tb_accountTrade" + month1 + " where accountNo=" + accountNo;
		int seqNo = jdbcUtil.select(sql) + 1;
		List list = jdbcUtil.selectForList(sql1);
		if (list.isEmpty()) {
			return 0;
		} else {
			return seqNo;
		}
	}

	public int updateBackoutedMark(int month, String listNo) {
		String month1 = String.valueOf(month);
		if (month1.length() < 2) {
			month1 = "0" + month1;
		}
		String sql = "update tb_accountTrade" + month1 + " set backoutedMark=0 where listNo='" + listNo + "'";
		return jdbcUtil.update(sql);
	}

	/*
	 * 根据月份和流水号查询流水
	 */
	@SuppressWarnings("unchecked")
	public List getAccountTradeByMonthAndListNo(int month, String listNo) {
		String month1 = String.valueOf(month);
		if (month1.length() < 2) {
			month1 = "0" + month1;
		}
		String sql = "select * from tb_accountTrade" + month1 + " where listNo='" + listNo + "'";
		return jdbcUtil.selectForList(sql);
	}

	public int monthApart(int startYear, int startMonth, int endYear, int endMonth) {// 结算相差月份，1月到1月相差月份为1
		int years = endYear - startYear;
		int months = 1;
		if (years == 0) {
			months = endMonth - startMonth + 1;
		} else if (years == 1) {
			months = endMonth + (12 - startMonth) + 1;
		} else {
			months = (years - 1) * 12 + endMonth + (12 - startMonth) + 1;
		}
		return months;

	}

	@SuppressWarnings("unchecked")
	public List findAllItemBySql(Pager pager, Integer sys_id, String cardNo, String userName, Integer tradeType, String credentialsNo, String vehPlate, Integer status, String startTime, String endTime, int sign) {
		// sign等于0时交易类型有限制(用于冲正），等于1时没交易类型限制（用于交易流水查询）
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Calendar cal = Calendar.getInstance();
		int startYear = 0, startMonth = 0, endYear = 0, endMonth = 0, count = 0;
		String month = "", sql = "";
		StringBuffer sb, sb1, sb2, sb3, sb4, sb5, sb6;
		try {
			cal.setTime(sdf.parse(startTime));
			startYear = cal.get(Calendar.YEAR);// 开始时间的当前年
			startMonth = cal.get(Calendar.MONTH) + 1;// 开始时间的当前月份
			cal.setTime(sdf.parse(endTime));
			endYear = cal.get(Calendar.YEAR);// 结束时间的当前年
			endMonth = cal.get(Calendar.MONTH) + 1;// 结束时间的当前月份

		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		int months = this.monthApart(startYear, startMonth, endYear, endMonth);// 求月份差，同个月差为1
		if (months == 1) {// 月间隔为1时（1月到1月间隔是1）
			month = String.valueOf(startMonth);
			if (month.length() <= 1) {
				month = "0" + month;
			}
			if (sign == 0) {
				sb = new StringBuffer("select * from tb_AccountTrade" + month + " where TradeType!=0 and TradeType!=3 and TradeType!=4 and TradeType!=5 and");
			} else {
				sb = new StringBuffer("select * from tb_AccountTrade" + month + " where ");
			}

			if (sys_id != null && !"".equals(sys_id)) {
				sb.append(" accountNo =" + sys_id + " and");
			}
			if (cardNo != null && !"".equals(cardNo)) {
				sb.append(" cardNo like " + "'%" + cardNo + "%' and");
			}
			if (userName != null && !"".equals(userName)) {
				sb.append(" accountNo in ( select sys_id from t_park_account where user_id in (select sys_id from t_park_user where userName like '%" + userName + "%') ) and");
			}
			if (tradeType != null && !"".equals(tradeType)) {
				sb.append(" tradeType=" + tradeType + " and");
			}

			if (credentialsNo != null && !"".equals(credentialsNo)) {
				sb.append(" accountNo in ( select sys_id from t_park_account where user_id in (select sys_id from t_park_user where credentialsNo like '%" + credentialsNo + "%') ) and");
			}

			if (vehPlate != null && !"".equals(vehPlate)) {
				sb.append(" vehPlate like '%" + vehPlate + "%' and");
				// sb.append(" accountNo in ( select sys_id from t_park_account where car_id in (select sys_id from t_park_car where vehPlate like %"+vehPlate+"%) ) and");
			}
			if (status != null && !"".equals(status)) {
				sb.append(" accountNo in ( select sys_id from t_park_account where status = " + status + " ) and");
			}
			if (null != startTime && !"".equals(startTime) && null != endTime && !"".equals(endTime)) {
				sb.append(" opTime >='" + startTime + "' and opTime <='" + endTime + "' and");
			}
			sb = sb.replace(sb.length() - 4, sb.length(), "");
			sql = sb.toString().trim();// + " order by opTime desc";
			sb1 = sb.replace(0, 8, "select count(*)");
			String sqlCount = sb1.toString();
			count = jdbcUtil.select(sqlCount);// 统计数量

		} else if (months == 2) {// 月间隔为2时（1月到2月间隔是2）
			String month1 = String.valueOf(startMonth);
			String month2 = String.valueOf(endMonth);
			if (month1.length() <= 1) {
				month1 = "0" + month1;
			}
			if (month2.length() <= 1) {
				month2 = "0" + month2;
			}
			if (sign == 0) {
				sb1 = new StringBuffer("select * from tb_AccountTrade" + month1 + " where TradeType!=0 and TradeType!=3 and TradeType!=4 and TradeType!=5 and");
				sb2 = new StringBuffer("select * from tb_AccountTrade" + month2 + " where TradeType!=0 and TradeType!=3 and TradeType!=4 and TradeType!=5 and");
			} else {
				sb1 = new StringBuffer("select * from tb_AccountTrade" + month1 + " where ");
				sb2 = new StringBuffer("select * from tb_AccountTrade" + month2 + " where ");
			}

			if (sys_id != null && !"".equals(sys_id)) {
				sb1.append(" accountNo =" + sys_id + " and");
				sb2.append(" accountNo =" + sys_id + " and");
			}
			if (cardNo != null && !"".equals(cardNo)) {
				sb1.append(" cardNo like " + "'%" + cardNo + "%' and");
				sb2.append(" cardNo like " + "'%" + cardNo + "%' and");
			}
			if (userName != null && !"".equals(userName)) {
				sb1.append(" accountNo in ( select sys_id from t_park_account where user_id in (select sys_id from t_park_user where userName like '%" + userName + "%') ) and");
				sb2.append(" accountNo in ( select sys_id from t_park_account where user_id in (select sys_id from t_park_user where userName like '%" + userName + "%') ) and");
			}
			if (tradeType != null && !"".equals(tradeType)) {
				sb1.append(" tradeType=" + tradeType + " and");
				sb2.append(" tradeType=" + tradeType + " and");
			}

			if (credentialsNo != null && !"".equals(credentialsNo)) {
				sb1.append(" accountNo in ( select sys_id from t_park_account where user_id in (select sys_id from t_park_user where credentialsNo like '%" + credentialsNo + "%') ) and");
				sb2.append(" accountNo in ( select sys_id from t_park_account where user_id in (select sys_id from t_park_user where credentialsNo like '%" + credentialsNo + "%') ) and");
			}

			if (vehPlate != null && !"".equals(vehPlate)) {
				sb1.append(" vehPlate like '%" + vehPlate + "%' and");
				sb2.append(" vehPlate like '%" + vehPlate + "%' and");
				// sb1.append(" accountNo in ( select sys_id from t_park_account where car_id in (select sys_id from t_park_car where vehPlate like %"+vehPlate+"%) ) and");
			}
			if (status != null && !"".equals(status)) {
				sb1.append(" accountNo in ( select sys_id from t_park_account where status = " + status + " ) and");
				sb2.append(" accountNo in ( select sys_id from t_park_account where status = " + status + " ) and");
			}
			if (null != startTime && !"".equals(startTime) && null != endTime && !"".equals(endTime)) {
				sb1.append(" opTime >='" + startTime + "' and opTime <='" + endTime + "' and");
				sb2.append(" opTime >='" + startTime + "' and opTime <='" + endTime + "' and");
			}
			sb1 = sb1.replace(sb1.length() - 4, sb1.length(), "");
			sb2 = sb2.replace(sb2.length() - 4, sb2.length(), "");
			sql = sb1.toString().trim() + " union all " + sb2.toString().trim() ;//+ " order by opTime desc";
			sb3 = sb1.replace(0, 8, "select count(*)");
			sb4 = sb2.replace(0, 8, "select count(*)");
			count = jdbcUtil.select(sb3.toString()) + jdbcUtil.select(sb4.toString());// 统计数量
		} else if (months == 3) {// 月间隔为3时（1月到3月间隔是3）
			String month1 = String.valueOf(startMonth);
			String month2 = String.valueOf(endMonth);
			String month3 = "";
			if ((startMonth + 1) <= 12) {
				month3 = String.valueOf(startMonth + 1);
			} else {
				month3 = String.valueOf(endMonth - 1);
			}
			if (month1.length() <= 1) {
				month1 = "0" + month1;
			}
			if (month2.length() <= 1) {
				month2 = "0" + month2;
			}
			if (month3.length() <= 1) {
				month3 = "0" + month3;
			}
			if (sign == 0) {
				sb1 = new StringBuffer("select * from tb_AccountTrade" + month1 + " where TradeType!=0 and TradeType!=3 and TradeType!=4 and TradeType!=5 and");
				sb2 = new StringBuffer("select * from tb_AccountTrade" + month2 + " where TradeType!=0 and TradeType!=3 and TradeType!=4 and TradeType!=5 and");
				sb3 = new StringBuffer("select * from tb_AccountTrade" + month3 + " where TradeType!=0 and TradeType!=3 and TradeType!=4 and TradeType!=5 and");
			} else {
				sb1 = new StringBuffer("select * from tb_AccountTrade" + month1 + " where ");
				sb2 = new StringBuffer("select * from tb_AccountTrade" + month2 + " where ");
				sb3 = new StringBuffer("select * from tb_AccountTrade" + month3 + " where ");
			}
			if (sys_id != null && !"".equals(sys_id)) {
				sb1.append(" accountNo =" + sys_id + " and");
				sb2.append(" accountNo =" + sys_id + " and");
				sb3.append(" accountNo =" + sys_id + " and");
			}
			if (cardNo != null && !"".equals(cardNo)) {
				sb1.append(" cardNo like " + "'%" + cardNo + "%' and");
				sb2.append(" cardNo like " + "'%" + cardNo + "%' and");
				sb3.append(" cardNo like " + "'%" + cardNo + "%' and");
			}
			if (userName != null && !"".equals(userName)) {
				sb1.append(" accountNo in ( select sys_id from t_park_account where user_id in (select sys_id from t_park_user where userName like '%" + userName + "%') ) and");
				sb2.append(" accountNo in ( select sys_id from t_park_account where user_id in (select sys_id from t_park_user where userName like '%" + userName + "%') ) and");
				sb3.append(" accountNo in ( select sys_id from t_park_account where user_id in (select sys_id from t_park_user where userName like '%" + userName + "%') ) and");
			}
			if (tradeType != null && !"".equals(tradeType)) {
				sb1.append(" tradeType=" + tradeType + " and");
				sb2.append(" tradeType=" + tradeType + " and");
				sb3.append(" tradeType=" + tradeType + " and");
			}

			if (credentialsNo != null && !"".equals(credentialsNo)) {
				sb1.append(" accountNo in ( select sys_id from t_park_account where user_id in (select sys_id from t_park_user where credentialsNo like '%" + credentialsNo + "%') ) and");
				sb2.append(" accountNo in ( select sys_id from t_park_account where user_id in (select sys_id from t_park_user where credentialsNo like '%" + credentialsNo + "%') ) and");
				sb3.append(" accountNo in ( select sys_id from t_park_account where user_id in (select sys_id from t_park_user where credentialsNo like '%" + credentialsNo + "%') ) and");
			}

			if (vehPlate != null && !"".equals(vehPlate)) {
				sb1.append(" vehPlate like '%" + vehPlate + "%' and");
				sb2.append(" vehPlate like '%" + vehPlate + "%' and");
				sb3.append(" vehPlate like '%" + vehPlate + "%' and");
				// sb1.append(" accountNo in ( select sys_id from t_park_account where car_id in (select sys_id from t_park_car where vehPlate like %"+vehPlate+"%) ) and");
			}
			if (status != null && !"".equals(status)) {
				sb1.append(" accountNo in ( select sys_id from t_park_account where status = " + status + " ) and");
				sb2.append(" accountNo in ( select sys_id from t_park_account where status = " + status + " ) and");
				sb3.append(" accountNo in ( select sys_id from t_park_account where status = " + status + " ) and");
			}
			if (null != startTime && !"".equals(startTime) && null != endTime && !"".equals(endTime)) {
				sb1.append(" opTime >='" + startTime + "' and opTime <='" + endTime + "' and");
				sb2.append(" opTime >='" + startTime + "' and opTime <='" + endTime + "' and");
				sb3.append(" opTime >='" + startTime + "' and opTime <='" + endTime + "' and");
			}
			sb1 = sb1.replace(sb1.length() - 4, sb1.length(), "");
			sb2 = sb2.replace(sb2.length() - 4, sb2.length(), "");
			sb3 = sb3.replace(sb3.length() - 4, sb3.length(), "");
			sql = sb1.toString().trim() + " union all " + sb2.toString().trim() + " union all " + sb3.toString().trim() ;//+ " order by opTime desc";
			sb4 = sb1.replace(0, 8, "select count(*)");
			sb5 = sb2.replace(0, 8, "select count(*)");
			sb6 = sb3.replace(0, 8, "select count(*)");
			count = jdbcUtil.select(sb4.toString()) + jdbcUtil.select(sb5.toString()) + jdbcUtil.select(sb6.toString());// 统计数量
		}
		pager.setTotalSize(count);
		// 要加上addScalar（）修改值类型，否则数据库中对应的字符串类型获取的是一个字符（hibernate的bug）。
		Query query = getSession().createSQLQuery(sql+" order by accountNo,seqNo desc").addScalar("accountNo", Hibernate.INTEGER).addScalar("cardNo", Hibernate.STRING).addScalar("vehPlate", Hibernate.STRING).addScalar("tradeType", Hibernate.INTEGER).addScalar("OpTime", Hibernate.STRING).addScalar("fee", Hibernate.INTEGER).addScalar("balance", Hibernate.INTEGER).addScalar("backoutedMark", Hibernate.INTEGER).addScalar("listNo", Hibernate.STRING);
		if (pager != null) {
			query.setFirstResult((pager.getCurrentPage() - 1) * pager.getPageSize());
			query.setMaxResults(pager.getPageSize());
		}
		return query.list();
	}

	@SuppressWarnings("unchecked")
	public List findAllUnusualAccountTradeBySql(Pager pager, Integer sys_id, String cardNo, String userName, Integer tradeType, String credentialsNo, String vehPlate, Integer status, String startTime, String endTime) {
		// sign等于0时交易类型有限制(用于冲正），等于1时没交易类型限制（用于交易流水查询）
		int count = 0;
		String sql = "";
		StringBuffer sb, sb1;
		sb = new StringBuffer("select * from tb_UnusualAccountTrade where ");
		if (sys_id != null && !"".equals(sys_id)) {
			sb.append(" accountNo =" + sys_id + " and");
		}
		if (cardNo != null && !"".equals(cardNo)) {
			sb.append(" cardNo like " + "'%" + cardNo + "%' and");
		}
		if (userName != null && !"".equals(userName)) {
			sb.append(" accountNo in ( select sys_id from t_park_account where user_id in (select sys_id from t_park_user where userName like '%" + userName + "%') ) and");
		}
		if (tradeType != null && !"".equals(tradeType)) {
			sb.append(" tradeType=" + tradeType + " and");
		}

		if (credentialsNo != null && !"".equals(credentialsNo)) {
			sb.append(" accountNo in ( select sys_id from t_park_account where user_id in (select sys_id from t_park_user where credentialsNo like '%" + credentialsNo + "%') ) and");
		}

		if (vehPlate != null && !"".equals(vehPlate)) {
			sb.append(" vehPlate like '%" + vehPlate + "%' and");
		}
		if (status != null && !"".equals(status)) {
			sb.append(" accountNo in ( select sys_id from t_park_account where status = " + status + " ) and");
		}
		if (null != startTime && !"".equals(startTime) && null != endTime && !"".equals(endTime)) {
			sb.append(" opTime >='" + startTime + "' and opTime <='" + endTime + "' and");
		}
		sb = sb.replace(sb.length() - 4, sb.length(), "");
		sql = sb.toString().trim() + " order by opTime desc";
		sb1 = sb.replace(0, 8, "select count(*)");
		String sqlCount = sb1.toString();
		count = jdbcUtil.select(sqlCount);// 统计数量
		pager.setTotalSize(count);
		// 要加上addScalar（）修改值类型，否则数据库中对应的字符串类型获取的是一个字符（hibernate的bug）。
		Query query = getSession().createSQLQuery(sql).addScalar("accountNo", Hibernate.INTEGER).addScalar("cardNo", Hibernate.STRING).addScalar("vehPlate", Hibernate.STRING).addScalar("tradeType", Hibernate.INTEGER).addScalar("OpTime", Hibernate.STRING).addScalar("fee", Hibernate.INTEGER).addScalar("balance", Hibernate.INTEGER).addScalar("backoutedMark", Hibernate.INTEGER).addScalar("listNo", Hibernate.STRING);
		if (pager != null) {
			query.setFirstResult((pager.getCurrentPage() - 1) * pager.getPageSize());
			query.setMaxResults(pager.getPageSize());
		}
		return query.list();
	}

	/*
	 * @SuppressWarnings("unchecked") public List<Object[]>
	 * findAllItemByHql1(Pager pager, Integer sys_id, String cardNo, String
	 * userName, Integer tradeType, String vehPlate, String credentialsNo,
	 * Integer status) { List myList = new ArrayList(); StringBuffer sf = new
	 * StringBuffer(" from AccountTrade accountTrade,Account account where"); //
	 * List<Object> obj = new ArrayList<Object>(); if (sys_id != null) {
	 * sf.append(" account.sys_id =? and");
	 * 
	 * obj.add(sys_id);
	 * 
	 * } if (!"".equals(cardNo)) {
	 * 
	 * sf.append(" account.cardNo like? and"); obj.add("%" + cardNo + "%"); }
	 * 
	 * if (!"".equals(userName)) {
	 * sf.append(" account.user.userName like ? and"); obj.add("%" + userName +
	 * "%");
	 * 
	 * } if (tradeType != null) { sf.append(" accountTrade.tradeType =? and");
	 * 
	 * obj.add(tradeType);
	 * 
	 * } if (!"".equals(vehPlate)) {
	 * sf.append(" account.car.vehPlate like? and"); obj.add("%" + vehPlate +
	 * "%"); }
	 * 
	 * if (!"".equals(credentialsNo)) {
	 * sf.append(" account.user.credentialsNo like? and"); obj.add("%" +
	 * credentialsNo + "%"); } if (status != null) {
	 * sf.append(" account.status =? and");
	 * 
	 * obj.add(status);
	 * 
	 * }sf.append(
	 * " accountTrade.account.sys_id=account.sys_id and accountTrade.seqNo = (select max(accountTrade1.seqNo) from AccountTrade accountTrade1 where accountTrade1.account.sys_id=account.sys_id group by accountTrade1.account.sys_id) "
	 * ); Long count = executeCount(sf.toString(), obj.toArray());
	 * pager.setTotalSize(count);
	 * 
	 * List list1 = this.executeQuery(pager, sf.toString(), obj.toArray());
	 * Iterator iterator1 = list1.iterator(); while (iterator1.hasNext()) {
	 * Object[] o = (Object[]) iterator1.next(); AccountTrade accountTrade =
	 * (AccountTrade) o[0]; Account account = (Account) o[1]; Object ay = new
	 * Object[] { account, accountTrade }; myList.add(ay); }
	 * 
	 * return myList; }
	 */

	/*
	 * @SuppressWarnings("unchecked") public List<Object[]>
	 * findAllItemByHql2(Pager pager, Integer sys_id, String cardNo, String
	 * userName, Integer tradeType, String vehPlate, String credentialsNo,
	 * Integer status) { List myList = new ArrayList();
	 * 
	 * // StringBuffer sf = new //
	 * StringBuffer("from Account account where");//查询
	 * ，多条件查询，先判断是不是空，为空时不加入查询条件，否则添加 StringBuffer sf = new
	 * StringBuffer(" from AccountTrade accountTrade,Account account where");
	 * List<Object> obj = new ArrayList<Object>(); if (sys_id != null) {
	 * sf.append(" account.sys_id =? and");
	 * 
	 * obj.add(sys_id);
	 * 
	 * } if (!"".equals(cardNo)) {
	 * 
	 * sf.append(" account.cardNo like? and"); obj.add("%" + cardNo + "%"); }
	 * 
	 * if (!"".equals(userName)) {
	 * sf.append(" account.user.userName like ? and"); obj.add("%" + userName +
	 * "%");
	 * 
	 * } if (tradeType != null) { sf.append(" accountTrade.tradeType =? and");
	 * 
	 * obj.add(tradeType);
	 * 
	 * } if (!"".equals(vehPlate)) {
	 * sf.append(" account.car.vehPlate like? and"); obj.add("%" + vehPlate +
	 * "%"); }
	 * 
	 * if (!"".equals(credentialsNo)) {
	 * sf.append(" account.user.credentialsNo like? and"); obj.add("%" +
	 * credentialsNo + "%"); } if (status != null) {
	 * sf.append(" account.status =? and");
	 * 
	 * obj.add(status);
	 * 
	 * }sf.append(
	 * " accountTrade.account.sys_id=account.sys_id and accountTrade.opTime = (select max(accountTrade1.opTime) from AccountTrade accountTrade1 where accountTrade1.account.sys_id=account.sys_id group by accountTrade1.account.sys_id) "
	 * ); // 查出总行数，对分页进行设置 Long count = executeCount(sf.toString(),
	 * obj.toArray()); pager.setTotalSize(count);
	 * 
	 * List list1 = this.executeQuery(pager, sf.toString(), obj.toArray());
	 * Iterator iterator1 = list1.iterator(); while (iterator1.hasNext()) {
	 * Object[] o = (Object[]) iterator1.next(); AccountTrade accountTrade =
	 * (AccountTrade) o[0]; Account account = (Account) o[1]; Object ay = new
	 * Object[] { account, accountTrade }; myList.add(ay); }
	 * 
	 * return myList; }
	 */
	/*
	 * @SuppressWarnings("unchecked") public List<AccountTrade>
	 * findAllItemByHql(Pager pager, Integer sys_id, String cardNo, String
	 * userName, Integer tradeType, String credentialsNo, String vehPlate,
	 * Integer status) {
	 * 
	 * StringBuffer sf = new
	 * StringBuffer("from AccountTrade accountTrade where");//
	 * 多条件查询，空不加入否则加入查询条件 List<Object> obj = new ArrayList<Object>(); if (sys_id
	 * != null) { sf.append(" accountTrade.account.sys_id =?  and");
	 * 
	 * obj.add(sys_id);
	 * 
	 * } if (!"".equals(cardNo)) {
	 * 
	 * sf.append(" accountTrade.account.cardNo like? and"); obj.add("%" + cardNo
	 * + "%"); }
	 * 
	 * if (!"".equals(userName)) {
	 * sf.append(" accountTrade.account.user.userName like ? and"); obj.add("%"
	 * + userName + "%");
	 * 
	 * } if (tradeType != null) { sf.append(" accountTrade.tradeType=? and");
	 * obj.add(tradeType); } if (!"".equals(credentialsNo)) {
	 * sf.append(" accountTrade.account.user.credentialsNo like? and");
	 * obj.add("%" + credentialsNo + "%"); }
	 * 
	 * if (!"".equals(vehPlate)) {
	 * sf.append(" accountTrade.account.car.vehPlate like? and"); obj.add("%" +
	 * vehPlate + "%"); } if (status != null) {
	 * sf.append(" accountTrade.account.status =?  and");
	 * 
	 * obj.add(status);
	 * 
	 * }
	 * 
	 * sf = sf.replace(sf.length() - 4, sf.length(), "");
	 * 
	 * // 查出总行数，对分页进行设置 // System.out.println(sf.toString()+"obj"+obj.get(0));
	 * 
	 * Long count = executeCount(sf.toString(), obj.toArray());
	 * pager.setTotalSize(count);
	 * sf.append(" order by accountTrade.account.sys_id,accountTrade.seqNo desc"
	 * ); return this.executeQuery(pager, sf.toString(), obj.toArray()); }
	 */
	/*
	 * @SuppressWarnings("unchecked") public List<AccountTrade>
	 * findAllItemByHql3(Pager pager,Integer sys_id,String cardNo,String
	 * userName,Integer tradeType,String credentialsNo,String vehPlate,Integer
	 * status){
	 * 
	 * StringBuffer sf = newStringBuffer(
	 * "from AccountTrade accountTrade where accountTrade.tradeType!=0 and accountTrade.tradeType!=3 and accountTrade.tradeType!=4 and accountTrade.tradeType!=5 and"
	 * );//多条件查询，空不加入否则加入查询条件 List<Object> obj = new ArrayList<Object>();
	 * if(sys_id != null){ sf.append(" accountTrade.account.sys_id =?  and");
	 * 
	 * obj.add(sys_id);
	 * 
	 * } if(!"".equals(cardNo)){
	 * 
	 * sf.append(" accountTrade.account.cardNo like? and");
	 * obj.add("%"+cardNo+"%"); }
	 * 
	 * if(!"".equals(userName)){
	 * sf.append(" accountTrade.account.user.userName like ? and");
	 * obj.add("%"+userName+"%");
	 * 
	 * } if(tradeType != null){ sf.append(" accountTrade.tradeType=? and");
	 * obj.add(tradeType); } if(!"".equals(credentialsNo)){
	 * sf.append(" accountTrade.account.user.credentialsNo like? and");
	 * obj.add("%"+credentialsNo+"%"); }
	 * 
	 * if(!"".equals(vehPlate)){
	 * sf.append(" accountTrade.account.car.vehPlate like? and");
	 * obj.add("%"+vehPlate+"%"); } if(status != null){
	 * sf.append(" accountTrade.account.status =?  and");
	 * 
	 * obj.add(status);
	 * 
	 * }
	 * 
	 * 
	 * sf = sf.replace(sf.length() - 4, sf.length(), "");
	 * 
	 * //查出总行数，对分页进行设置 //System.out.println(sf.toString()+"obj"+obj.get(0));
	 * 
	 * Long count = executeCount(sf.toString(), obj.toArray());
	 * pager.setTotalSize(count);
	 * sf.append(" order by accountTrade.account.sys_id,accountTrade.seqNo desc"
	 * ); return this.executeQuery(pager,sf.toString(), obj.toArray()); }
	 */
	/*
	 * @SuppressWarnings("unchecked") public List<AccountTrade>
	 * findAllItemByHql4(Pager pager) {
	 * 
	 * StringBuffer sf = newStringBuffer(
	 * "from AccountTrade accountTrade where accountTrade.tradeType!=0 and accountTrade.tradeType!=3 and accountTrade.tradeType!=4 and accountTrade.tradeType!=5"
	 * );// 多条件查询，空不加入否则加入查询条件 List<Object> obj = new ArrayList<Object>(); //
	 * 查出总行数，对分页进行设置 // System.out.println(sf.toString()+"obj"+obj.get(0)); Long
	 * count = executeCount(sf.toString(), obj.toArray());
	 * pager.setTotalSize(count); return this.executeQuery(pager, sf.toString(),
	 * obj.toArray()); }
	 * 
	 * @SuppressWarnings("unchecked") public List<AccountTrade>
	 * findAllItemByHqlAndTime(Pager pager, Integer sys_id, String cardNo,
	 * String userName, Integer tradeType, String credentialsNo, String
	 * vehPlate, Integer status, String startTime1, String endTime1) {
	 * 
	 * StringBuffer sf = new
	 * StringBuffer("from AccountTrade accountTrade where");//
	 * 多条件查询，空不加入否则加入查询条件 List<Object> obj = new ArrayList<Object>(); if (sys_id
	 * != null) { sf.append(" accountTrade.account.sys_id =?  and");
	 * 
	 * obj.add(sys_id);
	 * 
	 * } if (!"".equals(cardNo)) {
	 * 
	 * sf.append(" accountTrade.account.cardNo like? and"); obj.add("%" + cardNo
	 * + "%"); }
	 * 
	 * if (!"".equals(userName)) {
	 * sf.append(" accountTrade.account.user.userName like ? and"); obj.add("%"
	 * + userName + "%");
	 * 
	 * } if (tradeType != null) { sf.append(" accountTrade.tradeType=? and");
	 * obj.add(tradeType); } if (!"".equals(credentialsNo)) {
	 * sf.append(" accountTrade.account.user.credentialsNo like? and");
	 * obj.add("%" + credentialsNo + "%"); }
	 * 
	 * if (!"".equals(vehPlate)) {
	 * sf.append(" accountTrade.account.car.vehPlate like? and"); obj.add("%" +
	 * vehPlate + "%"); } if (status != null) {
	 * sf.append(" accountTrade.account.status =?  and");
	 * 
	 * obj.add(status);
	 * 
	 * }
	 * 
	 * if (!"".equals(startTime1)) { sf.append("  accountTrade.opTime>= ? and");
	 * obj.add(startTime1); } if (!"".equals(endTime1)) {
	 * sf.append("  accountTrade.opTime<= ? and"); obj.add(endTime1); }
	 * 
	 * sf = sf.replace(sf.length() - 4, sf.length(), "");
	 * 
	 * // 查出总行数，对分页进行设置 // System.out.println(sf.toString()+"obj"+obj.get(0));
	 * 
	 * Long count = executeCount(sf.toString(), obj.toArray());
	 * pager.setTotalSize(count);
	 * sf.append(" order by accountTrade.account.sys_id,accountTrade.seqNo desc"
	 * ); return this.executeQuery(pager, sf.toString(), obj.toArray()); }
	 */
	/*
	 * //核实用户身份，根据用户名查询账号信息
	 * 
	 * @SuppressWarnings("unchecked") public String
	 * findAccountidByuserName(String userName){ Stringhql=
	 * "select account.sys_id from Account account where account.user.sys_id=(select user.sys_id from User user where user.userName=?)"
	 * ; List list=executeQuery(hql,userName); if(!list.isEmpty()){ return
	 * list.get(0).toString(); }else return null; } //核实用户身份，根据车牌号查询账号信息
	 * 
	 * @SuppressWarnings("unchecked") public String
	 * findAccountidByvehPlate(String vehPlate){ Stringhql=
	 * "select account.sys_id from Account account where account.car.sys_id=(select ca.sys_id from Car ca where ca.vehPlate=?)"
	 * ; List list=executeQuery(hql,vehPlate); if(!list.isEmpty()){ return
	 * list.get(0).toString(); }else return null; } //核实用户身份，根据缴费卡号查询账号信息
	 * 
	 * @SuppressWarnings("unchecked") public String findAccountidBycardNo(String
	 * cardNo){ String
	 * hql="select account.sys_id from Account account where account.cardNo=?";
	 * List list=executeQuery(hql,cardNo); if(!list.isEmpty()){ return
	 * list.get(0).toString(); }else return null; }
	 * 
	 * //根据账号信息查询交易流水表，返回该账号的交易流水信息
	 * 
	 * @SuppressWarnings("unchecked") public List<AccountTrade>
	 * findAllAccountTradeByHql(Pager pager, String userName, String vehPlate,
	 * String cardNo) { StringBuffer sf = new
	 * StringBuffer("from AccountTrade accountTrade where"); List<Object> obj =
	 * new ArrayList<Object>(); if (!userName.equals("")) {
	 * sf.append(" accountTrade.accountNo=? and"); obj.add(
	 * Integer.valueOf(findAccountidByuserName(userName))); } if
	 * (!vehPlate.equals("")) { sf.append(" accountTrade.vehPlate=? and");
	 * obj.add(vehPlate); } if (!cardNo.equals("")) {
	 * sf.append(" accountTrade.cardNo=? and"); obj.add(cardNo); } sf =
	 * sf.replace(sf.length() - 4, sf.length(), ""); // 查出总行数，对分页进行设置 Long count
	 * = this.executeCount(sf.toString(), obj.toArray());
	 * pager.setTotalSize(count); if(!this.executeQuery(pager, sf.toString(),
	 * obj.toArray()).isEmpty()){ return this.executeQuery(pager, sf.toString(),
	 * obj.toArray()); }else return null;
	 * 
	 * } //用户表、账号表和流水表三表查询
	 * 
	 * @SuppressWarnings("unchecked") public List findAllByThree(Pager pager){
	 * //select us.userName,
	 * accountt.vehPlate,accountt.accountNo,account.status,accountt.cardNo
	 * //from tb_accountTrade accountt inner join t_park_account account //on
	 * accountt.accountNo=account.sys_id inner join t_park_user us on
	 * account.user_id=us.sys_id // Stringhql=
	 * "select User.userName, accountTrade.vehPlate,accountTrade.accountNo,account.status,accountTrade.cardNo, "
	 * + //
	 * "accountTrade.balance,accountTrade.parkNo from AccountTrade accountTrade  "
	 * + //
	 * "inner join Account account on accountTrade.accountNo=account.sys_id " +
	 * // "inner join User on account.user.sys_id=User.sys_id"; Stringhql=
	 * "select accountTrade.vehPlate,accountTrade.accountNo,account.status,accountTrade.cardNo, "
	 * +
	 * "accountTrade.balance,accountTrade.parkNo from AccountTrade accountTrade  "
	 * + ", Account account where accountTrade.accountNo=account.sys_id "; Query
	 * query = getSession().createQuery(hql); Iterator
	 * it=query.list().iterator(); while(it.hasNext()){
	 * System.out.println(" "+it.next()); } if(pager != null){
	 * query.setFirstResult((pager.getCurrentPage() - 1) * pager.getPageSize());
	 * query.setMaxResults(pager.getPageSize()); } return query.list(); }
	 */
	// chenfuyuan
	public String deleteNull(Integer sys_id, Integer seqNo, Integer tradeType, Integer fee, Integer balance, String cardNo, Integer cardType, String vehPlate, String listNo, Integer operatorId, String possword, String tradeTime, String opTime) {
		StringBuffer sf = new StringBuffer();

		if (sys_id != null) {
			sf.append(sys_id + "_");

		} else {
			sf.append("_");
		}

		if (seqNo != null) {
			sf.append(seqNo + "_");

		} else {
			sf.append("_");
		}

		if (tradeType != null) {
			sf.append(tradeType + "_");

		} else {
			sf.append("_");
		}

		if (fee != null) {
			sf.append(fee + "_");

		} else {
			sf.append("_");
		}

		if (balance != null) {
			sf.append(balance + "_");

		} else {
			sf.append("_");
		}

		if (cardNo != null) {
			sf.append(cardNo.trim() + "_");

		} else {
			sf.append("_");
		}

		if (cardType != null) {
			sf.append(cardType + "_");

		} else {
			sf.append("_");
		}

		if (vehPlate != null) {
			sf.append(vehPlate.trim() + "_");

		} else {
			sf.append("_");
		}

		if (listNo != null) {
			sf.append(listNo.trim() + "_");

		} else {
			sf.append("_");
		}

		if (operatorId != null) {
			sf.append(operatorId + "_");

		} else {
			sf.append("_");
		}

		if (possword != null) {
			sf.append(possword.trim() + "_");

		} else {
			sf.append("_");
		}

		if (tradeTime != null) {
			sf.append(tradeTime + "_");

		} else {
			sf.append("_");
		}

		if (opTime != null) {
			sf.append(opTime + "_");
		} else {
			sf.append("_");
		}
		sf.append("!%$&()&JKGDE0973x][");
		return sf.toString();
	}

	@SuppressWarnings("unchecked")
	public AccountTrade getAccountTradeByAccountNoOrder(int accountNo) {// 根据账号查交易流水表，并按序号降序排列
		String hql = "from AccountTrade accountTrade where  accountTrade.account.sys_id=? order by accountTrade.seqNo desc";
		List resultList = executeQuery(hql, accountNo);
		if (resultList.isEmpty())
			return null;
		else
			return (AccountTrade) resultList.get(0);

	}

	@SuppressWarnings("unchecked")
	public List findVerifyAccountTrade(Pager pager, String keyMD5, String startTime, String endTime, String userName, String cardNo, String vehPlate, Integer tradeType, String validateCheck) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Calendar cal = Calendar.getInstance();
		int startYear = 0, startMonth = 0, endYear = 0, endMonth = 0;
		String month = "", sql = "";
		String validateVerify = null;
		StringBuffer sb, sb1, sb2, sb3;
		try {
			cal.setTime(sdf.parse(startTime));
			startYear = cal.get(Calendar.YEAR);// 开始时间的当前年
			startMonth = cal.get(Calendar.MONTH) + 1;// 开始时间的当前月份
			cal.setTime(sdf.parse(endTime));
			endYear = cal.get(Calendar.YEAR);// 结束时间的当前年
			endMonth = cal.get(Calendar.MONTH) + 1;// 结束时间的当前月份

		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		int months = this.monthApart(startYear, startMonth, endYear, endMonth);// 求月份差，同个月差为1
		if (months == 1) {// 月间隔为1时（1月到1月间隔是1）
			month = String.valueOf(startMonth);
			if (month.length() <= 1) {
				month = "0" + month;
			}
			sb = new StringBuffer("select * from tb_AccountTrade" + month + " where ");
			if (null != startTime && !"".equals(startTime) && null != endTime && !"".equals(endTime)) {
				sb.append(" opTime >='" + startTime + "' and opTime <='" + endTime + "' and");
			}
			if (userName != null && !"".equals(userName)) {
				sb.append(" accountNo in ( select sys_id from t_park_account where user_id in (select sys_id from t_park_user where userName like '%" + userName + "%') ) and");
			}
			if (cardNo != null && !"".equals(cardNo)) {
				sb.append(" cardNo like " + "'%" + cardNo + "%' and");
			}
			if (vehPlate != null && !"".equals(vehPlate)) {
				sb.append(" vehPlate like '%" + vehPlate + "%' and");
				// sb.append(" accountNo in ( select sys_id from t_park_account where car_id in (select sys_id from t_park_car where vehPlate like %"+vehPlate+"%) ) and");
			}
			if (tradeType != null && !"".equals(tradeType)) {
				sb.append(" tradeType=" + tradeType + " and");
			}
			sb = sb.replace(sb.length() - 4, sb.length(), "");
			sql = sb.toString().trim() + " order by opTime desc";
			sb1 = sb.replace(0, 8, "select count(*)");
			/*
			 * String sqlCount = sb1.toString(); count =
			 * jdbcUtil.select(sqlCount);// 统计数量
			 */
		} else if (months == 2) {// 月间隔为2时（1月到2月间隔是2）
			String month1 = String.valueOf(startMonth);
			String month2 = String.valueOf(endMonth);
			if (month1.length() <= 1) {
				month1 = "0" + month1;
			}
			if (month2.length() <= 1) {
				month2 = "0" + month2;
			}

			sb1 = new StringBuffer("select * from tb_AccountTrade" + month1 + " where ");
			sb2 = new StringBuffer("select * from tb_AccountTrade" + month2 + " where ");

			if (null != startTime && !"".equals(startTime) && null != endTime && !"".equals(endTime)) {
				sb1.append(" opTime >='" + startTime + "' and opTime <='" + endTime + "' and");
				sb2.append(" opTime >='" + startTime + "' and opTime <='" + endTime + "' and");
			}
			if (userName != null && !"".equals(userName)) {
				sb1.append(" accountNo in ( select sys_id from t_park_account where user_id in (select sys_id from t_park_user where userName like '%" + userName + "%') ) and");
				sb2.append(" accountNo in ( select sys_id from t_park_account where user_id in (select sys_id from t_park_user where userName like '%" + userName + "%') ) and");
			}
			if (cardNo != null && !"".equals(cardNo)) {
				sb1.append(" cardNo like " + "'%" + cardNo + "%' and");
				sb2.append(" cardNo like " + "'%" + cardNo + "%' and");
			}
			if (vehPlate != null && !"".equals(vehPlate)) {
				sb1.append(" vehPlate like '%" + vehPlate + "%' and");
				sb2.append(" vehPlate like '%" + vehPlate + "%' and");
				// sb.append(" accountNo in ( select sys_id from t_park_account where car_id in (select sys_id from t_park_car where vehPlate like %"+vehPlate+"%) ) and");
			}
			if (tradeType != null && !"".equals(tradeType)) {
				sb1.append(" tradeType=" + tradeType + " and");
				sb2.append(" tradeType=" + tradeType + " and");
			}
			sb1 = sb1.replace(sb1.length() - 4, sb1.length(), "");
			sb2 = sb2.replace(sb2.length() - 4, sb2.length(), "");
			sql = sb1.toString().trim() + " union all " + sb2.toString().trim() + " order by opTime desc";
			/*
			 * sb3 = sb1.replace(0, 8, "select count(*)"); sb4 = sb2.replace(0,
			 * 8, "select count(*)"); count = jdbcUtil.select(sb3.toString())
			 * +jdbcUtil.select(sb4.toString());// 统计数量
			 */} else if (months == 3) {// 月间隔为3时（1月到3月间隔是3）
			String month1 = String.valueOf(startMonth);
			String month2 = String.valueOf(endMonth);
			String month3 = "";
			if ((startMonth + 1) <= 12) {
				month3 = String.valueOf(startMonth + 1);
			} else {
				month3 = String.valueOf(endMonth - 1);
			}
			if (month1.length() <= 1) {
				month1 = "0" + month1;
			}
			if (month2.length() <= 1) {
				month2 = "0" + month2;
			}
			if (month3.length() <= 1) {
				month3 = "0" + month3;
			}

			sb1 = new StringBuffer("select * from tb_AccountTrade" + month1 + " where ");
			sb2 = new StringBuffer("select * from tb_AccountTrade" + month2 + " where ");
			sb3 = new StringBuffer("select * from tb_AccountTrade" + month3 + " where ");
			if (null != startTime && !"".equals(startTime) && null != endTime && !"".equals(endTime)) {
				sb1.append(" opTime >='" + startTime + "' and opTime <='" + endTime + "' and");
				sb2.append(" opTime >='" + startTime + "' and opTime <='" + endTime + "' and");
				sb3.append(" opTime >='" + startTime + "' and opTime <='" + endTime + "' and");
			}
			if (userName != null && !"".equals(userName)) {
				sb1.append(" accountNo in ( select sys_id from t_park_account where user_id in (select sys_id from t_park_user where userName like '%" + userName + "%') ) and");
				sb2.append(" accountNo in ( select sys_id from t_park_account where user_id in (select sys_id from t_park_user where userName like '%" + userName + "%') ) and");
				sb3.append(" accountNo in ( select sys_id from t_park_account where user_id in (select sys_id from t_park_user where userName like '%" + userName + "%') ) and");
			}
			if (cardNo != null && !"".equals(cardNo)) {
				sb1.append(" cardNo like " + "'%" + cardNo + "%' and");
				sb2.append(" cardNo like " + "'%" + cardNo + "%' and");
				sb3.append(" cardNo like " + "'%" + cardNo + "%' and");
			}
			if (vehPlate != null && !"".equals(vehPlate)) {
				sb1.append(" vehPlate like '%" + vehPlate + "%' and");
				sb2.append(" vehPlate like '%" + vehPlate + "%' and");
				sb3.append(" vehPlate like '%" + vehPlate + "%' and");
				// sb.append(" accountNo in ( select sys_id from t_park_account where car_id in (select sys_id from t_park_car where vehPlate like %"+vehPlate+"%) ) and");
			}
			if (tradeType != null && !"".equals(tradeType)) {
				sb1.append(" tradeType=" + tradeType + " and");
				sb2.append(" tradeType=" + tradeType + " and");
				sb3.append(" tradeType=" + tradeType + " and");
			}
			sb1 = sb1.replace(sb1.length() - 4, sb1.length(), "");
			sb2 = sb2.replace(sb2.length() - 4, sb2.length(), "");
			sb3 = sb3.replace(sb3.length() - 4, sb3.length(), "");
			sql = sb1.toString().trim() + " union all " + sb2.toString().trim() + " union all " + sb3.toString().trim() + " order by opTime desc";
			/*
			 * sb4 = sb1.replace(0, 8, "select count(*)"); sb5 = sb2.replace(0,
			 * 8, "select count(*)"); sb6 = sb3.replace(0, 8,
			 * "select count(*)"); count = jdbcUtil.select(sb4.toString())
			 * +jdbcUtil
			 * .select(sb5.toString())+jdbcUtil.select(sb6.toString());// 统计数量
			 */}
		// pager.setTotalSize(count);
		// 要加上addScalar（）修改值类型，否则数据库中对应的字符串类型获取的是一个字符（hibernate的bug）。
		Query query = getSession().createSQLQuery(sql).addScalar("accountNo", Hibernate.INTEGER).addScalar("cardNo", Hibernate.STRING).addScalar("vehPlate", Hibernate.STRING).addScalar("tradeType", Hibernate.INTEGER).addScalar("OpTime", Hibernate.STRING).addScalar("tradeTime", Hibernate.STRING).addScalar("fee", Hibernate.INTEGER).addScalar("balance", Hibernate.INTEGER).addScalar("listNo", Hibernate.STRING).addScalar("seqNo", Hibernate.INTEGER).addScalar("operatorID", Hibernate.INTEGER).addScalar("operatorPassword", Hibernate.STRING).addScalar("verify", Hibernate.STRING).addScalar("cardType", Hibernate.INTEGER);
		query.setFirstResult(0);
		query.setMaxResults(10000);
		List list = query.list();
		List listTemp = new ArrayList();
		if (!list.isEmpty()) {
			for (int i = 0; i < list.size(); i++) {
				Object[] a = (Object[]) (list.get(i));
				if (Integer.valueOf(a[3].toString()) == 1 || Integer.valueOf(a[3].toString()) == 2) {
					validateVerify = this.deleteNull(Integer.valueOf(a[0].toString()), Integer.valueOf(a[9].toString()), Integer.valueOf(a[3].toString()), Integer.valueOf(a[6].toString()), Integer.valueOf(a[7].toString()), a[1].toString(), Integer.valueOf(a[13].toString()), null, a[8].toString(), Integer.valueOf(a[10].toString()), a[11].toString(), a[5].toString(), a[4].toString());
					validateVerify = HashUtil.getMD5String(validateVerify).trim();
				} else {
					validateVerify = this.deleteNull(Integer.valueOf(a[0].toString()), Integer.valueOf(a[9].toString()), Integer.valueOf(a[3].toString()), Integer.valueOf(a[6].toString()), Integer.valueOf(a[7].toString()), a[1].toString(), Integer.valueOf(a[13].toString()), a[2].toString(), a[8].toString(), Integer.valueOf(a[10].toString()), a[11].toString(), a[5].toString(), a[4].toString());
					validateVerify = HashUtil.getMD5String(validateVerify).trim();
				}
				Object[] b = new Object[18];
				for (int j = 0; j < 14; j++) {
					b[j] = a[j];
				}
				int sys_id = Integer.valueOf(a[0].toString());
				Account account = accountDao.getAccountBySysID(sys_id);
				if (account != null) {
					b[14] = account.getUser().getUserName();
					b[15] = account.getUser().getCredentialsNo();
					b[16] = account.getStatus();
				} else {
					b[14] = "此账户已不存在";
					b[15] = null;
					b[16] = null;
				}
				if (validateCheck.equals("validateAll")) {// 验证全部流水
					if (validateVerify.equals(b[12].toString())) {
						b[17] = "已通过效验_[" + account.getSys_id() + "_" + b[9].toString() + "]";
					} else {
						b[17] = "效验不通过_[" + account.getSys_id() + "_" + b[9].toString() + "]";
					}
					listTemp.add(b);
				} else if (validateCheck.equals("correct")) {// 验证通过的流水
					if (validateVerify.equals(b[12].toString())) {
						b[17] = "已通过效验_[" + account.getSys_id() + "_" + b[9].toString() + "]";
						listTemp.add(b);
					}
				} else if (validateCheck.equals("incorrect")) {// 验证不通过的流水
					if (!validateVerify.equals(b[12].toString())) {
						b[17] = "效验不通过_[" + account.getSys_id() + "_" + b[9].toString() + "]";
						listTemp.add(b);
					}
				}

			}

		}
		pager.setTotalSize(listTemp.size());
		int startIndex = (pager.getCurrentPage() - 1) * pager.getPageSize();
		int endIndex = pager.getPageSize();
		if (!listTemp.isEmpty()) {
			if (pager != null) {
				try {
					if (endIndex > listTemp.size()) {
						endIndex = listTemp.size();
						return listTemp.subList(startIndex, endIndex);

					} else if (startIndex >= endIndex) {
						endIndex = startIndex + endIndex;
						if (listTemp.size() >= endIndex) {
							return listTemp.subList(startIndex, endIndex);
						}
						if (listTemp.size() < endIndex) {
							endIndex = listTemp.size();
							return listTemp.subList(startIndex, endIndex);
						}

					} else {
						return listTemp.subList(startIndex, endIndex);
					}

				} catch (IndexOutOfBoundsException e) {
					e.printStackTrace();
				}

			}
		}
		return listTemp;
	}

	/*
	 * @SuppressWarnings("unchecked") public AccountTrade
	 * getAccountTradeByAccountNoOrderAndTradeType(int accountNo) {//
	 * 根据账号查交易流水表，并按序号降序排列 String hql =
	 * "from AccountTrade accountTrade where  accountTrade.account.sys_id=? and accountTrade.tradeType!=0 order by accountTrade.seqNo desc"
	 * ; List resultList = executeQuery(hql, accountNo); if
	 * (resultList.isEmpty()) return null; else return (AccountTrade)
	 * resultList.get(0);
	 * 
	 * }
	 */
	/*
	 * @SuppressWarnings("unchecked") public AccountTrade
	 * getAccountTradeByAccountNoAndSeqNo(int accountNo, int seqNo) {//
	 * 根据账号和序号查交易流水表，accountTrade.account.sys_id映射 String hql =
	 * "from AccountTrade accountTrade where  accountTrade.account.sys_id=? and accountTrade.seqNo=?"
	 * ; List resultList = executeQuery(hql, accountNo, seqNo); if
	 * (resultList.isEmpty()) return null; else return (AccountTrade)
	 * resultList.get(0);
	 * 
	 * }
	 */
	@SuppressWarnings("unchecked")
	public AccountTrade getAccountTradeByAccountNoAndTradeType(int accountNo, int tradeType) {// 根据账号和交易类型查询交易流水表
		String hql = "from AccountTrade accountTrade where  accountTrade.account.sys_id=? and accountTrade.tradeType=? order by accountTrade.seqNo desc";
		List resultList = executeQuery(hql, accountNo, tradeType);
		if (resultList.isEmpty())
			return null;
		else
			return (AccountTrade) resultList.get(0);

	}

	/*
	 * public String getMaxTradeTime(Integer accountNo) {//
	 * 根据账号查交易流水表中此账号最新交易时间，
	 * 以查询浙江大学的余额（浙江大学最新交易时间记录的余额就是当前余额，而富力城则是此账号的序号最大哪条记录的余额是当前余额）
	 * 
	 * String hql =
	 * "select max(tradeTime) from AccountTrade accountTrade where accountTrade.account.sys_id=? "
	 * ; String temp = (String) executeQuery(hql, accountNo).get(0); if (temp ==
	 * null) return null; else return temp;
	 * 
	 * }
	 */

	/*
	 * @SuppressWarnings("unchecked") public AccountTrade
	 * getAccountTradeByAccountNoAndTradeTime(int accountNo, String tradeTime)
	 * {// 根据最大时间和账号查交易流水表 String hql =
	 * "from AccountTrade accountTrade where  accountTrade.account.sys_id=? and accountTrade.tradeTime=?"
	 * ; List resultList = executeQuery(hql, accountNo, tradeTime); if
	 * (resultList.isEmpty()) return null; else return (AccountTrade)
	 * resultList.get(0);
	 * 
	 * }
	 */

}
