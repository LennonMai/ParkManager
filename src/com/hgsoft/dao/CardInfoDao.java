package com.hgsoft.dao;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.hgsoft.entity.CardInfo;
import com.hgsoft.entity.CardType;
import com.hgsoft.util.JdbcUtil;
import com.hgsoft.util.Pager;

@Repository
public class CardInfoDao extends BaseDao<CardInfo>{
	@Resource
	private JdbcUtil jdbcUtil;
	@SuppressWarnings("unchecked")
	public List<Object[]> getAllCardInfoAndCardType(Pager pager) {
		List myList = new ArrayList();
		String hql = "from CardInfo cardInfo,CardType cardTypeTable where cardInfo.cardType=cardTypeTable.cardType";
		List<Object> obj = new ArrayList<Object>();
		Long count = executeCount(hql, obj.toArray());
		pager.setTotalSize(count);
		List resultList = this.executeQuery(pager, hql, obj.toArray());
		Iterator iterator = resultList.iterator();
		while (iterator.hasNext()) {
			Object[] o = (Object[]) iterator.next();
			CardInfo cardInfo = (CardInfo) o[0];
			CardType cardTypeTable = (CardType) o[1];
			Object ay = new Object[] { cardInfo, cardTypeTable };
			myList.add(ay);
		}

		return myList;
	}
	
	@SuppressWarnings("unchecked")
	public List<Object[]> findAllItemByHql(Pager pager, String cardNo,Short cardType,Short status,Short userCardType) {
		
		List myList = new ArrayList();
		StringBuffer sf = new StringBuffer(" from CardInfo cardInfo,CardType cardTypeTable where "); 
		List<Object> obj = new ArrayList<Object>();
		if (!"".equals(cardNo)) {

			sf.append(" cardInfo.cardNo like? and");
			obj.add("%" + cardNo + "%");
		}

		
		if (cardType != null) {
			sf.append(" cardInfo.cardType =? and");

			obj.add(cardType);

		}
		if (status != null) {
			sf.append(" cardInfo.status =? and");

			obj.add(status);

		}
		if (userCardType != null) {
			sf.append(" cardInfo.userCardType =? and");

			obj.add(userCardType);

		}
		sf.append(" cardInfo.cardType=cardTypeTable.cardType ");
		
		// 查出总行数，对分页进行设置
		Long count = executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
		List list = this.executeQuery(pager, sf.toString(), obj.toArray());
		Iterator iterator = list.iterator();
		while (iterator.hasNext()) {
			Object[] o = (Object[]) iterator.next();
			CardInfo cardInfo = (CardInfo) o[0];
			CardType cardTypeTable = (CardType) o[1];
			Object ay = new Object[] { cardInfo, cardTypeTable };
			myList.add(ay);
		}

		return myList;
	}
	@SuppressWarnings("unchecked")
	public CardInfo getCardInfoByCardNo(String cardNo) {
		String hql = "from CardInfo cardInfo where  cardInfo.cardNo=?";
		List resultList = executeQuery(hql, cardNo);
		if (resultList.isEmpty()) {
			return null;
		} else {
			return (CardInfo) resultList.get(0);
		}

	}
	public int getCardAmountByTypeName(String typeName){
		String sql = "select count(c.CardNo) from tb_CardInfo as c,tb_CardType as ct where c.CardType=ct.CardType and ct.TypeName='"+typeName+"'";
		return jdbcUtil.select(sql);
	}

	//caijunhua IC卡库存统计
	public int getTypeStatistics(int type) {
		String sql = "select count(*) from tb_CardInfo where UserCardType=" + type;
		return jdbcUtil.select(sql);
	}
	
	public int getStatusStatistics(int status) {
		String  sql = "select count(*) from tb_CardInfo where Status=" + status;
		return jdbcUtil.select(sql);
	}
	
	//查询白名单     曾
	@SuppressWarnings("unchecked")
	public List<Object[]> queryWhite(Pager pager,String cardNo,String vehplate,String obuId,String cardType,String status,String ownerName,String isImage,String feeRuleType){
		StringBuffer conditon = new StringBuffer(0);
		if(null != cardNo && !cardNo.equals("")){
			conditon.append("CardNo like '%"+cardNo+"%' and ");
		}
		if(null != vehplate && !vehplate.equals("")){
			conditon.append("Vehplate like '%"+vehplate+"%' and ");
		}
		if(null != obuId && !obuId.equals("")){
			conditon.append("obuId like '%"+obuId+"%' and ");
		}
		if(null != cardType && !cardType.equals("")){
			conditon.append("cardType="+cardType+" and ");
		}
		if(null != status && !status.equals("")){
			conditon.append("status="+status+" and ");
		}
		if(null != ownerName && !ownerName.equals("")){
			conditon.append("ownerName like '%"+ownerName+"%' and ");
		}
		if(null != isImage && !isImage.equals("")){
			conditon.append("HasVehPic="+isImage+" and ");
		}
		if(null != feeRuleType && !feeRuleType.equals("")){
			conditon.append("feeRuleType="+feeRuleType+" and ");
		}
		String conditonStr = conditon.toString();
		if(conditonStr.length()>0){
			int count = jdbcUtil.select("select count(*) from v_whiteList where " + conditonStr.substring(0, conditonStr.length()-4));
			pager.setTotalSize(count);
			String sql = "select * from v_whiteList where " + conditonStr.substring(0, conditonStr.length()-4);
			// 要加上addScalar（）修改值类型，否则数据库中对应的字符串类型获取的是一个字符（hibernate的bug）。
			Query query = getSession().createSQLQuery(sql)
				.addScalar("CardNO", Hibernate.STRING)
				.addScalar("VehPlate", Hibernate.STRING)
				.addScalar("OwnerName", Hibernate.STRING)
				.addScalar("OBUID", Hibernate.STRING)
				.addScalar("FirTime", Hibernate.DATE)
				.addScalar("InvaliDateTime", Hibernate.DATE)
				.addScalar("CARDTYPE", Hibernate.INTEGER)
				.addScalar("Status", Hibernate.INTEGER)
				.addScalar("HasVehPic", Hibernate.INTEGER)
				.addScalar("FeeRuleType", Hibernate.INTEGER);
			if (pager != null) {
				query.setFirstResult((pager.getCurrentPage() - 1) * pager.getPageSize());
				query.setMaxResults(pager.getPageSize());
			}
			return query.list();
			//list = jdbcUtil.selectForList("select CardNO,VehPlate,OwnerName,OBUID,FirTime,InvaliDateTime,CARDTYPE,Status,HasVehPic,FeeRuleType from v_whiteList where " + conditonStr.substring(0, conditonStr.length()-4));
		}else{
			int count = jdbcUtil.select("select count(*) from v_whiteList");
			pager.setTotalSize(count);
			// 要加上addScalar（）修改值类型，否则数据库中对应的字符串类型获取的是一个字符（hibernate的bug）。
			Query query = getSession().createSQLQuery("select * from v_whiteList")
				.addScalar("CardNO", Hibernate.STRING)
				.addScalar("VehPlate", Hibernate.STRING)
				.addScalar("OwnerName", Hibernate.STRING)
				.addScalar("OBUID", Hibernate.STRING)
				.addScalar("FirTime", Hibernate.DATE)
				.addScalar("InvaliDateTime", Hibernate.DATE)
				.addScalar("CARDTYPE", Hibernate.INTEGER)
				.addScalar("Status", Hibernate.INTEGER)
				.addScalar("HasVehPic", Hibernate.INTEGER)
				.addScalar("FeeRuleType", Hibernate.INTEGER);
			if (pager != null) {
				query.setFirstResult((pager.getCurrentPage() - 1) * pager.getPageSize());
				query.setMaxResults(pager.getPageSize());
			}
			return query.list();
		}
	}
	//导出白名单 曾
	@SuppressWarnings("unchecked")
	public List<Object[]>exportWhite(String cardNo,String vehplate,String obuId,String cardType,String status,String ownerName,String isImage,String feeRuleType){
		StringBuffer conditon = new StringBuffer(0);
		List<Object[]> list = new ArrayList<Object[]>();
		if(null != cardNo && !cardNo.equals("")){
			conditon.append("CardNo like '%"+cardNo+"%' and ");
		}
		if(null != vehplate && !vehplate.equals("")){
			conditon.append("Vehplate like '%"+vehplate+"%' and ");
		}
		if(null != obuId && !obuId.equals("")){
			conditon.append("obuId like '%"+obuId+"%' and ");
		}
		if(null != cardType && !cardType.equals("")){
			conditon.append("cardType="+cardType+" and ");
		}
		if(null != status && !status.equals("")){
			conditon.append("status="+status+" and ");
		}
		if(null != ownerName && !ownerName.equals("")){
			conditon.append("ownerName like '%"+ownerName+"%' and ");
		}
		if(null != isImage && !isImage.equals("")){
			conditon.append("HasVehPic="+isImage+" and ");
		}
		if(null != feeRuleType && !feeRuleType.equals("")){
			conditon.append("feeRuleType="+feeRuleType+" and ");
		}
		String conditonStr = conditon.toString();
		if(conditonStr.length()>0){
			String sql = "select CardNo,VehPlate,OwnerName,OBUID,FirTime,InvaliDateTime,CARDTYPE,Status,HasVehPic,FeeRuleType from v_whiteList where " + conditonStr.substring(0, conditonStr.length()-4);
			list = jdbcUtil.selectForList(sql);
		}else{
			String sql = "select CardNo,VehPlate,OwnerName,OBUID,FirTime,InvaliDateTime,CARDTYPE,Status,HasVehPic,FeeRuleType from v_whiteList";
			list = jdbcUtil.selectForList(sql);
		}
		return list;
	}
	
	/**
	 * 导出白名单(用户卡信息表)
	 * */
	@SuppressWarnings("unchecked")
	public List<Object[]>exportWhite(String fileds, Map map){
		StringBuffer conditon = new StringBuffer(0);
		List<Object[]> list = new ArrayList<Object[]>();
		if(map.get("cardNo") != null && !map.get("cardNo").equals("")){
			conditon.append("CardNo like'%"+map.get("cardNo")+"%' and ");
		}
		if(map.get("status") != null && !map.get("status").equals("")){
			conditon.append("Status="+map.get("status")+" and ");
		}
		if(map.get("userCardType") != null && !map.get("userCardType").equals("")){
			conditon.append("UserCardType="+map.get("userCardType")+" and ");
		}
		if(map.get("vehplate") != null && !map.get("vehplate").equals("")){
			conditon.append("Vehplate like'%"+map.get("vehplate")+"%' and ");
		}
		if(map.get("owner") != null && !map.get("owner").equals("")){
			conditon.append("Owner like'%"+map.get("owner")+"%' and ");
		}
		if(map.get("idcard") != null && !map.get("idcard").equals("")){
			conditon.append("Idcard like'%"+map.get("idcard")+"%' and ");
		}
		if(map.get("feeRuleType") != null && !map.get("feeRuleType").equals("")){
			conditon.append("FeeRuleType="+map.get("feeRuleType")+" and ");
		}
		if(map.get("mobileNumber") != null && !map.get("mobileNumber").equals("")){
			conditon.append("MobileNumber like'%"+map.get("mobileNumber")+"%' and ");
		}
		if(map.get("carType") != null && !map.get("carType").equals("")){
			conditon.append("carType="+map.get("carType")+" and ");
		}
		if(map.get("parkingSpace") != null && !map.get("parkingSpace").equals("")){
			conditon.append("ParkingSpace="+map.get("parkingSpace")+" and ");
		}
		if(map.get("ownerIdentity") != null && !map.get("ownerIdentity").equals("")){
			conditon.append("OwnerIdentity="+map.get("ownerIdentity")+" and ");
		}
		String conditonStr = conditon.toString();
		if(conditonStr.length()>0){
			String sql = "select " + fileds + " from tb_userCardInfo where " + conditonStr.substring(0, conditonStr.length()-4) +" order by RecNO desc";
			list = jdbcUtil.selectForList(sql);
		}else{
			String sql = "select " + fileds + " from tb_userCardInfo order by RecNO desc";
			list = jdbcUtil.selectForList(sql);
		}
		return list;
	}
	
	//导出IC卡 曾
	@SuppressWarnings("unchecked")
	public List<Object[]>exportICCard(String cardNo,Short cardType,Short status,Short userCardType){
		StringBuffer conditon = new StringBuffer(0);
		List<Object[]> list = new ArrayList<Object[]>();
		if(null != cardNo && !cardNo.equals("")){
			conditon.append("CardNo like '%"+cardNo+"%' and ");
		}
		if(null != cardType && !cardType.equals("")){
			conditon.append("CardType ="+cardType+" and ");
		}
		if(null != status && !status.equals("")){
			conditon.append("Status ="+status+" and ");
		}
		
		if(null != userCardType && !userCardType.equals("")){
			conditon.append("UserCardType="+userCardType+" and ");
		}
		String conditonStr = conditon.toString();
		if(conditonStr.length()>0){
			String sql = "select CardNo,CardType,UserCardType,Status,OpTime from tb_CardInfo where " + conditonStr.substring(0, conditonStr.length()-4);
			list = jdbcUtil.selectForList(sql);
		}else{
			String sql = "select CardNo,CardType,UserCardType,Status,OpTime from tb_CardInfo";
			list = jdbcUtil.selectForList(sql);
		}
		return list;
	}
	//打印 校园卡
	@SuppressWarnings("unchecked")
	public List<Object[]>printUserCardInfo(String cardNo) {
		StringBuffer conditon = new StringBuffer(0);
		List<Object[]> list = new ArrayList<Object[]>();
		if(null != cardNo && !cardNo.equals("")){
			conditon.append("CardNo like '%"+cardNo+"%'");
		}
		String conditonStr = conditon.toString();
		String sql = "select owner,vehPlate,userCardType,cardNo,payEndTime from tb_userCardInfo where " + conditonStr;
		list = jdbcUtil.selectForList(sql);
		return list;
	}
}
