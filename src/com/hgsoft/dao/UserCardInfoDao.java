package com.hgsoft.dao;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.hgsoft.entity.UserCardInfo;
import com.hgsoft.util.JdbcUtil;
import com.hgsoft.util.Pager;

@Repository
public class UserCardInfoDao extends BaseDao<UserCardInfo> {
	@Resource
	private JdbcUtil jdbcUtil;
	@SuppressWarnings("unchecked")
	public UserCardInfo getUserCardInfoByCardNo(String cardNo) {
		String hql = "from UserCardInfo userCardInfo where  userCardInfo.cardNo=?";
		List resultList = executeQuery(hql, cardNo);
		if (resultList.isEmpty()) {
			return null;
		} else {
			return (UserCardInfo) resultList.get(0);
		}

	}
	@SuppressWarnings("unchecked")
	public UserCardInfo getUserCardInfoByVehPlate(String vehPlate) {
		String hql = "from UserCardInfo userCardInfo where  userCardInfo.vehPlate=?";
		List resultList = executeQuery(hql, vehPlate);
		if (resultList.isEmpty()) {
			return null;
		} else {
			return (UserCardInfo) resultList.get(0);
		}

	}
	@SuppressWarnings("unchecked")
	public UserCardInfo getUserCardInfoByRecNO(Integer recNO) {
		String hql = "from UserCardInfo userCardInfo where  userCardInfo.recNO=?";
		List resultList = executeQuery(hql, recNO);
		if (resultList.isEmpty()) {
			return null;
		} else {
			return (UserCardInfo) resultList.get(0);
		}

	}
	@SuppressWarnings("unchecked")
	public List<UserCardInfo> findAllItemByHql(Pager pager, String cardNo, Short status, Short userCardType, String vehPlate,String owner, String idcard, Short feeRuleType,String whtherPayType,Timestamp payEndTimestamp,String mobileNumber,Integer carType,String parkingSpace, Integer ownerIdentity) {		
		StringBuffer sf = new StringBuffer("from UserCardInfo userCardInfo where");// 查询，多条件查询，先判断是不是空，为空时不加入查询条件，否则添加
		List<Object> obj = new ArrayList<Object>();
		if (!"".equals(cardNo) && null != cardNo) {
			sf.append(" userCardInfo.cardNo like? and");
			obj.add("%" + cardNo + "%");
		}
		if(!"".equals(status) && null != status){
			sf.append(" userCardInfo.status=? and");
			obj.add(status);
		}
		
		if (!"".equals(userCardType) && null != userCardType) {
		    sf.append(" userCardInfo.userCardType=? and");
			obj.add(userCardType);
		}
		
		if (!"".equals(vehPlate) && null != vehPlate) {
			sf.append(" userCardInfo.vehPlate like ? and");
			obj.add("%" + vehPlate + "%");
		}
		if (!"".equals(owner) && null != owner) {
			sf.append(" userCardInfo.owner like ? and");
			obj.add("%" + owner + "%");
		}
		if (!"".equals(idcard) && null != idcard) {
			sf.append(" userCardInfo.idcard like ? and");
			obj.add("%" + idcard + "%");
		}
		if (!"".equals(feeRuleType) && null != feeRuleType) {
			sf.append(" userCardInfo.feeRuleType=? and");
			obj.add(feeRuleType);			
		}	
		if (!"".equals(payEndTimestamp) && payEndTimestamp != null) {
			sf.append(" userCardInfo.userCardType=14 and");
			sf.append(" userCardInfo.payEndTime<=? and");
			obj.add(payEndTimestamp);
		}
		if (!"".equals(mobileNumber) && null != mobileNumber) {
			sf.append(" userCardInfo.mobileNumber like ? and");
			obj.add("%" + mobileNumber + "%");
		}
		if(!"".equals(carType) && null != carType) {
			sf.append(" userCardInfo.carType = ? and");
			obj.add(carType);
		}
		if(!"".equals(parkingSpace) && null != parkingSpace) {
			sf.append(" userCardInfo.parkingSpace = ? and");
			obj.add(parkingSpace);
		}
		if(!"".equals(ownerIdentity) && null != ownerIdentity) {
			sf.append(" userCardInfo.ownerIdentity =? and");
			obj.add(ownerIdentity);
		}
		if(obj.isEmpty()){
			sf = sf.replace(sf.length() - 5, sf.length(), "");
		}else{
			sf = sf.replace(sf.length() - 4, sf.length(), "");
		}
		Long count = executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
		sf.append(" order by userCardInfo.recNO desc");
		return this.executeQuery(pager, sf.toString(), obj.toArray());
	}
	
	@SuppressWarnings("unchecked")
	public List<UserCardInfo> findAllItemByHqlToPayment(Pager pager, String cardNo, Short status, Short userCardType, String vehPlate,String owner, String idcard, Short feeRuleType,String whtherPayType,Timestamp payEndTimesStarttamp,Timestamp payEndTimestamp,String mobileNumber,Integer carType, String parkingSpace, Integer ownerIdentity) {		
		StringBuffer sf = new StringBuffer("from UserCardInfo userCardInfo where");// 查询，多条件查询，先判断是不是空，为空时不加入查询条件，否则添加
		List<Object> obj = new ArrayList<Object>();
		if (!"".equals(cardNo) && null != cardNo) {
			sf.append(" userCardInfo.cardNo like? and");
			obj.add("%" + cardNo + "%");
		}
		if(!"".equals(status) && null != status){
			sf.append(" userCardInfo.status=? and");
			obj.add(status);
		}
		
		if (!"".equals(userCardType) && null != userCardType) {
		    sf.append(" userCardInfo.userCardType=? and");
			obj.add(userCardType);
		}
		
		if (!"".equals(vehPlate) && null != vehPlate) {
			sf.append(" userCardInfo.vehPlate like ? and");
			obj.add("%" + vehPlate + "%");
		}
		if (!"".equals(owner) && null != owner) {
			sf.append(" userCardInfo.owner like ? and");
			obj.add("%" + owner + "%");
		}
		if (!"".equals(idcard) && null != idcard) {
			sf.append(" userCardInfo.idcard like ? and");
			obj.add("%" + idcard + "%");
		}
		if (!"".equals(feeRuleType) && null != feeRuleType) {
			sf.append(" userCardInfo.feeRuleType=? and");
			obj.add(feeRuleType);			
		}
		if (!"".equals(payEndTimesStarttamp) && payEndTimesStarttamp != null) {
			sf.append(" userCardInfo.userCardType=14 and");
			sf.append(" userCardInfo.payEndTime>=? and");
			obj.add(payEndTimesStarttamp);
		}		
		if (!"".equals(payEndTimestamp) && payEndTimestamp != null) {
			sf.append(" userCardInfo.userCardType=14 and");
			sf.append(" userCardInfo.payEndTime<=? and");
			obj.add(payEndTimestamp);
		}
		if (!"".equals(mobileNumber) && null != mobileNumber) {
			sf.append(" userCardInfo.mobileNumber like ? and");
			obj.add("%" + mobileNumber + "%");
		}
		if (!"".equals(carType) && null != carType) {
			sf.append(" userCardInfo.carType=? and");
			obj.add(carType);			
		}
		if (!"".equals(parkingSpace) && null != parkingSpace) {
			sf.append(" userCardInfo.parkingSpace=? and");
			obj.add(parkingSpace);			
		}
		if (!"".equals(ownerIdentity) && null != ownerIdentity) {
			sf.append(" userCardInfo.ownerIdentity=? and");
			obj.add(ownerIdentity);			
		}
		
		if(obj.isEmpty()){
			sf = sf.replace(sf.length() - 5, sf.length(), "");
		}else{
			sf = sf.replace(sf.length() - 4, sf.length(), "");
		}
		if(pager!=null){
			Long count = executeCount(sf.toString(), obj.toArray());
			pager.setTotalSize(count);
			sf.append(" order by userCardInfo.recNO desc");
			return this.executeQuery(pager, sf.toString(), obj.toArray());
		}else{			
			sf.append(" order by userCardInfo.recNO desc");
			return this.executeQuery(sf.toString(), obj.toArray());
		}
		
	}
	public Long countFindAllItemByHqlToPayment(String cardNo, Short status, Short userCardType, String vehPlate,String owner, String idcard, Short feeRuleType,String whtherPayType,Timestamp payEndTimesStarttamp,Timestamp payEndTimestamp,String mobileNumber,Integer carType, String parkingSpace, Integer ownerIdentity) {		
		StringBuffer sf = new StringBuffer("from UserCardInfo userCardInfo where");// 查询，多条件查询，先判断是不是空，为空时不加入查询条件，否则添加
		List<Object> obj = new ArrayList<Object>();
		if (!"".equals(cardNo) && null != cardNo) {
			sf.append(" userCardInfo.cardNo like? and");
			obj.add("%" + cardNo + "%");
		}
		if(!"".equals(status) && null != status){
			sf.append(" userCardInfo.status=? and");
			obj.add(status);
		}
		
		if (!"".equals(userCardType) && null != userCardType) {
		    sf.append(" userCardInfo.userCardType=? and");
			obj.add(userCardType);
		}
		
		if (!"".equals(vehPlate) && null != vehPlate) {
			sf.append(" userCardInfo.vehPlate like ? and");
			obj.add("%" + vehPlate + "%");
		}
		if (!"".equals(owner) && null != owner) {
			sf.append(" userCardInfo.owner like ? and");
			obj.add("%" + owner + "%");
		}
		if (!"".equals(idcard) && null != idcard) {
			sf.append(" userCardInfo.idcard like ? and");
			obj.add("%" + idcard + "%");
		}
		if (!"".equals(feeRuleType) && null != feeRuleType) {
			sf.append(" userCardInfo.feeRuleType=? and");
			obj.add(feeRuleType);			
		}
		if (!"".equals(payEndTimesStarttamp) && payEndTimesStarttamp != null) {
			sf.append(" userCardInfo.userCardType=14 and");
			sf.append(" userCardInfo.payEndTime>=? and");
			obj.add(payEndTimesStarttamp);
		}		
		if (!"".equals(payEndTimestamp) && payEndTimestamp != null) {
			sf.append(" userCardInfo.userCardType=14 and");
			sf.append(" userCardInfo.payEndTime<=? and");
			obj.add(payEndTimestamp);
		}
		if (!"".equals(mobileNumber) && null != mobileNumber) {
			sf.append(" userCardInfo.mobileNumber like ? and");
			obj.add("%" + mobileNumber + "%");
		}
		if (!"".equals(carType) && null != carType) {
			sf.append(" userCardInfo.carType=? and");
			obj.add(carType);			
		}
		if (!"".equals(parkingSpace) && null != parkingSpace) {
			sf.append(" userCardInfo.parkingSpace=? and");
			obj.add(parkingSpace);			
		}
		if (!"".equals(ownerIdentity) && null != ownerIdentity) {
			sf.append(" userCardInfo.ownerIdentity=? and");
			obj.add(ownerIdentity);			
		}
		if(obj.isEmpty()){
			sf = sf.replace(sf.length() - 5, sf.length(), "");
		}else{
			sf = sf.replace(sf.length() - 4, sf.length(), "");
		}		
		Long count = executeCount(sf.toString(), obj.toArray());	
		return count;
	}
	
	public Integer getMaxRecNO() {
		String sql="SELECT max(RecNO) FROM tb_UserCardInfo";
		return jdbcUtil.select(sql)+1;
	}
	
	@SuppressWarnings("unchecked")
	public List<UserCardInfo> findItemByHql(Pager pager,String cardNo,String vehPlate,String groupName ,String isGroup,Short userCardType,String whtherPayType) {		
		StringBuffer sf = new StringBuffer("from UserCardInfo userCardInfo where");// 查询，多条件查询，先判断是不是空，为空时不加入查询条件，否则添加
		List<Object> obj = new ArrayList<Object>();
		if (!"".equals(cardNo)) {
			sf.append(" userCardInfo.cardNo like? and");
			obj.add("%" + cardNo + "%");
		}
		if (!"".equals(vehPlate)) {
			sf.append(" userCardInfo.vehPlate like? and");
			obj.add("%" + vehPlate + "%");
		}
		if (userCardType != null) {
			sf.append(" userCardInfo.userCardType=? and");
			obj.add(userCardType);
		}
		if (!groupName.equals("")) {
			sf.append(" userCardInfo.userCardType=15 and userCardInfo.cardNo in(select cardGroup.cardNo from CardGroup cardGroup where cardGroup.groupNo in (select cardGroupInfo.groupNo from CardGroupInfo  cardGroupInfo where cardGroupInfo.groupName like?)) and");
			obj.add("%" + groupName + "%");
		}else{
			if (isGroup != null) {
				sf.append(" userCardInfo.userCardType=15 and userCardInfo.cardNo not in(select cardGroup.cardNo from CardGroup cardGroup where cardGroup.laneGroupNo=1 and cardGroup.groupNo in(select cardGroupInfo.groupNo from  CardGroupInfo cardGroupInfo where cardGroupInfo.laneGroupNo=?) ) and");
				obj.add(1);
			  }
			}
		if(obj.isEmpty()){
			sf = sf.replace(sf.length() - 5, sf.length(), "");
		}else{
			sf = sf.replace(sf.length() - 4, sf.length(), "");
		}
		Long count = executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
		return this.executeQuery(pager, sf.toString(), obj.toArray());
	}
	@SuppressWarnings("unchecked")
	public List findAllUserCardInfoHistoryBySql(Pager pager, Integer recNo,String cardNo, Short status, Short userCardType, String vehPlate,String owner, String idcard, Short feeRuleType,Timestamp modifyTime,Timestamp exactModifyTime, Integer carType, String parkingSpace, Integer ownerIdentity) {		
		StringBuffer sb = new StringBuffer("select * from tb_UserCardInfoHistory where");		
		if (!"".equals(recNo) && null != recNo) {
			sb.append(" RecNO ="+ recNo+"  and");		
		}
		if (!"".equals(cardNo) && null != cardNo) {
			sb.append(" CardNo like '%"+ cardNo+"%'  and");
		}
		if(!"".equals(status) && null != status){
			sb.append(" Status ="+ status+"  and");	
		}
		
		if (!"".equals(userCardType) && null != userCardType) {
			sb.append(" UserCardType ="+ userCardType+"  and");	
		}
		
		if (!"".equals(vehPlate) && null != vehPlate) {
			sb.append(" VehPlate like '%"+ vehPlate+"%'  and");
		}
		if (!"".equals(owner) && null != owner) {
			sb.append(" Owner like '%"+ owner+"%'  and");
		}
		if (!"".equals(idcard) && null != idcard) {
			sb.append(" IDCard like '%"+ idcard+"%'  and");
		}
		if (!"".equals(feeRuleType) && null != feeRuleType) {
			sb.append(" FeeRuleType ="+ feeRuleType+"  and");				
		}	
		if (!"".equals(modifyTime) && modifyTime != null) {
			sb.append(" ModifyTime <='"+ modifyTime+"'  and");	
		}
		if (!"".equals(exactModifyTime) && exactModifyTime != null) {
			sb.append(" ModifyTime ='"+ exactModifyTime+"'  and");	
		}
		if (!"".equals(carType) && null != carType) {
			sb.append(" carType ="+ carType+"  and");	
		}
		if (!"".equals(parkingSpace) && null != parkingSpace) {
			sb.append(" parkingSpace ="+ parkingSpace+"  and");	
		}
		if (!"".equals(ownerIdentity) && null != ownerIdentity) {
			sb.append(" ownerIdentity ="+ ownerIdentity+"  and");	
		}
		sb = sb.replace(sb.length() - 5, sb.length(), "");
		String sql = sb.toString().trim()+" order by ModifyTime asc";
		StringBuffer sb1 = sb.replace(0, 8, "select count(*)");
		String sqlCount = sb1.toString();
		int count = jdbcUtil.select(sqlCount);// 统计数量	
		pager.setTotalSize(count);
		// 要加上addScalar（）修改值类型，否则数据库中对应的字符串类型获取的是一个字符（hibernate的bug）。		
		Query query = getSession().createSQLQuery(sql).addScalar("RecNO", Hibernate.INTEGER).addScalar("Owner", Hibernate.STRING).addScalar("IDCard", Hibernate.STRING).addScalar("VehPlate", Hibernate.STRING)
		.addScalar("ParkingSpace", Hibernate.STRING).addScalar("OBU", Hibernate.STRING).addScalar("RegisterTime", Hibernate.STRING).addScalar("Status", Hibernate.INTEGER).addScalar("Deposit", Hibernate.INTEGER)
		.addScalar("CardNO", Hibernate.STRING).addScalar("UserCardType", Hibernate.INTEGER).addScalar("ModifyTime", Hibernate.STRING).addScalar("FeeRuleType", Hibernate.INTEGER).addScalar("RoomNo", Hibernate.STRING)
		.addScalar("TelePhone", Hibernate.STRING).addScalar("PayEndTime", Hibernate.STRING).addScalar("MobileNumber", Hibernate.STRING).addScalar("Address", Hibernate.STRING).addScalar("StaffNo", Hibernate.STRING)
		.addScalar("VehBrand", Hibernate.STRING).addScalar("LinkMan", Hibernate.STRING).addScalar("Remark", Hibernate.STRING).addScalar("OwnerIdentity", Hibernate.INTEGER).addScalar("CarType", Hibernate.INTEGER);
		if (pager != null) {
			query.setFirstResult((pager.getCurrentPage() - 1) * pager.getPageSize());
			query.setMaxResults(pager.getPageSize());
		}
		return query.list();

		
	}
	public void updateExtendPayEndTimeAffirm(int recNo,int extendPayEndTime){//延长缴费期限需要update的函数
		String sql = "update tb_UserCardBill set EndTime= EndTime+"+extendPayEndTime+"where UserRecNO = "+recNo+" and EndTime=(SELECT MAX(EndTime)  FROM tb_UserCardBill where UserRecNO="+recNo+")";
		String sql1 = "update tb_UserCardInfo set Status=9 where RecNO="+recNo+" and Status =0 and CONVERT(CHAR(10), GETDATE(), 120)>(SELECT MAX(EndTime) FROM tb_UserCardBill where UserRecNO="+recNo+")";	
		String sql2 = "update tb_UserCardInfo set Status=0 where RecNO="+recNo+"and Status =9 and CONVERT(CHAR(10), GETDATE(), 120)<=(SELECT MAX(EndTime) FROM tb_UserCardBill where UserRecNO="+recNo+")";
		String sql3 = "update tb_UserCardInfo set PayEndTime=(SELECT isnull(MAX(EndTime),getdate()-1)FROM tb_UserCardBill where UserRecNO="+recNo+") where UserCardType!=13 and RecNO="+recNo;
		jdbcUtil.update(sql);//修改tb_UserCardBill这个表中最大endtime
		jdbcUtil.update(sql1);//修改tb_UserCardInfo表中的状态“正常”修改为"未缴费"（extendPayEndTime有可能是负数和延长的天数加起来还没大过当前时间设置状态为‘未缴费 ‘）
		jdbcUtil.update(sql2);//修改tb_UserCardInfo表中的状态"未缴费"修改为“正常”（延长天数后endtime大于当前时间）
		jdbcUtil.update(sql3);//修改tb_UserCardInfo中的缴费期限值为其tb_UserCardBill中的最大endtime
	}
	
	/**
	 * 用于判断车辆类型、停车位信息是否已在校园卡信息表中使用（删除车辆类型、停车位时判断）
	 * 2013-12-02
	 * */
	public List findUserCarInfoByCarType(Integer carType, Integer carSmallType){
		String hql = " from UserCardInfo userCardInfo where 1=1 ";
		if(carType!=null && !carType.equals("")){
			hql+=" and userCardInfo.carType="+carType;
			if(carSmallType!=null && !carSmallType.equals("")){
				hql+=" and userCardInfo.parkingSpace='"+carSmallType+"'";
			}
		}
		List list = executeQuery(hql);
		if(list!=null && list.size()>0){
			return list;
		}else{
			return null;
		}
	}

}
