package com.hgsoft.dao;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.hgsoft.entity.Admin;
import com.hgsoft.entity.UserCardBill;
import com.hgsoft.entity.UserCardInfo;
import com.hgsoft.util.Pager;

@Repository
public class UserCardBillDao extends BaseDao<UserCardBill>{
	@SuppressWarnings("unchecked")
	public List<UserCardBill> getUserCardBillByRecNO(Pager pager, int recNo) {

		String hql = "from UserCardBill userCardBill where userCardBill.userRecNo= " + recNo;
		List<Object> obj = new ArrayList<Object>();
		Long count = executeCount(hql, obj.toArray());
		pager.setTotalSize(count);
		List resultList = this.executeQuery(pager, hql, obj.toArray());
		if (resultList.isEmpty()) {
			return null;
		} else {
			return resultList;
		}

	}
	@SuppressWarnings("unchecked")
	public UserCardBill getUserCardBillMaxEndTimeByRecNO(int recNo) {
		String hql = "from UserCardBill userCardBill where  userCardBill.userRecNo=? and userCardBill.endTime=(select max(userCardBillTemp.endTime) from UserCardBill userCardBillTemp where userCardBillTemp.userRecNo="+recNo+")";
		List resultList = executeQuery(hql, recNo);
		if (resultList.isEmpty()) {
			return null;
		} else {
			return (UserCardBill) resultList.get(0);
		}

	}

	@SuppressWarnings("unchecked")
	public List<Object[]> getAllUserCardBillByHql(Pager pager,String cardNo,String vehPlate,String owner) {
		List myList = new ArrayList();
		StringBuffer sf = new StringBuffer("from UserCardInfo userCardInfo,UserCardBill userCardBill where");
		List<Object> obj = new ArrayList<Object>();
		if (!"".equals(cardNo)) {

			sf.append(" userCardInfo.cardNo like? and");
			obj.add("%" + cardNo + "%");
		}
		if (!"".equals(vehPlate)) {

			sf.append(" userCardInfo.vehPlate like? and");
			obj.add("%" + vehPlate + "%");
		}
		if (!"".equals(owner)) {

			sf.append(" userCardInfo.owner like? and");
			obj.add("%" + owner + "%");
		}
		// 查出总行数，对分页进行设置
		// System.out.println(sf.toString()+"obj"+obj.get(0));
		Long count = executeCount(sf.toString()+" userCardInfo.recNO=userCardBill.userRecNo", obj.toArray());
		pager.setTotalSize(count);
		List list1 = this.executeQuery(pager, sf.toString()+" userCardInfo.recNO=userCardBill.userRecNo order by userCardBill.opTime desc", obj.toArray());
		Iterator iterator1 = list1.iterator();
		while (iterator1.hasNext()) {
			Object[] o = (Object[]) iterator1.next();
			UserCardInfo userCardInfo = (UserCardInfo) o[0];
			UserCardBill userCardBill = (UserCardBill) o[1];
			Object ay = new Object[] { userCardInfo, userCardBill };
			myList.add(ay);
		}

		return myList;
		
	}
	@SuppressWarnings("unchecked")
	public List<Object[]> getAllUserCardBill(Pager pager) {
		List myList = new ArrayList();
		StringBuffer sf = new StringBuffer("from UserCardInfo userCardInfo,UserCardBill userCardBill where userCardInfo.recNO=userCardBill.userRecNo");
		List<Object> obj = new ArrayList<Object>();
		// 查出总行数，对分页进行设置
		// System.out.println(sf.toString()+"obj"+obj.get(0));
		Long count = executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
		List list1 = this.executeQuery(pager, sf.toString()+" order by userCardBill.opTime desc", obj.toArray());
		Iterator iterator1 = list1.iterator();
		while (iterator1.hasNext()) {
			Object[] o = (Object[]) iterator1.next();
			UserCardInfo userCardInfo = (UserCardInfo) o[0];
			UserCardBill userCardBill = (UserCardBill) o[1];
			Object ay = new Object[] { userCardInfo, userCardBill };
			myList.add(ay);
		}
		return myList;
		
	}
	public long getSumMoney(){
		String hql = "select sum(userCardBill.money) from UserCardBill userCardBill";
		if(executeQuery(hql).get(0) == null){
			return 0;
		} else{
			return (Long)executeQuery(hql).get(0);
		}	
		
	}
	public Timestamp getMaxPayEndTimeByRecNO(int recNo){
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		Date dateTemp = new Date();
		cal.setTime(dateTemp);
		cal.add(Calendar.DAY_OF_MONTH, -1);			
		String time = df.format(cal.getTime());
		time = time + " 00:00:00";
		Timestamp ts = Timestamp.valueOf(time);
		String hql ="select max(userCardBill.endTime) from UserCardBill userCardBill where userCardBill.userRecNo= " + recNo;
		if(executeQuery(hql).get(0)==null){
			return ts;
		} else{
			return (Timestamp)executeQuery(hql).get(0);
		}	
	}
	@SuppressWarnings("unchecked")
	public long getSumMoneyByHql(String cardNo,String vehPlate,String owner){
		StringBuffer sf = new StringBuffer( "select sum(userCardBill.money) from UserCardInfo userCardInfo,UserCardBill userCardBill where");
		List<Object> obj = new ArrayList<Object>();
	
		if (!"".equals(cardNo)&&cardNo!=null) {
			sf.append(" userCardInfo.cardNo like? and");
			obj.add("%" + cardNo + "%");
		}
		if (!"".equals(vehPlate)&&vehPlate!=null) {
			sf.append(" userCardInfo.vehPlate like? and");
			obj.add("%" + vehPlate + "%");
		}
		if (!"".equals(owner)&&owner!=null) {
			sf.append(" userCardInfo.owner like? and");
			obj.add("%" + owner + "%");
		}
		String hql =sf.toString()+" userCardInfo.recNO=userCardBill.userRecNo";
		List list=executeQuery(hql,obj.toArray());
		if(list.get(0) == null){
			return 0;
		} else{
			return (Long)list.get(0);
		}				
	}
	
	@SuppressWarnings("unchecked")
	public List<UserCardInfo> findAllItemByHql(Pager pager, String cardNo, Short status, Short userType, String vehPlate,String owner, String idcard, Short feeRuleType,String whtherPayType) {		
		StringBuffer sf = new StringBuffer("from UserCardInfo userCardInfo where");// 查询，多条件查询，先判断是不是空，为空时不加入查询条件，否则添加
		List<Object> obj = new ArrayList<Object>();
		if (!"".equals(cardNo)) {
			sf.append(" userCardInfo.cardNo like? and");
			obj.add("%" + cardNo + "%");
		}
		if(status !=null){
			sf.append(" userCardInfo.status=? and");
			obj.add(status);
		}
		if (!whtherPayType.equals("1")) {
			if (userType != null) {
				sf.append(" userCardInfo.userType=? and");
				obj.add(userType);
			}
		} else {
			if (userType != null) {
				sf.append(" userCardInfo.realUserType=? and");
				obj.add(userType.intValue());
			}
		}

		if (!"".equals(vehPlate)) {
			sf.append(" userCardInfo.vehPlate like ? and");
			obj.add("%" + vehPlate + "%");
		}
		if (!"".equals(owner)) {
			sf.append(" userCardInfo.owner like ? and");
			obj.add("%" + owner + "%");
		}
		if (!"".equals(idcard)) {
			sf.append(" userCardInfo.idcard like ? and");
			obj.add("%" + idcard + "%");
		}
		if (feeRuleType != null) {
			sf.append(" userCardInfo.feeRuleType=? and");
			obj.add(feeRuleType);
		}		
		sf = sf.replace(sf.length() - 4, sf.length(), "");
		// 查出总行数，对分页进行设置
		// System.out.println(sf.toString()+"obj"+obj.get(0));

		Long count = executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
		return this.executeQuery(pager, sf.toString(), obj.toArray());
	}
	@SuppressWarnings("unchecked")
	public List<Admin> getAllAdmin() {
		String hql = "from Admin admin";
		List<Admin> resultList = executeQuery(hql);
		if(resultList.isEmpty()) {
			return null;
		} else {
			return resultList;
		}
	}
	@SuppressWarnings("unchecked")
	public UserCardBill getUserCardBillByRecNOAndOptime(int recNo,Timestamp opTime) {
		String hql = "from UserCardBill userCardBill where  userCardBill.userRecNo=? and userCardBill.opTime='"+opTime+"'";
		List resultList = executeQuery(hql, recNo);
		if (resultList.isEmpty()) {
			return null;
		} else {
			return (UserCardBill) resultList.get(0);
		}

	}
	public void deleteByUserRecNo(int userRecNo) {
		String hql = "delete from UserCardBill userCardBill where  userCardBill.userRecNo=?";
		Query q = getSession().createQuery(hql) ;
        q.setInteger(0, userRecNo) ;
        q.executeUpdate() ;		
	}
	

}
