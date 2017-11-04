package com.hgsoft.dao;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.transform.Transformers;
import org.springframework.stereotype.Repository;

import com.hgsoft.entity.AllInList;
import com.hgsoft.entity.CardDynamic;
import com.hgsoft.entity.WaterQuery;
import com.hgsoft.util.JdbcUtil;
import com.hgsoft.util.Pager;
@Repository
public class CardDynamicDao extends BaseDao<CardDynamic>{
	@Resource
	private JdbcUtil jdbcUtil;
	
	
	/**
	 * 查询卡片状态分布情况
	 */
	@SuppressWarnings("unchecked")
	public List queryCardScatter(){
		List list = null;
		String hql = "select count(*) as sumCount,tb.status from CardDynamic tb group by tb.status";
		List temp = this.executeQuery(hql);
		if(!temp.isEmpty()){
			list = new ArrayList();
			Iterator it = temp.iterator();
			while(it.hasNext()){
				Object[] ob = (Object[]) it.next();
				Object[] ay = new Object[]{ob[0].toString(),ob[1].toString()};
				list.add(ay);
			}
		}
		return list;
	}
	
	/**
	 * 查询用户卡类型分布情况
	 * 在状态中：11表示入口，12表示出口
	 */
	@SuppressWarnings("unchecked")
	public List queryUserCardTypeScatter(){
		List list = new ArrayList();;
		Map mapType = new HashMap<String, String>();
		String hqlCount = "select count(*) as sumCount,tb.userCardType,tb.status from CardDynamic tb where tb.status in(11,12) group by tb.userCardType,tb.status";
		String hqlType = "select t.userCardType,t.typeName from UserCardType t";
		List tempCount = this.executeQuery(hqlCount);
		List tempType = this.executeQuery(hqlType);
		if(!tempCount.isEmpty()){
			Iterator it = tempCount.iterator();
			while(it.hasNext()){
				Object[] ob = (Object[]) it.next();
				mapType.put(ob[1].toString()+ob[2].toString(), ob[0]);
			}
		}
		if(!tempType.isEmpty()){
			Iterator it = tempType.iterator();
			while(it.hasNext()){
				Object[] ob = (Object[]) it.next();
				Object oj11 = mapType.get(ob[0].toString()+"11");//表示入口
				Object oj12 = mapType.get(ob[0].toString()+"12");//表示出口
				Object[] tempOb = null;
				String str11 = null;
				String str12 = null;
				if(null != oj11){
					str11 = oj11.toString();
				}else{
					str11 = "0";
				}
				if(null != oj12){
					str12 = oj12.toString();
				}else{
					str12 = "0";
				}
				tempOb = new Object[]{str11,str12,ob[1]};
				list.add(tempOb);
			}
		}
		return list;
	}
	/**
	 * 查询通行劵类型分布情况
	 */
	@SuppressWarnings("unchecked")
	public List queryTicketTypeScatter(){
		List list = null;
		String hql = "select count(*) as sumCount,tb.ticketType from CardDynamic tb where tb.ticketType in(1,5,6) group by tb.ticketType";
		List temp = this.executeQuery(hql);
		if(!temp.isEmpty()){
			list = new ArrayList();
			Iterator it = temp.iterator();
			int count = 0;
			while(it.hasNext()){
				Object[] ob = (Object[]) it.next();
				String str = ob[1].toString();
				if(str.equals("1")){
					Object[] tempOb = new Object[]{ob[0],"内部卡"};
					list.add(tempOb);
				}else{
					count = count + Integer.valueOf(ob[0].toString());
				}
			}
			Object[] tempObj = new Object[]{count,"外来卡"};
			list.add(tempObj);
		}
		return list;
	}
	
	
	/**
	 * 计算相差月份
	 */
	public int monthApart(int startYear,int startMonth,int endYear,int endMonth){//结算相差月份，1月到1月相差月份为1
		int years=endYear-startYear;
		int months=1;
		if(years==0){
			 months = endMonth-startMonth+1; 
		} else if(years==1){
			 months = endMonth+(12-startMonth)+1; 
		}else{					
			 months = (years-1)*12+endMonth+(12-startMonth)+1;			
		}
		 return months; 
		
	}
	@SuppressWarnings("unchecked")
	public List getAllTicketType(){
		String hql = "from TicketTypeCode code";
		List list = this.executeQuery(hql);
		return list;
	}
	/**
	 * 
	 */
	@SuppressWarnings("unchecked")
	public List getAllVehType(){
		String hql = "from VehTypeCode code";
		List list = this.executeQuery(hql);
		return list;
	}
	/**
	 * 
	 */
	@SuppressWarnings("unchecked")
	public List getAllVehClass(){
		String hql = "from VehClassCode code";
		List list = this.executeQuery(hql);
		return list;
	}
	/**
	 * 
	 */
	@SuppressWarnings("unchecked")
	public List getAllSpEvent(){
		String hql = "from SpEventCode code where code.spEventNo< 30 ";
		List list = this.executeQuery(hql);
		return list;
	}
	
	/**
	 * 查询未回收零时卡
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List queryCardDynamic(Pager pager,String startTime,String endTime,String cardNo,String status,String vehPlate){
		String hql = "from CardDynamic card where card.status !=12 ";
		List resultList = new ArrayList();
		List list = new ArrayList();
		StringBuffer sb = new StringBuffer(0);
		SimpleDateFormat formate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if(null != startTime && !startTime.equals("")){
			sb.append("and card.opTime >= ? ");
			try {
				list.add(formate.parse(startTime+" 00:00:00"));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		if(null != endTime && !endTime.equals("")){
			sb.append("and card.opTime <= ? ");
			try {
				list.add(formate.parse(endTime+" 59:59:59"));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		if(null != cardNo && !cardNo.equals("")){
			sb.append("and card.cardNo = ? ");
			list.add(cardNo);
		}
		if(null != status && !status.equals("")){
			sb.append("and card.status = ? ");
			list.add(Short.parseShort(status));
		}
		if(null != vehPlate && !vehPlate.equals("")){
			sb.append("and card.vehPlate = ? ");
			list.add(vehPlate);
		}
		Long count = this.executeCount(hql + sb.toString(), list.toArray());
		pager.setTotalSize(count);
		resultList = this.executeQuery(pager,hql + sb.toString() + " order by card.opTime desc", list.toArray());
		return resultList;
	}
	
	/**
	 * 根据流水号来获得入口流水表（根据月份查询其中一个表）信息
	 */
	@SuppressWarnings("unchecked")
	public List getInListByListNo(String squadTime,String listNo){
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		Date date;
		String month="01";
		try {
			date = format.parse(squadTime);
			cal.setTime(date);
			 month = String.valueOf(cal.get(Calendar.MONTH)+1);
				if(month.length()<2){
					month = "0"+month;
				}
		} catch (ParseException e) {
			e.printStackTrace();
		}				
		String sql="select * from tb_InList"+month+" where listNo = '"+listNo+"'";
		List  listTemp = jdbcUtil.selectForList(sql);
		return listTemp;
	}
	/**
	 * 根据出口流水中入口发卡时间和流水号来获得入口流水表信息
	 * 根据入口发卡时间可得知其流水有可能在当前月份流水表、当前月份的前一个月流水表（入口发卡时间为月的第一天时）、当前月份的下个月流水表（入口发卡时间为月的最后一天时)
	 */
	@SuppressWarnings("unchecked")
	public List getInListByInOpTimeAndListNo(String inOpTime,String inlistNo){
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		Date date;
		String sql;
		List  listTemp;
		String month="01";
		int month1=0;//当前月份
		int month2=0;//当前月份的上个月
		int month3=0;//当前月份的下个月
		try {
			date = format.parse(inOpTime);
			cal.setTime(date);
			month1=cal.get(Calendar.MONTH)+1;
			cal.add(Calendar.DAY_OF_MONTH,1);//加一天
			month3 = cal.get(Calendar.MONTH)+1;
			cal.add(Calendar.DAY_OF_MONTH,-2);//减两天
			month2 = cal.get(Calendar.MONTH)+1;						
		} catch (ParseException e) {
			e.printStackTrace();
		}	
		month = String.valueOf(month1);
		if(month.length()<2){
			month = "0"+month;
		}
		sql="select * from tb_InList"+month+" where listNo = '"+inlistNo+"'";
		listTemp = jdbcUtil.selectForList(sql);
		if(!listTemp.isEmpty()){
			return listTemp;
		} 
		if( month1!=month2){
			month = String.valueOf(month2);
			if(month.length()<2){
				month = "0"+month;
			}
				sql="select * from tb_InList"+month+" where listNo = '"+inlistNo+"'";
				listTemp = jdbcUtil.selectForList(sql);
			if(!listTemp.isEmpty()){
				return listTemp;
			}
				
			
		}else if(month1!=month3){
			month = String.valueOf(month3);
			if(month.length()<2){
				month = "0"+month;
			}
				sql="select * from tb_InList"+month+" where listNo = '"+inlistNo+"'";
				listTemp = jdbcUtil.selectForList(sql);
			if(!listTemp.isEmpty()){
				return listTemp;
			}
		} 
		return listTemp;
		
	}
	
	
	/**
	 	 * 根据流水号来获得出口流水表（根据月份查询其中一个表）信息
	 */
	@SuppressWarnings("unchecked")
	public List getOutListByListNo(String squadTime,String listNo){
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		Date date;
		String month="01";
		try {
			date = format.parse(squadTime);
			cal.setTime(date);
			 month = String.valueOf(cal.get(Calendar.MONTH)+1);
				if(month.length()<2){
					month = "0"+month;
				}
		} catch (ParseException e) {
			e.printStackTrace();
		}				
		String sql="select * from tb_OutList"+month+" where listNo = '"+listNo+"'";
		List  listTemp = jdbcUtil.selectForList(sql);
		return listTemp;
	}
	
	
	/**
	 * 根据流水号来获得入口流水视图信息
	 */
	@SuppressWarnings("unchecked")
	public AllInList getByListNo(String listNo){
		String hql = "from AllInList allInList where allInList.listNo = ?";
		List list = this.executeQuery(hql, listNo);
		if(list.size() != 0){
			AllInList inList = (AllInList) list.get(0);
			return inList;
		}
		return null;
	}
	
	/**
	 * 根据卡表面号来获得未回收临时卡信息
	 */
	@SuppressWarnings("unchecked")
	public CardDynamic getByCardNo(String cardNo){
		String hql = "from CardDynamic card where card.cardNo = ?";
		List list = this.executeQuery(hql, cardNo);
		if(list.size() != 0){
			CardDynamic card = (CardDynamic) list.get(0);
			return card;
		}
		return null;
	}
	/**
	 * 拼接快速查询，最近一年的sql语句
	 * */
	private  List<String> getSql(int months, int start, Calendar cal, String cardNo, String vehPlate, String listNo,String squadDate, String statusOutIn){
		cal.add(Calendar.MONTH, -12);
		int[] month = new int[months];
		month[0] = start;
		for(int i=1; i<months; i++){
			if(month[i-1]+1<=12){
				month[i] = month[i-1]+1;
			}else{
				month[i] = (month[i-1]+1)%12;
			}
		}
		String[] m = new String[month.length];
		
		for(int i=0; i<month.length; i++){
			if(month[i]<10){
				m[i] = "0"+String.valueOf(month[i]);
			}else{
				m[i] = String.valueOf(month[i]);
			}
		}
		List<String> list = new ArrayList<String>();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		for(int i=0; i<month.length; i++){
			StringBuffer sql = new StringBuffer();
			if(statusOutIn.equals("1")){
				sql.append("select * from tb_InList");
			}else if(statusOutIn.equals("2")){
				sql.append("select * from tb_OutList");
			}
			sql.append(m[i]).append(" where");
			if (null != cardNo && !cardNo.equals("")) {
				
				sql.append(" cardNo ='" + cardNo + "' and ");
			}
			if (null != vehPlate && !vehPlate.equals("")) {
				
				sql.append(" vehPlate like'%" + vehPlate + "%' and ");
			}
			if (null != listNo && !listNo.equals("")) {
				
				sql.append(" listNo ='" + listNo + "' and ");
			}
			if (null != squadDate && !squadDate.equals("")) {
				sql.append(" squadDate >= '" + format.format(cal.getTime()) + "' and ");
			}
			if (sql.toString().substring(sql.length() - 4, sql.length()).equals("and ")) {
				sql = sql.replace(sql.length() - 4, sql.length(), "");
			} else if (sql.toString().substring(sql.length() - 5, sql.length()).equals("where")) {
				sql = sql.replace(sql.length() - 5, sql.length(), "");
			}
			list.add(sql.toString());
		}
		return list;
	}
	/**
	 * 拼接详细查询，操作时间大于3个月的sql语句
	 * */
	private List<String> getSql2(int months, int start, int end, String cardNo, String vehPlate, String listNo,
			String statusOutIn,String spEvent, String ticketType, String operatorNo, String operatorName, 
			String vehType, String vehClass, String parkNo, String gateNo, String laneNo, String squadNo, 
			String opTime, String queryStatus, String timeStatus, String startTime, String endTime,
			String fuzzySearch,String userCardType,String cardType,Date startDate,Date endDate,String cashMoneyMin,String cashMoneyMax,String etcMoneyMin,String etcMoneyMax){
		int[] month = new int[months];
		month[0] = start;
		month[months-1] = end;
		for(int i=1; i<months-1; i++){
			if(month[i-1]+1<=12){
				month[i] = month[i-1]+1;
			}else{
				month[i] = (month[i-1]+1)%12;
			}
		}
		String[] m = new String[month.length];
		
		for(int i=0; i<month.length; i++){
			if(month[i]<10){
				m[i] = "0"+String.valueOf(month[i]);
			}else{
				m[i] = String.valueOf(month[i]);
			}
		}
		List<String> list = new ArrayList<String>();
		SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		for(int i=0; i<month.length; i++){
			StringBuffer sql = new StringBuffer();
			if(statusOutIn.equals("1")){
				sql.append("select * from tb_InList");
			}else if(statusOutIn.equals("2")){
				sql.append("select * from tb_OutList");
			}
			sql.append(m[i]).append(" where");//具体查询哪张表（每个月份对应一张表）
			if (null != fuzzySearch && !fuzzySearch.equals("")) {// 模糊查询
				if (null != vehPlate && !vehPlate.equals("")) {
					sql.append(" vehPlate like'%" + vehPlate + "%' and ");
				}
				if (null != listNo && !listNo.equals("")) {
					sql.append(" listNo like'%" + listNo + "%' and ");
				}
				if (null != operatorName && !operatorName.equals("")) {
					sql.append(" operatorName like '%" + operatorName + "%' and ");
				}
				if (null != cardNo && !cardNo.equals("")) {
					sql.append(" cardNo like '%" + cardNo + "%' and ");
				}
			} else {
				if (null != vehPlate && !vehPlate.equals("")) {
					sql.append(" vehPlate ='" + vehPlate + "' and ");
				}
				if (null != listNo && !listNo.equals("")) {
					sql.append(" listNo ='" + listNo + "' and ");
				}
				if (null != operatorName && !operatorName.equals("")) {
					sql.append(" operatorName = '" + operatorName + "' and ");
				}
				if (null != cardNo && !cardNo.equals("")) {
					sql.append(" cardNo ='" + cardNo + "' and ");
				}
			}
			if (null != squadNo && !squadNo.equals("")) {
				sql.append(" squadNo =" + Short.parseShort(squadNo) + " and ");
			}
			if (null != vehType && !vehType.equals("")) {
				sql.append(" vehType = " + Short.parseShort(vehType) + " and ");
			}
			if (null != vehClass && !vehClass.equals("")) {
				sql.append(" vehClass = " + Short.parseShort(vehClass) + " and ");
			}
			if (null != spEvent && !spEvent.equals("")) {
				if("0".equals(spEvent)){
					sql.append(" spEvent = 0 and ");
				}else{
					int spLenght = spEvent.length();
					String indexMax = spEvent.substring(0, 1);
					int indexLenght = 31-spLenght+1;									
					sql.append(" Substring(dbo.Dec2Bin(spEvent,31),"+indexLenght+",1) = '" + indexMax + "' and ");
				}
			}
			if (null != ticketType && !ticketType.equals("")) {
				sql.append(" ticketType =" + Short.parseShort(ticketType) + " and ");
			}
			if (null != operatorNo && !operatorNo.equals("")) {
				sql.append(" operatorNo = " + Integer.parseInt(operatorNo) + " and ");
			}
	
			if (null != startTime && !startTime.equals("")&&null != endTime && !endTime.equals("")) {
				sql.append(" OpTime >= '" + format1.format(startDate) + "' and OpTime <= '"+format1.format(endDate) +"' and ");
			}
	
			if (null != parkNo && !parkNo.equals("")) {
				sql.append(" parkNo = " + Short.parseShort(parkNo) + " and ");
			}
			if (null != gateNo && !gateNo.equals("")) {
				sql.append(" gateNo = " + Short.parseShort(gateNo) + " and ");
			}
			if (null != laneNo && !laneNo.equals("")) {
				sql.append(" laneNo = " + Short.parseShort(laneNo) + " and ");
			}
			if (null != userCardType && !userCardType.equals("")){
				sql.append(" userCardType = " + Short.parseShort(userCardType) + " and ");
			}
			if (statusOutIn.equals("2")){
				if(null != cardType && !cardType.equals("")){
					sql.append(" payCardType = " + Short.parseShort(cardType) + " and ");
				}
				if (null != cashMoneyMin && !cashMoneyMin.equals("")) {
					sql.append(" cashMoney >= " + Double.parseDouble(cashMoneyMin) + " and ");
				}
				if (null != cashMoneyMax && !cashMoneyMax.equals("")) {
					sql.append(" cashMoney <= " + Double.parseDouble(cashMoneyMax) + " and ");
				}
				if (null != etcMoneyMin && !etcMoneyMin.equals("")) {
					sql.append(" ETCMoney >= " + Double.parseDouble(etcMoneyMin) + " and ");
				}
				if (null != etcMoneyMax && !etcMoneyMax.equals("")) {
					sql.append(" ETCMoney <= " + Double.parseDouble(etcMoneyMax) + " and ");
				}					
			}
			if (sql.toString().substring(sql.length() - 4, sql.length()).equals("and ")) {
				sql = sql.replace(sql.length() - 4, sql.length(), "");
			} else if (sql.toString().substring(sql.length() - 5, sql.length()).equals("where")) {
				sql = sql.replace(sql.length() - 5, sql.length(), "");
			}
			list.add(sql.toString());
		}
		return list;
	}
	
	/**
	 *获得出口数据
	 */
	@SuppressWarnings("unchecked")
	public List queryByOpTimeAndVehPlate(Date opTime,String days,String backNums,String vehPlate){
		String sql="";
		SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Pager pager = new Pager();
		Calendar cal = Calendar.getInstance();
		cal.setTime(opTime);
		int startMonth = cal.get(Calendar.MONTH)+1;
		int startYear = cal.get(Calendar.YEAR);
		cal.add(Calendar.DAY_OF_MONTH, Integer.valueOf(days));
		int endMonth = cal.get(Calendar.MONTH)+1;
		int endYear = cal.get(Calendar.YEAR);
		int months = this.monthApart(startYear, startMonth, endYear, endMonth);
		cal.setTime(opTime);	
		cal.add(Calendar.DAY_OF_MONTH, Integer.parseInt(days));
		Date endTime = cal.getTime();
		if(months>=6){//间隔大于等于半年时查询总视图
			StringBuffer sb = new StringBuffer("select * from v_AllOutList  where");			
			sb.append(" opTime>='"+format1.format(opTime)+"' and opTime<='"+format1.format(endTime)+"'");
			if(null != vehPlate && !vehPlate.equals("")){//车牌号不为空时				
				sb.append(" and vehPlate like '%"+vehPlate+"%'");
			}
			    sql = sb.toString();
		} else if(months==1){
			 String month1 = String.valueOf(startMonth);
			 if(month1.length()<2){
				 month1 = "0"+month1;
			 }
			StringBuffer sb1 = new StringBuffer("select * from tb_OutList" + month1 + " where");	
			sb1.append(" opTime>='"+format1.format(opTime)+"' and opTime<='"+format1.format(endTime)+"'");
			if(null != vehPlate && !vehPlate.equals("")){//车牌号不为空时				
				sb1.append(" and vehPlate like '%"+vehPlate+"%'");
			}
			sql = sb1.toString();
		} else if(months==2){
			String month1 = String.valueOf(startMonth);
			String month2 = String.valueOf(endMonth);
			 if(month1.length()<2){
				 month1 = "0"+month1;
			 }
			 if(month2.length()<2){
				 month2 = "0"+month2;
			 }
			StringBuffer sb1 = new StringBuffer("select * from tb_OutList" + month1 + " where");	
			sb1.append(" opTime>='"+format1.format(opTime)+"' and opTime<='"+format1.format(endTime)+"'");
			StringBuffer sb2 = new StringBuffer("select * from tb_OutList" + month2 + " where");	
			sb2.append(" opTime>='"+format1.format(opTime)+"' and opTime<='"+format1.format(endTime)+"'");
			if(null != vehPlate && !vehPlate.equals("")){//车牌号不为空时				
				sb1.append(" and vehPlate like '%"+vehPlate+"%'");
				sb2.append(" and vehPlate like '%"+vehPlate+"%'");
			}
			sb1.append(" union all " );
			sql = sb1.toString() + sb2.toString();
		} else if(months==3){
			String month1 = String.valueOf(startMonth);
			String month2 = String.valueOf(endMonth);
			String month3="";
			if((startMonth+1)<=12){
				month3 = String.valueOf(startMonth+1);
			} else {
				month3 = String.valueOf(endMonth-1);
			}
			if(month1.length()<2){
				 month1 = "0"+month1;
			 }
			 if(month2.length()<2){
				 month2 = "0"+month2;
			 }
			 if(month3.length()<2){
				 month3 = "0"+month3;
			 }
			StringBuffer sb1 = new StringBuffer("select * from tb_OutList" + month1 + " where");	
			sb1.append(" opTime>='"+format1.format(opTime)+"' and opTime<='"+format1.format(endTime)+"'");
			StringBuffer sb2 = new StringBuffer("select * from tb_OutList" + month2 + " where");	
			sb2.append(" opTime>='"+format1.format(opTime)+"' and opTime<='"+format1.format(endTime)+"'");
			StringBuffer sb3 = new StringBuffer("select * from tb_OutList" + month3 + " where");	
			sb3.append(" opTime>='"+format1.format(opTime)+"' and opTime<='"+format1.format(endTime)+"'");
			if(null != vehPlate && !vehPlate.equals("")){//车牌号不为空时				
					sb1.append(" and vehPlate like '%"+vehPlate+"%'");
					sb2.append(" and vehPlate like '%"+vehPlate+"%'");
					sb3.append(" and vehPlate like '%"+vehPlate+"%'");
			}
			sb1.append(" union all " );
			sb2.append(" union all " );
			sql = sb1.toString()+sb2.toString()+sb3.toString();

		} else if(months==4){
			String month1 = String.valueOf(startMonth);
			String month2 = String.valueOf(endMonth);
			String month3="",month4="";
			if((startMonth+1)<=12){
				month3 = String.valueOf(startMonth+1);
				if((startMonth+2)<=12){
					month4 = String.valueOf(startMonth+2);
				} else{
					month4 = String.valueOf(endMonth-1);
				}
			} else{
				month3 = String.valueOf(endMonth-1);
				month4 = String.valueOf(endMonth-2);
			}
			if(month1.length()<2){
				 month1 = "0"+month1;
			 }
			 if(month2.length()<2){
				 month2 = "0"+month2;
			 }
			 if(month3.length()<2){
				 month3 = "0"+month3;
			 }
			 if(month4.length()<2){
				 month4 = "0"+month4;
			 }
				StringBuffer sb1 = new StringBuffer("select * from tb_OutList" + month1 + " where");	
				sb1.append(" opTime>='"+format1.format(opTime)+"' and opTime<='"+format1.format(endTime)+"'");
				StringBuffer sb2 = new StringBuffer("select * from tb_OutList" + month2 + " where");	
				sb2.append(" opTime>='"+format1.format(opTime)+"' and opTime<='"+format1.format(endTime)+"'");
				StringBuffer sb3 = new StringBuffer("select * from tb_OutList" + month3 + " where");	
				sb3.append(" opTime>='"+format1.format(opTime)+"' and opTime<='"+format1.format(endTime)+"'");
				StringBuffer sb4 = new StringBuffer("select * from tb_OutList" + month4 + " where");	
				sb4.append(" opTime>='"+format1.format(opTime)+"' and opTime<='"+format1.format(endTime)+"'");
				if(null != vehPlate && !vehPlate.equals("")){//车牌号不为空时				
					sb1.append(" and vehPlate like '%"+vehPlate+"%'");
					sb2.append(" and vehPlate like '%"+vehPlate+"%'");
					sb3.append(" and vehPlate like '%"+vehPlate+"%'");
					sb4.append(" and vehPlate like '%"+vehPlate+"%'");
			}
			sb1.append(" union all " );
			sb2.append(" union all " );
			sb3.append(" union all " );
			sql = sb1.toString()+sb2.toString()+sb3.toString()+sb4.toString();
			
		} else if(months==5){
			String month1 = String.valueOf(startMonth);
			String month2 = String.valueOf(endMonth);
			String month3="",month4="",month5="";
			if((startMonth+1)<=12){
				month3 = String.valueOf(startMonth+1);
				if((startMonth+2)<=12){
					month4 = String.valueOf(startMonth+2);
					if((startMonth+3)<=12){
						month5 = String.valueOf(startMonth+3);
					}else{
						month5 = String.valueOf(endMonth-1);
					}
				}else{
					month4 = String.valueOf(endMonth-2);
					month5 = String.valueOf(endMonth-1);
				}
				
			} else{
				month3 = String.valueOf(endMonth-3);
				month4 = String.valueOf(endMonth-2);
				month5 = String.valueOf(endMonth-1);
			}
			
			if(month1.length()<2){
				 month1 = "0"+month1;
			 }
			 if(month2.length()<2){
				 month2 = "0"+month2;
			 }
			 if(month3.length()<2){
				 month3 = "0"+month3;
			 }
			 if(month4.length()<2){
				 month4 = "0"+month4;
			 }
			 if(month5.length()<2){
				 month5 = "0"+month5;
			 }
				StringBuffer sb1 = new StringBuffer("select * from tb_OutList" + month1 + " where");	
				sb1.append(" opTime>='"+format1.format(opTime)+"' and opTime<='"+format1.format(endTime)+"'");
				StringBuffer sb2 = new StringBuffer("select * from tb_OutList" + month2 + " where");	
				sb2.append(" opTime>='"+format1.format(opTime)+"' and opTime<='"+format1.format(endTime)+"'");
				StringBuffer sb3 = new StringBuffer("select * from tb_OutList" + month3 + " where");	
				sb3.append(" opTime>='"+format1.format(opTime)+"' and opTime<='"+format1.format(endTime)+"'");
				StringBuffer sb4 = new StringBuffer("select * from tb_OutList" + month4 + " where");	
				sb4.append(" opTime>='"+format1.format(opTime)+"' and opTime<='"+format1.format(endTime)+"'");
				StringBuffer sb5 = new StringBuffer("select * from tb_OutList" + month5 + " where");	
				sb5.append(" opTime>='"+format1.format(opTime)+"' and opTime<='"+format1.format(endTime)+"'");
				if(null != vehPlate && !vehPlate.equals("")){//车牌号不为空时				
					sb1.append(" and vehPlate like '%"+vehPlate+"%'");
					sb2.append(" and vehPlate like '%"+vehPlate+"%'");
					sb3.append(" and vehPlate like '%"+vehPlate+"%'");
					sb4.append(" and vehPlate like '%"+vehPlate+"%'");
					sb5.append(" and vehPlate like '%"+vehPlate+"%'");
			}
			sb1.append(" union all " );
			sb2.append(" union all " );
			sb3.append(" union all " );
			sb4.append(" union all " );
			sql = sb1.toString()+sb2.toString()+sb3.toString()+sb4.toString()+sb5.toString();		
		}
		pager.setCurrentPage("1");
		pager.setPageSize(backNums);
		// 要加上addScalar（）修改值类型，否则数据库中对应的字符串类型获取的是一个字符（hibernate的bug）。
		Query query = getSession().createSQLQuery(sql).addScalar("ListNo", Hibernate.STRING).addScalar("AreaNo", Hibernate.INTEGER).addScalar("ParkNo", Hibernate.INTEGER).addScalar("GateNo", Hibernate.INTEGER).addScalar("GateName", Hibernate.STRING)
		.addScalar("LaneNo", Hibernate.INTEGER).addScalar("VehType", Hibernate.INTEGER).addScalar("VehClass", Hibernate.INTEGER).addScalar("VehPlate", Hibernate.STRING).addScalar("SquadNo", Hibernate.INTEGER)
		.addScalar("SquadDate", Hibernate.DATE).addScalar("OperatorNo", Hibernate.INTEGER).addScalar("OperatorName", Hibernate.STRING).addScalar("OpTime", Hibernate.STRING).addScalar("SpEvent", Hibernate.INTEGER).addScalar("CardNo", Hibernate.STRING);

		if (pager != null) {
			query.setFirstResult(0);
			query.setMaxResults(pager.getPageSize());
		}
		return query.list();
	}
	
	/**
	 * 获得流水查询
	 */
	/*private String cardNo;
	private String vehPlate;
	private String listNo;
	private String statusOutIn;//出口或入口 1为入口，2为出口
	private String statusImage;//是否自动读取图片 1为否，2为是
	private String queryStatus;//查询状态 1为快速查询 2为详细查询
	private String squadDate;//工班日期
	//详细查询
	private String spEvent;//特殊事件 int
	private String ticketType;//通行卷类型  smallint
	private String operatorNo;//操作员号
	private String operatorName;//操作员姓名
	private String vehType;//车型 smallint
	private String vehClass;//车种 smallint
	private String parkNo; smallint
	private String gateNo; smallint
	private String laneNo; smallint
	private String squadNo;//工班号 smallint
	private String opTime;//操作时间
	private String fuzzySearch//是否模糊查询
	查询分类：总分为：快速查询、详细查询
	快速查询分为：出口（分为工班日期为当月，本周，当天查一个表，工班日期为最近三个月，查3个表）、入口（分为工班日期为当月，本周，当天查一个表，工班日期为最近三个月，查3个表）
	详细查询分为：出口（分为工班日期（查的是一个表），操作时间（根据月的时间差来确定查几个表（分为1、2、3个表），不能超过3个表）），入口（分为工班日期（查的是一个表），操作时间（根据月的时间差来确定查几个表，不能超过3个表））
*/	@SuppressWarnings("unchecked")
	public List waterQuery(Pager pager, String cardNo, String vehPlate, String listNo, String statusOutIn, 
			String squadDate, String spEvent, String ticketType, String operatorNo, String operatorName, 
			String vehType, String vehClass, String parkNo, String gateNo, String laneNo, String squadNo, 
			String opTime, String queryStatus, String timeStatus, String squadTime_start,String squadTime_end,String startTime, String endTime,
			String cashMoneyMin,String cashMoneyMax,String etcMoneyMin,String etcMoneyMax,
			String fuzzySearch,String userCardType,String cardType,String queryType) {
	    String month = null;
		String sql = null;
		StringBuffer sb = null;
		StringBuffer sb1 = null;
		StringBuffer sb2 = null;
		StringBuffer sb3 = null;
		int count = 0;
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Calendar cal = Calendar.getInstance();
		Date date = new Date();
		cal.setTime(date);
		Calendar cal1 = Calendar.getInstance();
		cal1.setTime(date);
		month = String.valueOf(cal.get(Calendar.MONTH) + 1);// 当前月份
		if (month.length() <= 1) {
			month = "0" + month;
		}
		String table = "";
		if(statusOutIn.equals("1")){
			table = "tb_InList";
		}else{
			table = "tb_OutList";
		}
//=========================================================快速查询==============================================================================		
		if (queryStatus.equals("1")) {// 快速查询
//=========================================================快速查询出口==============================================================================
				if (squadDate.equals("1") || squadDate.equals("2") || squadDate.equals("3")) {// 当月，本周，当天时查询的是当前月份的流水表
					sb = new StringBuffer("select * from " + table + month + " where");					
					if (null != cardNo && !cardNo.equals("")) {
						sb.append(" cardNo ='" + cardNo + "' and ");
					}
					if (null != vehPlate && !vehPlate.equals("")) {
						sb.append(" vehPlate like'%" + vehPlate + "%' and ");
					}
					if (null != listNo && !listNo.equals("")) {
						sb.append(" listNo ='" + listNo + "' and ");
					}
					if (null != squadDate && !squadDate.equals("")) {
						if (squadDate.equals("1")) {// 当天
							sb.append(" squadDate = '" + format.format(cal.getTime()) + "' and ");
						}
						if (squadDate.equals("2")) {// 本周
							cal.set(Calendar.DAY_OF_WEEK, 1);
							sb.append(" squadDate >= '" + format.format(cal.getTime()) + "' and ");
						}
						if (squadDate.equals("3")) {// 当月
							cal.set(Calendar.DAY_OF_MONTH, 1);
							sb.append(" squadDate >= '" + format.format(cal.getTime()) + "' and ");
						}
					}
					if (sb.toString().substring(sb.length() - 4, sb.length()).equals("and ")) {
						sb = sb.replace(sb.length() - 4, sb.length(), "");
					} else if (sb.toString().substring(sb.length() - 5, sb.length()).equals("where")) {
						sb = sb.replace(sb.length() - 5, sb.length(), "");					
					}
					
					sql = sb.toString().trim()+" order by optime desc";
					
					StringBuffer sb4 = sb.replace(0, 8, "select count(*)");
					String sqlCount = sb4.toString();
					
					count = jdbcUtil.select(sqlCount);// 统计数量
				} else if (squadDate.equals("4")) {// 工班日期为最近三个月，查3个表
					cal.add(Calendar.MONTH, -2);
					String firstMonth = String.valueOf(cal.get(Calendar.MONTH) + 1);// 当前月份的前2个月
					if (firstMonth.length() <= 1) {
						firstMonth = "0" + firstMonth;
					}
					cal1.add(Calendar.MONTH, -1);
					String secondMonth = String.valueOf(cal1.get(Calendar.MONTH) + 1);// 当前月份的前1个月

					if (secondMonth.length() <= 1) {
						secondMonth = "0" + secondMonth;
					}
					//sb = new StringBuffer("select * from tb_OutList" + month + " as one,tb_OutList" + secondMonth + " as two,tb_Outlist" + firstMonth + " as three where");
					sb1 = new StringBuffer("select * from " + table + month + " where");// 分开查询快
					sb2 = new StringBuffer("select * from " + table + secondMonth + " where");
					sb3 = new StringBuffer("select * from " + table + firstMonth + " where");
					if (null != cardNo && !cardNo.equals("")) {
						sb1.append(" cardNo ='" + cardNo + "' and ");
						sb2.append(" cardNo ='" + cardNo + "' and ");
						sb3.append(" cardNo ='" + cardNo + "' and ");
					}
					if (null != vehPlate && !vehPlate.equals("")) {
						sb1.append(" vehPlate like'%" + vehPlate + "%' and ");
						sb2.append(" vehPlate like'%" + vehPlate + "%' and ");
						sb3.append(" vehPlate like'%" + vehPlate + "%' and ");
					}
					if (null != listNo && !listNo.equals("")) {
						sb1.append(" listNo ='" + listNo + "' and ");
						sb2.append(" listNo ='" + listNo + "' and ");
						sb3.append(" listNo ='" + listNo + "' and ");
					}
					if (null != squadDate && !squadDate.equals("")) {
						if (squadDate.equals("4")) {// 最近三个月
							sb3.append(" squadDate >= '" + format.format(cal.getTime()) + "' and ");
							sb2.append(" squadDate >= '" + format.format(cal.getTime()) + "' and ");
							sb1.append(" squadDate >= '" + format.format(cal.getTime()) + "' and ");
						}
					}
					if (sb1.toString().substring(sb1.length() - 4, sb1.length()).equals("and ")) {
						sb1 = sb1.replace(sb1.length() - 4, sb1.length(), "");
					} else if (sb1.toString().substring(sb1.length() - 5, sb1.length()).equals("where")) {
						sb1 = sb1.replace(sb1.length() - 5, sb1.length(), "");
					}
					if (sb2.toString().substring(sb2.length() - 4, sb2.length()).equals("and ")) {
						sb2 = sb2.replace(sb2.length() - 4, sb2.length(), "");
					} else if (sb2.toString().substring(sb2.length() - 5, sb2.length()).equals("where")) {
						sb2 = sb2.replace(sb2.length() - 5, sb2.length(), "");
					}
					if (sb3.toString().substring(sb3.length() - 4, sb3.length()).equals("and ")) {
						sb3 = sb3.replace(sb3.length() - 4, sb3.length(), "");
					} else if (sb3.toString().substring(sb3.length() - 5, sb3.length()).equals("where")) {
						sb3 = sb3.replace(sb3.length() - 5, sb3.length(), "");
					}

					 sb1 = sb1.replace(0, 8, "select count(*)");
					 sb2 = sb2.replace(0, 8, "select count(*)");
					 sb3 = sb3.replace(0, 8, "select count(*)");
					 count = jdbcUtil.select(sb1.toString()) + jdbcUtil.select(sb2.toString()) + jdbcUtil.select(sb3.toString());// 统计总数量
					 sb1 = sb1.replace(0, 15, "select *");
					 sb2 = sb2.replace(0, 15, "select *");
					 sb3 = sb3.replace(0, 15, "select *");
					 
					sb1 = sb1.append(" union all ");
					sb2 = sb2.append(" union all ");
					sql = sb1.toString()+sb2.toString()+sb3.toString()+" order by optime desc";
					
				}else if (squadDate!=null && squadDate.equals("5")){
					List list = getSql(12, Integer.parseInt(month), cal1, cardNo, vehPlate, listNo, squadDate,statusOutIn);
					
					for(int i=0; i<list.size(); i++){
						StringBuffer sqlbf = new StringBuffer((String)list.get(i));
						sqlbf = sqlbf.replace(0, 8, "select count(*)");
						count += jdbcUtil.select(sqlbf.toString());
					}
					sql = "";
					for(int i=0; i<list.size(); i++){
						sql+=list.get(i)+" union all ";
					}
					sql = "select * from ("+sql.substring(0, sql.length()-10)+") t order by optime desc";
				}		
			
//=========================================================详细查询==============================================================================			
			
		} else if (queryStatus.equals("2")) {// 详细查询
				if (timeStatus.equals("2")) {// 根据工班日期查询
					Date squStartDate=null;
					Date squEndDate=null;
					if (null != squadTime_start && !squadTime_start.equals("")&&null != squadTime_end && !squadTime_end.equals("")) {
						try {	
							squStartDate= format.parse(squadTime_start);
							squEndDate= format.parse(squadTime_end);
							cal.setTime(squStartDate);
							cal1.setTime(squEndDate);
						} catch (ParseException e) {
							e.printStackTrace();
						}
						//cal1.add(Calendar.DATE,   1); //结束时间加上一天
						int startMonth=cal.get(Calendar.MONTH)+1;
						int endMonth=cal1.get(Calendar.MONTH)+1;
						int startYear=cal.get(Calendar.YEAR);
						int endYear=cal1.get(Calendar.YEAR);
						int months=this.monthApart(startYear,startMonth,endYear,endMonth);//求月份差，同个月差为1
						if(months>12){
							months = 12;
						}
						StringBuffer sbArray[] = new StringBuffer[months];
						month =String.valueOf(startMonth);
						sql = "";
						for(int i=0;i<months;i++){
							if (month.length() <= 1) {
								month = "0" + month;
							}
							sbArray[i] = new StringBuffer("select * from " + table + month + " where");
							if (null != fuzzySearch && !fuzzySearch.equals("")) {// 模糊查询
								if (null != cardNo && !cardNo.equals("")) {
									sbArray[i].append(" cardNo like '%" + cardNo + "%' and ");
								}
								if (null != vehPlate && !vehPlate.equals("")) {
									sbArray[i].append(" vehPlate like'%" + vehPlate + "%' and ");
								}
								if (null != listNo && !listNo.equals("")) {
									sbArray[i].append(" listNo like'%" + listNo + "%' and ");
								}
								if (null != operatorName && !operatorName.equals("")) {
									sbArray[i].append(" operatorName like '%" + operatorName + "%' and ");
								}	
							} else {//不模糊查询
								if (null != vehPlate && !vehPlate.equals("")) {
									sbArray[i].append(" vehPlate ='" + vehPlate + "' and ");
								}
								if (null != listNo && !listNo.equals("")) {
									sbArray[i].append(" listNo ='" + listNo + "' and ");
								}
								if (null != operatorName && !operatorName.equals("")) {
									sbArray[i].append(" operatorName = '" + operatorName + "' and ");
								}
								if (null != cardNo && !cardNo.equals("")) {
									sbArray[i].append(" cardNo ='" + cardNo + "' and ");
								}
							}

							if (null != squadNo && !squadNo.equals("")) {
								sbArray[i].append(" squadNo =" + Short.parseShort(squadNo) + " and ");
							}
							if (null != vehType && !vehType.equals("")) {
								sbArray[i].append(" vehType = " + Short.parseShort(vehType) + " and ");
							}
							if (null != vehClass && !vehClass.equals("")) {
								sbArray[i].append(" vehClass = " + Short.parseShort(vehClass) + " and ");
							}
							if (null != spEvent && !spEvent.equals("")) {
								if("0".equals(spEvent)){
									sbArray[i].append(" spEvent = 0 and ");
								}else{
									int spLenght = spEvent.length();
									String indexMax = spEvent.substring(0, 1);
									int indexLenght = 31-spLenght+1;
									//dbo.Dec2Bin(268435456,31)值等于0010000000000000000000000000000
									//Substring("0010000000000000000000000000000',3,1)的值等于1
									sbArray[i].append(" Substring(dbo.Dec2Bin(spEvent,31),"+indexLenght+",1) = '" + indexMax + "' and ");//数据库中的spEvent转化成二进制返回31位，在根据spEvent（传过来的是二进制）最高位的值与数据库转化成的二进制比对字符是否相等
								}
							}
							if (null != ticketType && !ticketType.equals("")) {
								sbArray[i].append(" ticketType =" + Short.parseShort(ticketType) + " and ");
							}
							if (null != operatorNo && !operatorNo.equals("")) {
								sbArray[i].append(" operatorNo = " + Integer.parseInt(operatorNo) + " and ");
							}
							if (null != squadTime_start && !squadTime_start.equals("")&&null != squadTime_end && !squadTime_end.equals("")) {
								sbArray[i].append(" squadDate >= '" + format.format(squStartDate) + "' and squadDate <= '" + format.format(squEndDate) + "' and ");
							}							
							if (null != parkNo && !parkNo.equals("")) {
								sbArray[i].append(" parkNo = " + Short.parseShort(parkNo) + " and ");
							}
							if (null != gateNo && !gateNo.equals("")) {
								sbArray[i].append(" gateNo = " + Short.parseShort(gateNo) + " and ");
							}
							if (null != laneNo && !laneNo.equals("")) {
								sbArray[i].append(" laneNo = " + Short.parseShort(laneNo) + " and ");
							}
							if (null != userCardType && !userCardType.equals("")){
								sbArray[i].append(" userCardType = " + Short.parseShort(userCardType) + " and ");
							}
							if (statusOutIn.equals("2")){
								if(null != cardType && !cardType.equals("")){
									sbArray[i].append(" payCardType = " + Short.parseShort(cardType) + " and ");
								}
								if (null != cashMoneyMin && !cashMoneyMin.equals("")) {
									sbArray[i].append(" cashMoney >= " + Double.parseDouble(cashMoneyMin) + " and ");
								}
								if (null != cashMoneyMax && !cashMoneyMax.equals("")) {
									sbArray[i].append(" cashMoney <= " + Double.parseDouble(cashMoneyMax) + " and ");
								}
								if (null != etcMoneyMin && !etcMoneyMin.equals("")) {
									sbArray[i].append(" ETCMoney >= " + Double.parseDouble(etcMoneyMin) + " and ");
								}
								if (null != etcMoneyMax && !etcMoneyMax.equals("")) {
									sbArray[i].append(" ETCMoney <= " + Double.parseDouble(etcMoneyMax) + " and ");
								}									
							}
							if (sbArray[i].toString().substring(sbArray[i].length() - 4, sbArray[i].length()).equals("and ")) {
								sbArray[i] = sbArray[i].replace(sbArray[i].length() - 4, sbArray[i].length(), "");
							} else if (sbArray[i].toString().substring(sbArray[i].length() - 5, sbArray[i].length()).equals("where")) {
								sbArray[i] = sbArray[i].replace(sbArray[i].length() - 5, sbArray[i].length(), "");
							}
							sbArray[i] = sbArray[i].replace(0, 8, "select count(*)");
							count += jdbcUtil.select(sbArray[i].toString());// 统计数量
							sbArray[i] = sbArray[i].replace(0, 15, "select *");
							sql += sbArray[i].toString();
							if(i!=months-1){
								sql += " union all ";
							}else{
								sql = sql+" order by optime desc";
								//sql += " order by squaddate desc";
							}
							if(!"12".equals(month)){
								month = String.valueOf(Integer.parseInt(month)  + 1);
							}else{
								month = "01";
							}
						}
					}
				} else if (timeStatus.equals("1")) {// 根据操作时间查询，操作时间的结束时间要加上一天（每个月的最后一天流水要插入下个月的流水表）。
					Date startDate=null;
					Date endDate=null;
					if (null != startTime && !startTime.equals("")&&null != endTime && !endTime.equals("")) {
						try {	
							startDate= format1.parse(startTime);
						    endDate= format1.parse(endTime);
							cal.setTime(startDate);
							cal1.setTime(endDate);
						} catch (ParseException e) {
							e.printStackTrace();
						}
						cal1.add(Calendar.DATE,   1); //结束时间加上一天
						int startMonth=cal.get(Calendar.MONTH)+1;
						int endMonth=cal1.get(Calendar.MONTH)+1;
						int startYear=cal.get(Calendar.YEAR);
						int endYear=cal1.get(Calendar.YEAR);
						int months=this.monthApart(startYear,startMonth,endYear,endMonth);//求月份差，同个月差为1
						if(months==1){//开始月份等于结束月份时查的是一个表
							month =String.valueOf(startMonth);
							if (month.length() <= 1) {
								month = "0" + month;
							}
							sb = new StringBuffer("select * from " + table + month + " where");	
							
							if (null != fuzzySearch && !fuzzySearch.equals("")) {// 模糊查询
								if (null != vehPlate && !vehPlate.equals("")) {
									sb.append(" vehPlate like'%" + vehPlate + "%' and ");
								}
								if (null != listNo && !listNo.equals("")) {
									sb.append(" listNo like'%" + listNo + "%' and ");
								}
								if (null != operatorName && !operatorName.equals("")) {
									sb.append(" operatorName like '%" + operatorName + "%' and ");
								}	
								if (null != cardNo && !cardNo.equals("")) {
									sb.append(" cardNo like '%" + cardNo + "%' and ");
								}
							} else {
								if (null != vehPlate && !vehPlate.equals("")) {
									sb.append(" vehPlate ='" + vehPlate + "' and ");
								}
								if (null != listNo && !listNo.equals("")) {
									sb.append(" listNo ='" + listNo + "' and ");
								}
								if (null != operatorName && !operatorName.equals("")) {
									sb.append(" operatorName = '" + operatorName + "' and ");
								}
								if (null != cardNo && !cardNo.equals("")) {
									sb.append(" cardNo ='" + cardNo + "' and ");
								}
							}
							
							if (null != squadNo && !squadNo.equals("")) {
								sb.append(" squadNo =" + Short.parseShort(squadNo) + " and ");
							}
							if (null != vehType && !vehType.equals("")) {
								sb.append(" vehType = " + Short.parseShort(vehType) + " and ");
							}
							if (null != vehClass && !vehClass.equals("")) {
								sb.append(" vehClass = " + Short.parseShort(vehClass) + " and ");
							}
							if (null != spEvent && !spEvent.equals("")) {
								if("0".equals(spEvent)){
									sb.append(" spEvent = 0 and ");
								}else{
									int spLenght = spEvent.length();
									String indexMax = spEvent.substring(0, 1);
									int indexLenght = 31-spLenght+1;									
									sb.append(" Substring(dbo.Dec2Bin(spEvent,31),"+indexLenght+",1) = '" + indexMax + "' and ");
								}
							}
							if (null != ticketType && !ticketType.equals("")) {
								sb.append(" ticketType =" + Short.parseShort(ticketType) + " and ");
							}
							if (null != operatorNo && !operatorNo.equals("")) {
								sb.append(" operatorNo = " + Integer.parseInt(operatorNo) + " and ");
							}

							if (null != startTime && !startTime.equals("")&&null != endTime && !endTime.equals("")) {
								sb.append(" OpTime >= '" + format1.format(startDate) + "' and OpTime <= '"+format1.format(endDate) +"' and ");
							}
							if (null != parkNo && !parkNo.equals("")) {
								sb.append(" parkNo = " + Short.parseShort(parkNo) + " and ");
							}
							if (null != gateNo && !gateNo.equals("")) {
								sb.append(" gateNo = " + Short.parseShort(gateNo) + " and ");
							}
							if (null != laneNo && !laneNo.equals("")) {
								sb.append(" laneNo = " + Short.parseShort(laneNo) + " and ");
							}
							if (null != userCardType && !userCardType.equals("")){
								sb.append(" userCardType = " + Short.parseShort(userCardType) + " and ");
							}
							if (statusOutIn.equals("2")){
								if(null != cardType && !cardType.equals("")){
									sb.append(" payCardType = " + Short.parseShort(cardType) + " and ");
								}
								if (null != cashMoneyMin && !cashMoneyMin.equals("")) {
									sb.append(" cashMoney >= " + Double.parseDouble(cashMoneyMin) + " and ");
								}
								if (null != cashMoneyMax && !cashMoneyMax.equals("")) {
									sb.append(" cashMoney <= " + Double.parseDouble(cashMoneyMax) + " and ");
								}
								if (null != etcMoneyMin && !etcMoneyMin.equals("")) {
									sb.append(" ETCMoney >= " + Double.parseDouble(etcMoneyMin) + " and ");
								}
								if (null != etcMoneyMax && !etcMoneyMax.equals("")) {
									sb.append(" ETCMoney <= " + Double.parseDouble(etcMoneyMax) + " and ");
								}									
							}
							if (sb.toString().substring(sb.length() - 4, sb.length()).equals("and ")) {
								sb = sb.replace(sb.length() - 4, sb.length(), "");
							} else if (sb.toString().substring(sb.length() - 5, sb.length()).equals("where")) {
								sb = sb.replace(sb.length() - 5, sb.length(), "");
							}
							sql = sb.toString().trim()+" order by optime desc";
							StringBuffer sb4 = sb.replace(0, 8, "select count(*)");
							String sqlCount = sb4.toString();
							count = jdbcUtil.select(sqlCount);// 统计数量						
						} else if(months==2){//结束月份与结束月份差为2个月时查的是俩个表
							 String month1 =String.valueOf(startMonth);
							 String month2 =String.valueOf(endMonth);
							if (month1.length() <= 1) {
								month1 = "0" + month1;
							}
							if (month2.length() <= 1) {
								month2 = "0" + month2;
							}
							sb1 = new StringBuffer("select * from " + table + month1 + " where");// 分开查询快
							sb2 = new StringBuffer("select * from " + table + month2 + " where");
							
							if (null != fuzzySearch && !fuzzySearch.equals("")) {// 模糊查询
								if (null != vehPlate && !vehPlate.equals("")) {
									sb1.append(" vehPlate like'%" + vehPlate + "%' and ");
									sb2.append(" vehPlate like'%" + vehPlate + "%' and ");
								}
								if (null != listNo && !listNo.equals("")) {
									sb1.append(" listNo like'%" + listNo + "%' and ");
									sb2.append(" listNo like'%" + listNo + "%' and ");
								}
								if (null != operatorName && !operatorName.equals("")) {
									sb1.append(" operatorName like '%" + operatorName + "%' and ");
									sb2.append(" operatorName like '%" + operatorName + "%' and ");
									// list.add(operatorName);
								}
								if (null != cardNo && !cardNo.equals("")) {
									sb1.append(" cardNo like '%" + cardNo + "%' and ");
									sb2.append(" cardNo like '%" + cardNo + "%' and ");
								}
							} else {
								if (null != vehPlate && !vehPlate.equals("")) {
									sb1.append(" vehPlate ='" + vehPlate + "' and ");
									sb2.append(" vehPlate ='" + vehPlate + "' and ");
								}
								if (null != listNo && !listNo.equals("")) {
									sb1.append(" listNo ='" + listNo + "' and ");
									sb2.append(" listNo ='" + listNo + "' and ");
								}
								if (null != operatorName && !operatorName.equals("")) {
									sb1.append(" operatorName = '" + operatorName + "' and ");
									sb2.append(" operatorName = '" + operatorName + "' and ");
									// list.add(operatorName);
								}
								if (null != cardNo && !cardNo.equals("")) {
									sb1.append(" cardNo ='" + cardNo + "' and ");
									sb2.append(" cardNo ='" + cardNo + "' and ");
								}
							}
							if (null != squadNo && !squadNo.equals("")) {
								sb1.append(" squadNo =" + Short.parseShort(squadNo) + " and ");
								sb2.append(" squadNo =" + Short.parseShort(squadNo) + " and ");
							}
							if (null != vehType && !vehType.equals("")) {
								sb1.append(" vehType = " + Short.parseShort(vehType) + " and ");
								sb2.append(" vehType = " + Short.parseShort(vehType) + " and ");
								// list.add(Short.parseShort(vehType));
							}
							if (null != vehClass && !vehClass.equals("")) {
								sb1.append(" vehClass = " + Short.parseShort(vehClass) + " and ");
								sb2.append(" vehClass = " + Short.parseShort(vehClass) + " and ");
								// list.add(Short.parseShort(vehClass));
							}
							if (null != spEvent && !spEvent.equals("")) {
								if("0".equals(spEvent)){
									sb1.append(" spEvent = 0 and ");
									sb2.append(" spEvent = 0 and ");
								}else{
									int spLenght = spEvent.length();
									String indexMax = spEvent.substring(0, 1);
									int indexLenght = 31-spLenght+1;									
									sb1.append(" Substring(dbo.Dec2Bin(spEvent,31),"+indexLenght+",1) = '" + indexMax + "' and ");
									sb2.append(" Substring(dbo.Dec2Bin(spEvent,31),"+indexLenght+",1) = '" + indexMax + "' and ");
								}
							}
							if (null != ticketType && !ticketType.equals("")) {
								sb1.append(" ticketType =" + Short.parseShort(ticketType) + " and ");
								sb2.append(" ticketType =" + Short.parseShort(ticketType) + " and ");
								// list.add(Short.parseShort(ticketType));
							}
							if (null != operatorNo && !operatorNo.equals("")) {
								sb1.append(" operatorNo = " + Integer.parseInt(operatorNo) + " and ");
								sb2.append(" operatorNo = " + Integer.parseInt(operatorNo) + " and ");
								// list.add(Integer.parseInt(operatorNo));
							}

							if (null != startTime && !startTime.equals("")&&null != endTime && !endTime.equals("")) {
								sb1.append(" OpTime >= '" + format1.format(startDate) + "' and OpTime <= '"+format1.format(endDate) +"' and ");
								sb2.append(" OpTime >= '" + format1.format(startDate) + "' and OpTime <= '"+format1.format(endDate) +"' and ");
								// list.add(operatorName);
							}
							if (null != parkNo && !parkNo.equals("")) {
								sb1.append(" parkNo = " + Short.parseShort(parkNo) + " and ");
								sb2.append(" parkNo = " + Short.parseShort(parkNo) + " and ");
								// list.add(Short.parseShort(parkNo));
							}
							if (null != gateNo && !gateNo.equals("")) {
								sb1.append(" gateNo = " + Short.parseShort(gateNo) + " and ");
								sb2.append(" gateNo = " + Short.parseShort(gateNo) + " and ");
								// list.add(Short.parseShort(gateNo));
							}
							if (null != laneNo && !laneNo.equals("")) {
								sb1.append(" laneNo = " + Short.parseShort(laneNo) + " and ");
								sb2.append(" laneNo = " + Short.parseShort(laneNo) + " and ");
								// list.add(Short.parseShort(laneNo));
							}
							if (null != userCardType && !userCardType.equals("")){
								sb1.append(" userCardType = " + Short.parseShort(userCardType) + " and ");
								sb2.append(" userCardType = " + Short.parseShort(userCardType) + " and ");
							}
							if (statusOutIn.equals("2")){
								if (null != cardType && !cardType.equals("")){
									sb1.append(" payCardType = " + Short.parseShort(cardType) + " and ");
									sb2.append(" payCardType = " + Short.parseShort(cardType) + " and ");
								}	
								if (null != cashMoneyMin && !cashMoneyMin.equals("")) {
									sb1.append(" cashMoney >= " + Double.parseDouble(cashMoneyMin) + " and ");
									sb2.append(" cashMoney >= " + Double.parseDouble(cashMoneyMin) + " and ");
									// list.add(Integer.parseInt(operatorNo));
								}
								if (null != cashMoneyMax && !cashMoneyMax.equals("")) {
									sb1.append(" cashMoney <= " + Double.parseDouble(cashMoneyMax) + " and ");
									sb2.append(" cashMoney <= " + Double.parseDouble(cashMoneyMax) + " and ");
									// list.add(Integer.parseInt(operatorNo));
								}
								if (null != etcMoneyMin && !etcMoneyMin.equals("")) {
									sb1.append(" ETCMoney >= " + Double.parseDouble(etcMoneyMin) + " and ");
									sb2.append(" ETCMoney >= " + Double.parseDouble(etcMoneyMin) + " and ");
									// list.add(Integer.parseInt(operatorNo));
								}
								if (null != etcMoneyMax && !etcMoneyMax.equals("")) {
									sb1.append(" ETCMoney <= " + Double.parseDouble(etcMoneyMax) + " and ");
									sb2.append(" ETCMoney <= " + Double.parseDouble(etcMoneyMax) + " and ");
									// list.add(Integer.parseInt(operatorNo));
								}								
							}

							if (sb1.toString().substring(sb1.length() - 4, sb1.length()).equals("and ")) {
								sb1 = sb1.replace(sb1.length() - 4, sb1.length(), "");
							} else if (sb1.toString().substring(sb1.length() - 5, sb1.length()).equals("where")) {
								sb1 = sb1.replace(sb1.length() - 5, sb1.length(), "");
							}
							if (sb2.toString().substring(sb2.length() - 4, sb2.length()).equals("and ")) {
								sb2 = sb2.replace(sb2.length() - 4, sb2.length(), "");
							} else if (sb2.toString().substring(sb2.length() - 5, sb2.length()).equals("where")) {
								sb2 = sb2.replace(sb2.length() - 5, sb2.length(), "");
							}

							 sb1 = sb1.replace(0, 8, "select count(*)");
							 sb2 = sb2.replace(0, 8, "select count(*)");
							 count = jdbcUtil.select(sb1.toString()) + jdbcUtil.select(sb2.toString());// 统计总数量
							 sb1 = sb1.replace(0, 15, "select *");
							 sb2 = sb2.replace(0, 15, "select *");
							 
							sb1 = sb1.append(" union all ");
							sql = sb1.toString()+sb2.toString()+" order by optime desc";
						} else if(months==3){//结束月份相比开始月份差等于3
							int threeMonth=0;//判断第三个月份（从界面传回来的月份差不能超过3）
							if((startMonth+1)>12){
								threeMonth=endMonth-1;							
							} else{
								threeMonth=startMonth+1;
							}
							 String month1 =String.valueOf(startMonth);
							 String month2 =String.valueOf(endMonth);
							 String month3 =String.valueOf(threeMonth);
							if (month1.length() <= 1) {
								month1 = "0" + month1;
							}
							if (month2.length() <= 1) {
								month2 = "0" + month2;
							}
							if (month3.length() <= 1) {
								month3 = "0" + month3;
							}
							sb1 = new StringBuffer("select * from " + table + month1 + " where");// 分开查询快
							sb2 = new StringBuffer("select * from " + table + month2 + " where");
							sb3 = new StringBuffer("select * from " + table + month3 + " where");							
							if (null != fuzzySearch && !fuzzySearch.equals("")) {// 模糊查询
								if (null != vehPlate && !vehPlate.equals("")) {
									sb1.append(" vehPlate like'%" + vehPlate + "%' and ");
									sb2.append(" vehPlate like'%" + vehPlate + "%' and ");
									sb3.append(" vehPlate like'%" + vehPlate + "%' and ");
								}
								if (null != listNo && !listNo.equals("")) {
									sb1.append(" listNo like'%" + listNo + "%' and ");
									sb2.append(" listNo like'%" + listNo + "%' and ");
									sb3.append(" listNo like'%" + listNo + "%' and ");
								}
								if (null != operatorName && !operatorName.equals("")) {
									sb1.append(" operatorName like '%" + operatorName + "%' and ");
									sb2.append(" operatorName like '%" + operatorName + "%' and ");
									sb3.append(" operatorName like '%" + operatorName + "%' and ");
									// list.add(operatorName);
								}
								if (null != cardNo && !cardNo.equals("")) {
									sb1.append(" cardNo like '%" + cardNo + "%' and ");
									sb2.append(" cardNo like '%" + cardNo + "%' and ");
									sb3.append(" cardNo like '%" + cardNo + "%' and ");
								}
							} else {
								if (null != vehPlate && !vehPlate.equals("")) {
									sb1.append(" vehPlate ='" + vehPlate + "' and ");
									sb2.append(" vehPlate ='" + vehPlate + "' and ");
									sb3.append(" vehPlate ='" + vehPlate + "' and ");
								}
								if (null != listNo && !listNo.equals("")) {
									sb1.append(" listNo ='" + listNo + "' and ");
									sb2.append(" listNo ='" + listNo + "' and ");
									sb3.append(" listNo ='" + listNo + "' and ");
								}
								if (null != operatorName && !operatorName.equals("")) {
									sb1.append(" operatorName = '" + operatorName + "' and ");
									sb2.append(" operatorName = '" + operatorName + "' and ");
									sb3.append(" operatorName = '" + operatorName + "' and ");
									// list.add(operatorName);
								}
								if (null != cardNo && !cardNo.equals("")) {
									sb1.append(" cardNo ='" + cardNo + "' and ");
									sb2.append(" cardNo ='" + cardNo + "' and ");
									sb3.append(" cardNo ='" + cardNo + "' and ");
								}
							}
							
							if (null != squadNo && !squadNo.equals("")) {
								sb1.append(" squadNo =" + Short.parseShort(squadNo) + " and ");
								sb2.append(" squadNo =" + Short.parseShort(squadNo) + " and ");
								sb3.append(" squadNo =" + Short.parseShort(squadNo) + " and ");
							}
							if (null != vehType && !vehType.equals("")) {
								sb1.append(" vehType = " + Short.parseShort(vehType) + " and ");
								sb2.append(" vehType = " + Short.parseShort(vehType) + " and ");
								sb3.append(" vehType = " + Short.parseShort(vehType) + " and ");
								// list.add(Short.parseShort(vehType));
							}
							if (null != vehClass && !vehClass.equals("")) {
								sb1.append(" vehClass = " + Short.parseShort(vehClass) + " and ");
								sb2.append(" vehClass = " + Short.parseShort(vehClass) + " and ");
								sb3.append(" vehClass = " + Short.parseShort(vehClass) + " and ");
								// list.add(Short.parseShort(vehClass));
							}
							if (null != spEvent && !spEvent.equals("")) {
								if("0".equals(spEvent)){
									sb1.append(" spEvent = 0 and ");
									sb2.append(" spEvent = 0 and ");
									sb3.append(" spEvent = 0 and ");
								}else{
									int spLenght = spEvent.length();
									String indexMax = spEvent.substring(0, 1);
									int indexLenght = 31-spLenght+1;									
									sb1.append(" Substring(dbo.Dec2Bin(spEvent,31),"+indexLenght+",1) = '" + indexMax + "' and ");
									sb2.append(" Substring(dbo.Dec2Bin(spEvent,31),"+indexLenght+",1) = '" + indexMax + "' and ");
									sb3.append(" Substring(dbo.Dec2Bin(spEvent,31),"+indexLenght+",1) = '" + indexMax + "' and ");
								}
							}
							if (null != ticketType && !ticketType.equals("")) {
								sb1.append(" ticketType =" + Short.parseShort(ticketType) + " and ");
								sb2.append(" ticketType =" + Short.parseShort(ticketType) + " and ");
								sb3.append(" ticketType =" + Short.parseShort(ticketType) + " and ");
								// list.add(Short.parseShort(ticketType));
							}
							if (null != operatorNo && !operatorNo.equals("")) {
								sb1.append(" operatorNo = " + Integer.parseInt(operatorNo) + " and ");
								sb2.append(" operatorNo = " + Integer.parseInt(operatorNo) + " and ");
								sb3.append(" operatorNo = " + Integer.parseInt(operatorNo) + " and ");
								// list.add(Integer.parseInt(operatorNo));
							}

							if (null != startTime && !startTime.equals("")&&null != endTime && !endTime.equals("")) {
								sb1.append(" OpTime >= '" + format1.format(startDate) + "' and OpTime <= '"+format1.format(endDate) +"' and ");
								sb2.append(" OpTime >= '" + format1.format(startDate) + "' and OpTime <= '"+format1.format(endDate) +"' and ");
								sb3.append(" OpTime >= '" + format1.format(startDate) + "' and OpTime <= '"+format1.format(endDate) +"' and ");
								// list.add(operatorName);
							}
							if (null != parkNo && !parkNo.equals("")) {
								sb1.append(" parkNo = " + Short.parseShort(parkNo) + " and ");
								sb2.append(" parkNo = " + Short.parseShort(parkNo) + " and ");
								sb3.append(" parkNo = " + Short.parseShort(parkNo) + " and ");
							}
							if (null != gateNo && !gateNo.equals("")) {
								sb1.append(" gateNo = " + Short.parseShort(gateNo) + " and ");
								sb2.append(" gateNo = " + Short.parseShort(gateNo) + " and ");
								sb3.append(" gateNo = " + Short.parseShort(gateNo) + " and ");
							}
							if (null != laneNo && !laneNo.equals("")) {
								sb1.append(" laneNo = " + Short.parseShort(laneNo) + " and ");
								sb2.append(" laneNo = " + Short.parseShort(laneNo) + " and ");
								sb3.append(" laneNo = " + Short.parseShort(laneNo) + " and ");
							}
							if (null != userCardType && !userCardType.equals("")){
								sb1.append(" userCardType = " + Short.parseShort(userCardType) + " and ");
								sb2.append(" userCardType = " + Short.parseShort(userCardType) + " and ");
								sb3.append(" userCardType = " + Short.parseShort(userCardType) + " and ");
							}
							if (statusOutIn.equals("2")){
								if (null != cardType && !cardType.equals("")){
									sb1.append(" payCardType = " + Short.parseShort(cardType) + " and ");
									sb2.append(" payCardType = " + Short.parseShort(cardType) + " and ");
									sb3.append(" payCardType = " + Short.parseShort(cardType) + " and ");
								}
								if (null != cashMoneyMin && !cashMoneyMin.equals("")) {
									sb1.append(" cashMoney >= " + Double.parseDouble(cashMoneyMin) + " and ");
									sb2.append(" cashMoney >= " + Double.parseDouble(cashMoneyMin) + " and ");
									sb3.append(" cashMoney >= " + Double.parseDouble(cashMoneyMin) + " and ");
									// list.add(Integer.parseInt(operatorNo));
								}
								if (null != cashMoneyMax && !cashMoneyMax.equals("")) {
									sb1.append(" cashMoney <= " + Double.parseDouble(cashMoneyMax) + " and ");
									sb2.append(" cashMoney <= " + Double.parseDouble(cashMoneyMax) + " and ");
									sb3.append(" cashMoney <= " + Double.parseDouble(cashMoneyMax) + " and ");
									// list.add(Integer.parseInt(operatorNo));
								}
								if (null != etcMoneyMin && !etcMoneyMin.equals("")) {
									sb1.append(" ETCMoney >= " + Double.parseDouble(etcMoneyMin) + " and ");
									sb2.append(" ETCMoney >= " + Double.parseDouble(etcMoneyMin) + " and ");
									sb3.append(" ETCMoney >= " + Double.parseDouble(etcMoneyMin) + " and ");
									// list.add(Integer.parseInt(operatorNo));
								}
								if (null != etcMoneyMax && !etcMoneyMax.equals("")) {
									sb1.append(" ETCMoney <= " + Double.parseDouble(etcMoneyMax) + " and ");
									sb2.append(" ETCMoney <= " + Double.parseDouble(etcMoneyMax) + " and ");
									sb3.append(" ETCMoney <= " + Double.parseDouble(etcMoneyMax) + " and ");
									// list.add(Integer.parseInt(operatorNo));
								}								
							}
							if (sb1.toString().substring(sb1.length() - 4, sb1.length()).equals("and ")) {
								sb1 = sb1.replace(sb1.length() - 4, sb1.length(), "");
							} else if (sb1.toString().substring(sb1.length() - 5, sb1.length()).equals("where")) {
								sb1 = sb1.replace(sb1.length() - 5, sb1.length(), "");
							}
							if (sb2.toString().substring(sb2.length() - 4, sb2.length()).equals("and ")) {
								sb2 = sb2.replace(sb2.length() - 4, sb2.length(), "");
							} else if (sb2.toString().substring(sb2.length() - 5, sb2.length()).equals("where")) {
								sb2 = sb2.replace(sb2.length() - 5, sb2.length(), "");
							}
							if (sb3.toString().substring(sb3.length() - 4, sb3.length()).equals("and ")) {
								sb3 = sb3.replace(sb3.length() - 4, sb3.length(), "");
							} else if (sb3.toString().substring(sb3.length() - 5, sb3.length()).equals("where")) {
								sb3 = sb3.replace(sb3.length() - 5, sb3.length(), "");
							}

							 sb1 = sb1.replace(0, 8, "select count(*)");
							 sb2 = sb2.replace(0, 8, "select count(*)");
							 sb3 = sb3.replace(0, 8, "select count(*)");
							 count = jdbcUtil.select(sb1.toString()) + jdbcUtil.select(sb2.toString())+ jdbcUtil.select(sb3.toString());// 统计总数量
							 sb1 = sb1.replace(0, 15, "select *");
							 sb2 = sb2.replace(0, 15, "select *");
							 sb3 = sb3.replace(0, 15, "select *");
							 
							sb1 = sb1.append(" union all ");
							sb2 = sb2.append(" union all ");
							sql = sb1.toString()+sb2.toString()+sb3.toString()+" order by optime desc";
							
						}else if(3<months && months<=12){
							List list = getSql2(months, startMonth, endMonth, cardNo, vehPlate, listNo, 
								    statusOutIn, spEvent, ticketType, operatorNo, 
									operatorName, vehType, vehClass, parkNo, gateNo, laneNo, 
									squadNo, opTime, queryStatus, timeStatus, startTime,
									endTime, fuzzySearch, userCardType, cardType, startDate, endDate, cashMoneyMin,cashMoneyMax,etcMoneyMin,etcMoneyMax);
							for(int i=0; i<list.size(); i++){
								StringBuffer sqlbf = new StringBuffer((String)list.get(i));
								sqlbf = sqlbf.replace(0, 8, "select count(*)");
								count += jdbcUtil.select(sqlbf.toString());
							}
							sql = "";
							for(int i=0; i<list.size(); i++){
								sql+=list.get(i)+" union all ";
							}
							sql = sql.substring(0, sql.length()-10)+" order by optime desc";
							//System.out.println(sql);
						}
						
					}
				}
		}
		pager.setTotalSize(count);
		
		// 要加上addScalar（）修改值类型，否则数据库中对应的字符串类型获取的是一个字符（hibernate的bug）。
		if(statusOutIn.equals("1")){
			Query query = null;
			if("1".equals(queryType)){
				query = getSession().createSQLQuery(sql).addScalar("ListNo", Hibernate.STRING).addScalar("AreaNo", Hibernate.INTEGER).addScalar("ParkNo", Hibernate.INTEGER).addScalar("GateName", Hibernate.STRING)
						.addScalar("LaneNo", Hibernate.INTEGER).addScalar("VehType", Hibernate.INTEGER).addScalar("VehClass", Hibernate.INTEGER).addScalar("VehPlate", Hibernate.STRING).addScalar("SquadNo", Hibernate.INTEGER)
						.addScalar("SquadDate", Hibernate.DATE).addScalar("OperatorNo", Hibernate.INTEGER).addScalar("OperatorName", Hibernate.STRING).addScalar("OpTime", Hibernate.STRING).addScalar("SpEvent", Hibernate.INTEGER)
						.addScalar("CardNo", Hibernate.STRING).addScalar("UserCardType", Hibernate.INTEGER);
			}
			if("2".equals(queryType)){//导出流水
				String fileds = " ListNo ,ParkNo,GateName ,LaneNo ,VehType  ,VehClass ,VehPlate ,SquadNo,SquadDate ,OperatorNo,OperatorName,OpTime ,SpEvent ,CardNo ,UserCardType ";
				sql = sql.replaceAll("\\*", fileds);
				return jdbcUtil.selectForList(sql);
			}
			if (pager != null) {
				query.setFirstResult((pager.getCurrentPage() - 1) * pager.getPageSize());
				query.setMaxResults(pager.getPageSize());
			}
			return query.list();
		}else{
			Query query = null;
			if("1".equals(queryType)){
				query = getSession().createSQLQuery(sql).addScalar("ListNo", Hibernate.STRING).addScalar("AreaNo", Hibernate.INTEGER).addScalar("ParkNo", Hibernate.INTEGER).addScalar("GateName", Hibernate.STRING)
						.addScalar("LaneNo", Hibernate.INTEGER).addScalar("VehType", Hibernate.INTEGER).addScalar("VehClass", Hibernate.INTEGER).addScalar("VehPlate", Hibernate.STRING).addScalar("SquadNo", Hibernate.INTEGER)
						.addScalar("SquadDate", Hibernate.DATE).addScalar("OperatorNo", Hibernate.INTEGER).addScalar("OperatorName", Hibernate.STRING).addScalar("OpTime", Hibernate.STRING).addScalar("SpEvent", Hibernate.INTEGER)
						.addScalar("CardNo", Hibernate.STRING).addScalar("UserCardType", Hibernate.INTEGER).addScalar("PayCardType",Hibernate.INTEGER).addScalar("CashMoney",Hibernate.DOUBLE).addScalar("ETCMoney", Hibernate.DOUBLE);;
			}
			
			if("2".equals(queryType)){//导出流水
				String fileds = " ListNo , ParkNo, GateName ,LaneNo ,VehType  ,VehClass ,VehPlate ,SquadNo,SquadDate ,OperatorNo,OperatorName,OpTime ,SpEvent ,CardNo ,UserCardType ,InGateName, InLaneNo, TicketType ,PayCardType ,CashMoney ,ETCMoney ";
				sql = sql.replaceAll("\\*", fileds);
				return jdbcUtil.selectForList(sql);
			}
			if (pager != null) {
				query.setFirstResult((pager.getCurrentPage() - 1) * pager.getPageSize());
				query.setMaxResults(pager.getPageSize());
			}
			return query.list();
		}
	}

	public List printQuery(Pager pager, WaterQuery waterQuery) {
		// TODO Auto-generated method stub
		
		List list = null;
		//根据时间段去查
//		switch(waterQuery.getQueryType()){
//			case 0:
//				System.out.println(System.currentTimeMillis()+"---1");
//				list = queryOfDay(pager,waterQuery);
//				System.out.println(System.currentTimeMillis()+"---3");
//				break;
//			case 1:
//				list = queryOfWeek(pager,waterQuery);
//				break;
//			case 2:
//				list = queryOfMonth(pager,waterQuery);
//				break;
//			default:
//				break;
//		}
		//根据选定时间去查
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		list = query(pager,waterQuery,df.format(waterQuery.getDltime()),df.format(waterQuery.getDhtime()));
//		System.out.println(System.currentTimeMillis());
		return list;
	}
	/* 暂时不提供
	 * 最近三个月查询 
	 */
	private List queryOfThreeMon(Pager pager, WaterQuery waterQuery) {
		// TODO Auto-generated method stub
		//根据当前月取得之前第三个月的开始日期
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.MONTH, -2);
		int curIndex = cal.get(Calendar.DAY_OF_MONTH);
		//设置月初的日期
		cal.add(Calendar.DAY_OF_MONTH, -(curIndex-1));
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		cal.set(cal.get(Calendar.YEAR), cal.get(Calendar.MONTH),cal.get(Calendar.DAY_OF_MONTH),0,0,0);
		String startDate = df.format(cal.getTime());
		
		String endDate = df.format(new Date());
		return query(pager,waterQuery,startDate,endDate);
	}

	/*
	 * 当月查询
	 */
	private List queryOfMonth(Pager pager, WaterQuery waterQuery) {
		// TODO Auto-generated method stub
		//根据当天算所在的月的起始和结束日期
		Calendar cal = Calendar.getInstance();
		int curIndex = cal.get(Calendar.DAY_OF_MONTH);
		//设置月初的日期
		cal.add(Calendar.DAY_OF_MONTH, -(curIndex-1));
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		cal.set(cal.get(Calendar.YEAR), cal.get(Calendar.MONTH),cal.get(Calendar.DAY_OF_MONTH),0,0,0);
		String startDate = df.format(cal.getTime());
		
		//根据实际月份进行计算最后一天日期
		int max = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
		cal.add(Calendar.DAY_OF_MONTH, max-1);
		cal.set(cal.get(Calendar.YEAR), cal.get(Calendar.MONTH),cal.get(Calendar.DAY_OF_MONTH),23,59,59);
		String endDate = df.format(cal.getTime());
		return query(pager,waterQuery,startDate,endDate);
	}

	/*
	 * 当周查询
	 */
	private List queryOfWeek(Pager pager, WaterQuery waterQuery) {
		// TODO Auto-generated method stub
		//根据当天算所在的周起始日期和结束日期
		Calendar cal = Calendar.getInstance();
		cal.setFirstDayOfWeek(cal.SUNDAY);
		int curIndex = cal.get(Calendar.DAY_OF_WEEK);
		//以周日为一周的起始日
		//计算当日与周日的相差日数
		int i = curIndex -1;
		
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if(i!=0)cal.add(Calendar.DAY_OF_MONTH,-i);
		cal.set(cal.get(Calendar.YEAR), cal.get(Calendar.MONTH),cal.get(Calendar.DAY_OF_MONTH),0,0,0);
		String startDate = df.format(cal.getTime());
		//计算 本周最后一天
		cal.add(Calendar.DAY_OF_MONTH,6); 
		cal.set(cal.get(Calendar.YEAR), cal.get(Calendar.MONTH),cal.get(Calendar.DAY_OF_MONTH),23,59,59);
		String endDate = df.format(cal.getTime());
		return query(pager,waterQuery,startDate,endDate);
	}

	/*
	 * 当日查询
	 */
	private List queryOfDay(Pager pager, WaterQuery waterQuery) {
		// TODO Auto-generated method stub
		Map map = getDetailDate();
		return query(pager,waterQuery,(String)map.get("currentDateDetail"),(String)map.get("currentDateDetail"));
		 
	}
	
	/*
	 * map.put(year,2001);
	 * map.put(month,01);
	 * map.put(day,01);
	 * map.put(currentDate,2012-08-09);
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map getDetailDate(){
		Map map = new HashMap();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		DateFormat df1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Calendar cal = Calendar.getInstance();
		map.put("year",cal.get(Calendar.YEAR));
		String temp = ""+(cal.get(Calendar.MONTH)+1);
		temp = (temp.length()>1)?temp:"0"+temp;
		map.put("month", temp);
		temp =  ""+(cal.get(Calendar.DAY_OF_MONTH));
		temp = (temp.length()>1)?temp:"0"+temp;
		map.put("day", temp);
		map.put("currentDate", df.format(cal.getTime()));
		map.put("currentDateDetail", df1.format(cal.getTime()));
		return map;
	} 
	
	public Integer getCount(String sql,List obj){
		String countsql ="select count(*) " +sql;
		Query query = getSession().createSQLQuery(countsql);
        for (int i = 0; obj != null && i < obj.size(); i++) {  
            query.setParameter(i, obj.get(i));    
        } 
		return (Integer)query.uniqueResult();
	}
	
	@SuppressWarnings("unchecked")
	public List getTotalMoneyAndCount(String sql,List obj){
		String countsql ="select sum(cashMoney) totalMoney,count(*) Count " +sql;
		Query query = getSession().createSQLQuery(countsql).setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP); 
        for (int i = 0; obj != null && i < obj.size(); i++) {  
            query.setParameter(i, obj.get(i));    
        } 
		return query.list();
	}
	/**
	 * 
	 * @param pager
	 * @param waterQuery
	 * @param startDay  起始日期
	 * @param endDate	结束日期
	 * @return
	 */
	private List query(Pager pager, WaterQuery waterQuery,String startDay,String endDate) {
		// TODO Auto-generated method stub
		List list = new ArrayList();
		List list2 = new ArrayList();
		Integer totalmoney;
		Integer count;
		String month = startDay.substring(5,7);
		//根据页面传回的状态判断是查入场流水表还是出场流水表，默认是进场流水表
		String sqEventTable="inList";
		if(waterQuery.getSpEventState()==1)sqEventTable="outList";
		String opTime ="outList.InOpTime";
		if(waterQuery.getTimeState()==1)opTime="outList.OpTime";
		
		StringBuffer sql = new StringBuffer();
		sql.append("select outList.InOpTime inTime,outList.OpTime outTime,outList.InGateName entrance,outList.cashMoney cashMoney").append(
		",outList.CardNo cardNo,outList.VehPlate vehPlate,outList.InLaneNo inLaneNo,outList.operatorName operatorName,outList.VehType vehType,").append(
		"(select vehclassName from tb_VehClassCode where VehClassNo =outList.VehClass) as vehClass, ").
		append("(select SpEventName from tb_SpEventCode where SpEventNo =outList.SpEvent) as spEvent").append(
		" from tb_OutList").append(month).append(" outList ");
		if(waterQuery!=null&&waterQuery.getSpEvent()!=null&&waterQuery.getSpEventState()==0){
		sql.append(" right join tb_InList").append(month).append(" inList on (outlist.InListNo=inlist.ListNo)");
		}
		sql.append(" where ").append(opTime).append(">='").append(startDay).append(
		"' and  ").append(opTime).append("<='").append(endDate).append("'");
		
		if(waterQuery!=null&&waterQuery.getSpEvent()!=null&&!"".equals(waterQuery.getSpEvent())){
			int spLenght = waterQuery.getBinSqEvent().length();
			String indexMax = waterQuery.getBinSqEvent().substring(0, 1);
			int indexLenght = 31-spLenght+1;									
			sql.append(" and Substring(dbo.Dec2Bin(").append(sqEventTable).append(".spEvent,31),"+indexLenght+",1) = '" + indexMax +"'");
		}
//		else {
//			
//			sql.append(" and ").append(tableAsName).append(".spEvent =0 ");
//		}
		
		if(waterQuery!=null&&waterQuery.getCashType()!=null&&waterQuery.getCashType()==0){									
			sql.append(" and outList.VehClass<> 2 and outList.VehClass<>5 and outList.userCardType<>5 and outList.userCardType<>6").append(
					" and outList.userCardType<>10 and outList.userCardType<>16 and outList.CashMoney>0");
		}
		
		if(waterQuery!=null&&waterQuery.getCashType()!=null&&waterQuery.getCashType()==1){									
			sql.append(" and ((outList.VehClass<> 2 and outList.VehClass<>5 and outList.userCardType<>5 and outList.userCardType<>6").append(
					" and outList.userCardType<>10 and outList.userCardType<>16 and outList.CashMoney>0)").append(
					" or outList.spEvent<>0 or (outList.tickettype=3 and outList.VehClass<> 2 and outList.VehClass<>5 ").append(
							"and outList.userCardType<>5 and outList.userCardType<>6 and outList.userCardType<>10 and outList.userCardType<>16))");
		}
				
		if(waterQuery!=null&&waterQuery.getCashType()!=null&&waterQuery.getCashType()==2){									
			sql.append(" and (outList.tickettype=3 and outList.VehClass<> 2 and outList.VehClass<>5 ").append(
							"and outList.userCardType<>5 and outList.userCardType<>6 and outList.userCardType<>10 and outList.userCardType<>16)");
		}
		
		if(waterQuery!=null&&waterQuery.getLaneNo()!=null){									
			if(waterQuery.getLaneNoState()==0)
				sql.append(" and outList.InLaneNo=").append(waterQuery.getLaneNo());
				else
					sql.append(" and outList.LaneNo=").append(waterQuery.getLaneNo());
		}
		
		if(waterQuery!=null&&waterQuery.getSquadNo()!=null&&!"".equals(waterQuery.getSquadNo())){									
			sql.append(" and outList.squadNo=").append(waterQuery.getSquadNo());
		}
		
		if(waterQuery!=null&&waterQuery.getOperatorNo()!=null){									
			sql.append(" and outList.operatorNo =").append(waterQuery.getOperatorNo());
		}
		
		sql.append(" order by outList.opTime desc");
		String temp = sql.toString();
//		System.out.println(temp);
		Query query = getSession().createSQLQuery(temp).addScalar("inTime", Hibernate.TIMESTAMP).addScalar("outTime",  Hibernate.TIMESTAMP).
		addScalar("entrance", Hibernate.STRING).addScalar("cashMoney", Hibernate.SHORT).addScalar("cardNo", Hibernate.STRING).
		addScalar("vehPlate", Hibernate.STRING).addScalar("vehClass", Hibernate.STRING).addScalar("inLaneNo", Hibernate.SHORT).
		addScalar("operatorName",Hibernate.STRING).addScalar("vehType",Hibernate.SHORT).addScalar("spEvent",Hibernate.STRING).
		setResultTransformer(Transformers.aliasToBean(WaterQuery.class));
//        if(pager != null){
        	//long l1 = System.currentTimeMillis();
        	//pager.setTotalSize(	getCount(temp.substring(temp.indexOf("from")),null));
//        	long l11= System.currentTimeMillis();
//        	pager.setTotalSize(	getCount(temp.substring(temp.lastIndexOf("from"),temp.indexOf("order")),null));
//        	System.out.println("统计总数用时："+(System.currentTimeMillis()-l11));
        	//System.out.println(System.currentTimeMillis()-l1+"----->>>");
        	//pager.setTotalSize(1000);
        	//pager.setTotalSize(jdbcUtil.select(temp));
//        	query.setFirstResult((pager.getCurrentPage() - 1) * pager.getPageSize());
//        	query.setMaxResults(pager.getPageSize());
//        }        
//        long l1 = System.currentTimeMillis();
//        System.out.println("start:"+l1);
        if(pager != null)
        {
//        	long time1=System.currentTimeMillis();
//        	System.out.println("time1="+time1);
        	list2=getTotalMoneyAndCount(temp.substring(temp.lastIndexOf("from"),temp.indexOf("order")),null);
        	Map map = (Map)list2.get(0);
        	totalmoney=(Integer) map.get("totalMoney");
        	count=(Integer) map.get("Count");
        	waterQuery.setTotalMoney(totalmoney);
        	pager.setTotalSize(count);
//        	long time2=System.currentTimeMillis();
//        	System.out.println("time2="+time2);
//        	System.out.println("计算总额和总流量的统计总数用时："+(time2-time1));
        	query.setFirstResult((pager.getCurrentPage() - 1) * pager.getPageSize());
        	query.setMaxResults(pager.getPageSize());
        }
		return query.list();
	}

	@SuppressWarnings("unchecked")
	public List<CardDynamic> queryAllNoRecycle(){
		String hql = "from CardDynamic cardDynamic where cardDynamic.vehPlate != '0' and cardDynamic.status = 11 order by cardDynamic.opTime desc";
		List<CardDynamic> list = this.executeQuery(hql);
		return list;
	}	
}

