package com.hgsoft.dao;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;

import org.hibernate.Query;
import org.springframework.stereotype.Repository;
import com.hgsoft.entity.VAccountTrade;
import com.hgsoft.util.HashUtil;
import com.hgsoft.util.Pager;

@Repository 

public class VAccountTradeDao extends BaseDao<VAccountTrade> {
	@SuppressWarnings("unchecked")
	public List<VAccountTrade> findAllItem(Pager pager) {
		StringBuffer sf = new StringBuffer("from VAccountTrade vAccountTrade where vAccountTrade.tradeType!=0 and vAccountTrade.tradeType!=3 and vAccountTrade.tradeType!=4 and vAccountTrade.tradeType!=5");
		List<Object> obj = new ArrayList<Object>();
		// 查出总行数，对分页进行设置
		// System.out.println(sf.toString()+"obj"+obj.get(0));
		Long count = executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
		return this.executeQuery(pager, sf.toString()+" order by vAccountTrade.opTime desc", obj.toArray());
	}
	
@SuppressWarnings("unchecked")
public List<VAccountTrade> findAllItemByHql(Pager pager,Integer sys_id,String cardNo,String userName,Integer tradeType,String credentialsNo,String vehPlate,Integer status,String startTime,String endTime){
		StringBuffer sf = new StringBuffer("from VAccountTrade vAccountTrade where vAccountTrade.tradeType!=0 and vAccountTrade.tradeType!=3 and vAccountTrade.tradeType!=4 and vAccountTrade.tradeType!=5 and");//多条件查询，空不加入否则加入查询条件
		List<Object> obj = new ArrayList<Object>();
		if(sys_id != null){
			sf.append(" vAccountTrade.account.sys_id =?  and");
		   
			obj.add(sys_id);
			
		}
		if(!"".equals(cardNo)){
			
			sf.append(" vAccountTrade.account.cardNo like? and");
		    obj.add("%"+cardNo+"%");
		}
		
		if(!"".equals(userName)){
			sf.append(" vAccountTrade.account.user.userName like ? and");
			obj.add("%"+userName+"%");
		
		}
		if(tradeType != null){
			sf.append(" vAccountTrade.tradeType=? and");
			obj.add(tradeType);
		}

		if(!"".equals(credentialsNo)){
			sf.append(" vAccountTrade.account.user.credentialsNo like? and");
			obj.add("%"+credentialsNo+"%");
		}
		
		if(!"".equals(vehPlate)){
			sf.append(" vAccountTrade.account.car.vehPlate like? and");
			obj.add("%"+vehPlate+"%");
		}
		if(status != null){
			sf.append(" vAccountTrade.account.status =?  and");
		   
			obj.add(status);
			
		}
		if (!"".equals(startTime)) {
			sf.append("  vAccountTrade.opTime>= ? and");
			obj.add(startTime);
		}
		if (!"".equals(endTime)) {
			sf.append("  vAccountTrade.opTime<= ? and");
			obj.add(endTime);
		}
		
		
		sf = sf.replace(sf.length() - 4, sf.length(), "");
		
		//查出总行数，对分页进行设置
		//System.out.println(sf.toString()+"obj"+obj.get(0));
		
		Long count = executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
		//sf.append(" order by vAccountTrade.account.sys_id,vAccountTrade.seqNo desc");
		sf.append(" order by vAccountTrade.opTime desc");
		return this.executeQuery(pager,sf.toString(), obj.toArray());
	}

@SuppressWarnings("unchecked")
public List<VAccountTrade> findAllItemToQueryByHql(Pager pager,Integer sys_id,String cardNo,String userName,Integer tradeType,String credentialsNo,String vehPlate,Integer status,String startTime,String endTime){
		
	    StringBuffer sf = new StringBuffer("from VAccountTrade vAccountTrade where");//多条件查询，空不加入否则加入查询条件
		List<Object> obj = new ArrayList<Object>();
		if(sys_id != null){
			sf.append(" vAccountTrade.account.sys_id =?  and");
		   
			obj.add(sys_id);
			
		}
		if(!"".equals(cardNo)){
			
			sf.append(" vAccountTrade.account.cardNo like? and");
		    obj.add("%"+cardNo+"%");
		}
		
		if(!"".equals(userName)){
			sf.append(" vAccountTrade.account.user.userName like ? and");
			obj.add("%"+userName+"%");
		
		}
		if(tradeType != null){
			sf.append(" vAccountTrade.tradeType=? and");
			obj.add(tradeType);
		}

		if(!"".equals(credentialsNo)){
			sf.append(" vAccountTrade.account.user.credentialsNo like? and");
			obj.add("%"+credentialsNo+"%");
		}
		
		if(!"".equals(vehPlate)){
			sf.append(" vAccountTrade.account.car.vehPlate like? and");
			obj.add("%"+vehPlate+"%");
		}
		if(status != null){
			sf.append(" vAccountTrade.account.status =?  and");
		   
			obj.add(status);
			
		}
		if (!"".equals(startTime)) {
			sf.append("  vAccountTrade.opTime>= ? and");
			obj.add(startTime);
		}
		if (!"".equals(endTime)) {
			sf.append("  vAccountTrade.opTime<= ? and");
			obj.add(endTime);
		}
		
		
		sf = sf.replace(sf.length() - 4, sf.length(), "");
		
		//查出总行数，对分页进行设置
		//System.out.println(sf.toString()+"obj"+obj.get(0));
		
		Long count = executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
		//sf.append(" order by vAccountTrade.account.sys_id,vAccountTrade.seqNo desc");
		sf.append(" order by vAccountTrade.opTime desc");
		return this.executeQuery(pager,sf.toString(), obj.toArray());
	}


@SuppressWarnings("unchecked")
public VAccountTrade getVAccountTradeByAccountNoAndlistNo(int accountNo, String listNo) {// 根据交易流水号和账号查询交易流水信息
	String hql = "from VAccountTrade vAccountTrade where  vAccountTrade.account.sys_id=? and vAccountTrade.listNo=?";
	List resultList = executeQuery(hql, accountNo, listNo);
	if (resultList.isEmpty())
		return null;
	else
		return (VAccountTrade) resultList.get(0);

}
// qinzuohai
// 根据用户输入条件查询账户最新余额
@SuppressWarnings("unchecked")
public List<VAccountTrade> findLatestAccountBalanceForSingle(Pager pager, String userName, String vehPlate, Integer sys_id, String cardNo) {

	StringBuffer sf = new StringBuffer("from VAccountTrade act where");
	List<Object> obj = new ArrayList<Object>();
	if (!userName.equals("")) {
		sf.append(" act.account.user.userName like ? and ");
		obj.add("%" + userName + "%");
	}
	if (!vehPlate.equals("")) {
		sf.append(" act.account.car.vehPlate like ? and ");
		obj.add("%" + vehPlate + "%");
	}
	if (sys_id != null) {
		sf.append(" act.account.sys_id = ? and ");
		obj.add(sys_id);
	}
	if (!cardNo.equals("")) {
		sf.append(" act.cardNo like ? and ");
		obj.add("%" + cardNo + "%");
	}

	sf.append(" " + "act.cardNo=act.account.cardNo and act.seqNo=(select Max(act.seqNo) from VAccountTrade act where act.account.cardNo=act.cardNo group by act.cardNo)");
	// sf = sf.replace(sf.length() - 4, sf.length(), "");
	// 查出总行数，对分页进行设置
	System.out.println("**** HQL查询语句 ****：" + sf);
	Long count = this.executeCount(sf.toString(), obj.toArray());
	pager.setTotalSize(count);
	return this.executeQuery(pager, sf.toString(), obj.toArray());
}

// 查询账号的最新余额
@SuppressWarnings("unchecked")
public List<VAccountTrade> findAllLatestBalance(Pager pager) {
	String hql = " from VAccountTrade act where act.cardNo=act.account.cardNo and act.seqNo=(select Max(act.seqNo) from VAccountTrade act where act.account.cardNo=act.cardNo group by act.cardNo)";
	Query query = getSession().createQuery(hql);
	pager.setTotalSize(query.list().size());
	if (!query.list().isEmpty()) {
		if (pager != null) {
			query.setFirstResult((pager.getCurrentPage() - 1) * pager.getPageSize());
			query.setMaxResults(pager.getPageSize());
		}
		return query.list();
	}
	return null;
}

// 分页查询某时间段的流水
@SuppressWarnings("unchecked")
public List<VAccountTrade> findAccountTradeStartTimeToEndTime(Pager pager, Date verify_startTime, Date verify_endTime) {
	String hql = " from VAccountTrade act where  act.tradeTime between ? and ? ";
	Query query = getSession().createQuery(hql);
	query.setDate(0, verify_startTime);
	query.setDate(1, verify_endTime);
	// System.out.println("分页某时间段的流水size:"+query.list().size());
	pager.setTotalSize(query.list().size());
	if (!query.list().isEmpty()) {
		if (pager != null) {
			query.setFirstResult((pager.getCurrentPage() - 1) * pager.getPageSize());
			query.setMaxResults(pager.getPageSize());
		}
		return query.list();
	}
	return null;
}

// 根据输入信息查询流水信息总条数
public Long findAccountTradeStartTimeToEndTime(String keyMD5, Date verify_startTime, Date verify_endTime, String userName, String cardNo, String vehPlate, Integer tradeType) {
	// System.out.println(" 效验条件---- : "+userName+"--"+cardNo+"--"+vehPlate+"--"+tradeType);

	String startTime = null, endTime = null;
	// 日期Date类型转换为String
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	if (verify_startTime != null) {
		startTime = dateFormat.format(verify_startTime);
	}
	if (verify_endTime != null) {
		endTime = dateFormat.format(verify_endTime);
	}

	// System.out.println(" 效验时间: "+startTime+" - "+endTime);

	StringBuffer sf = new StringBuffer(" from VAccountTrade act where");
	List<Object> obj = new ArrayList<Object>();

	if (!userName.equals("")) {
		sf.append(" act.account.user.userName like ? and ");
		obj.add("%" + userName + "%");
	}
	if (!vehPlate.equals("")) {
		sf.append(" act.vehPlate like ? and ");
		obj.add("%" + vehPlate + "%");
	}
	if (!cardNo.equals("")) {
		sf.append(" act.cardNo like ? and ");
		obj.add("%" + cardNo + "%");
	}
	if (tradeType != null) {
		sf.append(" act.tradeType = ? and ");
		obj.add(tradeType);
	}
	if (startTime != null) {
		sf.append("  act.tradeTime >=? and ");
		obj.add(startTime);
	}
	if (endTime != null) {
		sf.append("  act.tradeTime <= ? and ");
		obj.add(endTime);
	}
	sf = sf.replace(sf.length() - 4, sf.length(), "");
	return this.executeCount(sf.toString(), obj.toArray());
}

// 输出效验全部的流水记录
public LinkedHashMap<String, VAccountTrade> findAllValidateAccountTrade(Pager pager, String keyMD5, Date verify_startTime, Date verify_endTime, String userName, String cardNo, String vehPlate, Integer tradeType) {
	// System.out.println(" 效验条件---- : "+userName+"--"+cardNo+"--"+vehPlate+"--"+tradeType);
	String startTime = null, endTime = null;
	// 日期Date类型转换为String
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	if (verify_startTime != null) {
		startTime = dateFormat.format(verify_startTime);
	}
	if (verify_endTime != null) {
		endTime = dateFormat.format(verify_endTime);
	}

	// System.out.println(" 效验时间: "+startTime+" - "+endTime);

	StringBuffer sf = new StringBuffer(" from VAccountTrade act where");
	List<Object> obj = new ArrayList<Object>();

	if (!userName.equals("")) {
		sf.append(" act.account.user.userName like ? and ");
		obj.add("%" + userName + "%");
	}
	if (!vehPlate.equals("")) {
		sf.append(" act.vehPlate like ? and ");
		obj.add("%" + vehPlate + "%");
	}
	if (!cardNo.equals("")) {
		sf.append(" act.cardNo like ? and ");
		obj.add("%" + cardNo + "%");
	}
	if (tradeType != null) {
		sf.append(" act.tradeType = ? and ");
		obj.add(tradeType);
	}
	if (startTime != null) {
		sf.append("  act.tradeTime >=? and ");
		obj.add(startTime);
	}
	if (endTime != null) {
		sf.append("  act.tradeTime <= ? and ");
		obj.add(endTime);
	}
	sf = sf.replace(sf.length() - 4, sf.length(), "");
	Long count = this.executeCount(sf.toString(), obj.toArray());
	pager.setTotalSize(count);
	@SuppressWarnings("unchecked")
	List<VAccountTrade> validatelist = this.executeQuery(pager, sf.toString() + " order by act.account.sys_id desc", obj.toArray());

	String validateVerify = null;
	String createMD5 = null, sourceMD5 = null;
	LinkedHashMap<String, VAccountTrade> validateMap = new LinkedHashMap<String, VAccountTrade>();
	for (int i = 0; i < validatelist.size(); i++) {
		validateVerify = this.TrimNull(validatelist.get(i).getAccount().getSys_id()) + "_" 
							+ this.TrimNull(validatelist.get(i).getSeqNo()) + "_" 
							+ this.TrimNull(validatelist.get(i).getTradeType()) + "_" 
							+ this.TrimNull(validatelist.get(i).getFee()) + "_" 
							+ this.TrimNull(validatelist.get(i).getBalance()) + "_" 
							+ this.TrimNull(validatelist.get(i).getCardNo()) + "_" 
							+ this.TrimNull(validatelist.get(i).getCardType()) + "_" 
							+ this.TrimNull(validatelist.get(i).getVehPlate()) + "_" 
							+ this.TrimNull(validatelist.get(i).getListNo()) + "_" 
							+ this.TrimNull(validatelist.get(i).getOperatorID()) + "_" 
							+ this.TrimNull(validatelist.get(i).getOperatorPassword().trim()) + "_" 
							+ this.TrimNull(validatelist.get(i).getTradeTime()) + "_" 
							+ this.TrimNull(validatelist.get(i).getOpTime()) + "_" 
							+ keyMD5;

		//System.out.println("-- 效验前的串 --:"+ validateVerify);

		createMD5 = HashUtil.getMD5String(validateVerify).trim();
		sourceMD5 = validatelist.get(i).getVerify().trim();
		
//		System.out.println(i + "- 效验前 ---------   源MD5:"+ sourceMD5);
//		System.out.println(i + "- 效验后 --------- 生成MD5:"+ createMD5+"\n");
		
		// System.out.println(i + "- 已通过效验_查看数据排序："+
		// validatelist.get(i).getAccount().getSys_id());
		if (sourceMD5.equals(createMD5)) {
			// System.out.println(i + "- 查看数据排序："+
			// validatelist.get(i).getAccount().getSys_id());
			validateMap.put("已通过效验_[" + validatelist.get(i).getAccount().getSys_id() + "_" + validatelist.get(i).getSeqNo() + "]", validatelist.get(i));
		}
		if (!sourceMD5.equals(createMD5)) {
			// System.out.println(i + "- 效验不通过_查看数据排序："+
			// validatelist.get(i).getAccount().getSys_id());
			validateMap.put("效验不通过_[" + validatelist.get(i).getAccount().getSys_id() + "_" + validatelist.get(i).getSeqNo() + "]", validatelist.get(i));
		}
	}

	// System.out.println("validateMap size:"+validateMap.size());
	// for(Map.Entry<String, AccountTrade> entry:validateMap.entrySet()){
	// System.out.println("key:"+entry.getKey().toString()+" - "+"value:"+entry.getValue().getAccount().getSys_id());
	// }
	return validateMap;
}

// 输出效验通过的流水记录
@SuppressWarnings("unchecked")
public List<VAccountTrade> findPassValidateAccountTrade(Pager pager, String keyMD5, Date verify_startTime, Date verify_endTime, String userName, String cardNo, String vehPlate, Integer tradeType) {

	String startTime = null, endTime = null;
	// 日期Date类型转换为String
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	if (verify_startTime != null) {
		startTime = dateFormat.format(verify_startTime);
	}
	if (verify_endTime != null) {
		endTime = dateFormat.format(verify_endTime);
	}

	StringBuffer sf = new StringBuffer(" from VAccountTrade act where");
	List<Object> obj = new ArrayList<Object>();
	if (!userName.equals("")) {
		sf.append(" act.account.user.userName like ? and ");
		obj.add("%" + userName + "%");
	}
	if (!vehPlate.equals("")) {
		sf.append(" act.vehPlate like ? and ");
		obj.add("%" + vehPlate + "%");
	}
	if (!cardNo.equals("")) {
		sf.append(" act.cardNo like ? and ");
		obj.add("%" + cardNo + "%");
	}
	if (tradeType != null) {
		sf.append(" act.tradeType = ? and ");
		obj.add(tradeType);
	}
	if (startTime != null) {
		sf.append("  act.tradeTime >=? and ");
		obj.add(startTime);
	}
	if (endTime != null) {
		sf.append("  act.tradeTime <= ? and ");
		obj.add(endTime);
	}
	sf = sf.replace(sf.length() - 4, sf.length(), "");
	List<VAccountTrade> validatelist = this.executeQuery(sf.toString() + " order by act.account.sys_id desc", obj.toArray());

	String validateVerify = null;
	String createMD5 = null, sourceMD5 = null;
	List<VAccountTrade> passList = new ArrayList<VAccountTrade>();
	for (int i = 0; i < validatelist.size(); i++) {
		// validateVerify = validatelist.get(i).getAccount().getSys_id() +
		// "_"
		// + validatelist.get(i).getSeqNo() + "_"
		// + validatelist.get(i).getTradeType() + "_"
		// + validatelist.get(i).getFee() + "_"
		// + validatelist.get(i).getBalance() + "_"
		// + validatelist.get(i).getCardNo() + "_"
		// + validatelist.get(i).getCardType() + "_"
		// + validatelist.get(i).getVehPlate() + "_"
		// + validatelist.get(i).getListNo() + "_"
		// + validatelist.get(i).getOperatorID() + "_"
		// + validatelist.get(i).getOperatorPassword() + "_"
		// + validatelist.get(i).getTradeTime() + "_"
		// + validatelist.get(i).getOpTime() + "_" + keyMD5;
		// // 值为空则null->""
		// validateVerify = validateVerify.replaceAll("null", "");

		validateVerify = this.TrimNull(validatelist.get(i).getAccount().getSys_id()) + "_" 
					+ this.TrimNull(validatelist.get(i).getSeqNo()) + "_" 
					+ this.TrimNull(validatelist.get(i).getTradeType()) + "_" 
					+ this.TrimNull(validatelist.get(i).getFee()) + "_" 
					+ this.TrimNull(validatelist.get(i).getBalance()) + "_" 
					+ this.TrimNull(validatelist.get(i).getCardNo()) + "_" 
					+ this.TrimNull(validatelist.get(i).getCardType()) + "_" 
					+ this.TrimNull(validatelist.get(i).getVehPlate()) + "_" 
					+ this.TrimNull(validatelist.get(i).getListNo()) + "_" 
					+ this.TrimNull(validatelist.get(i).getOperatorID()) + "_" 
					+ this.TrimNull(validatelist.get(i).getOperatorPassword().trim()) + "_" 
					+ this.TrimNull(validatelist.get(i).getTradeTime()) + "_" 
					+ this.TrimNull(validatelist.get(i).getOpTime()) + "_" 
					+ keyMD5;

		// System.out.println("-- 效验前的串 --:"+ validateVerify);

		createMD5 = HashUtil.getMD5String(validateVerify).trim();
		sourceMD5 = validatelist.get(i).getVerify().trim();

		// System.out.println(i + "- 效验前 --------- 成MD5:"+ createMD5);
		// System.out.println(i + "- 效验前 --------- 源MD5:"+ sourceMD5);

		if (sourceMD5.equals(createMD5)) {
			passList.add(validatelist.get(i));
			// System.out.println(i + "- 效验后 --------- 成MD5:"+ createMD5);
			// System.out.println(i + "- 效验后 --------- 源MD5:"+ sourceMD5);
		}
	}
	// System.out.println("passList size:" + passList.size());
	pager.setTotalSize(passList.size());
	int startIndex = (pager.getCurrentPage() - 1) * pager.getPageSize();
	int endIndex = pager.getPageSize();

	if (!passList.isEmpty()) {
		// IndexOutOfBoundsException - 非法的端点值 (startIndex < 0 || endIndex >
		// size || startIndex > endIndex)
		try {
			if (endIndex > passList.size()) {
				endIndex = passList.size();
				// System.out.println("1 - endIndex>passList.size()-----startIndex-"
				// + startIndex + "  endIndex-" + endIndex);

				return passList.subList(startIndex, endIndex);

			} else if (startIndex >= endIndex) {
				endIndex = startIndex + endIndex;
				if (passList.size() > endIndex) {

					// System.out.println("2 -1 startIndex >= endIndex-----startIndex-"
					// + startIndex + "  endIndex-" + endIndex);

					return passList.subList(startIndex, endIndex);
				}
				if (passList.size() < endIndex) {
					endIndex = passList.size();
					// System.out.println("2 -2 startIndex >= endIndex-----startIndex-"
					// + startIndex + "  endIndex-" + endIndex);

					return passList.subList(startIndex, endIndex);
				}

			} else {
				// System.out.println("3 - right-----startIndex-" +
				// startIndex
				// + "  endIndex-" + endIndex);

				return passList.subList(startIndex, endIndex);
			}

		} catch (IndexOutOfBoundsException e) {
			e.printStackTrace();
		}
	}
	return null;
}

// 输出不通过效验的流水记录
@SuppressWarnings( { "unchecked" })
public List<VAccountTrade> findFailValidateAccountTrade(Pager pager, String keyMD5, Date verify_startTime, Date verify_endTime, String userName, String cardNo, String vehPlate, Integer tradeType) {

	String startTime = null, endTime = null;
	// 日期Date类型转换为String
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	if (verify_startTime != null) {
		startTime = dateFormat.format(verify_startTime);
	}
	if (verify_endTime != null) {
		endTime = dateFormat.format(verify_endTime);
	}

	StringBuffer sf = new StringBuffer(" from VAccountTrade act where");
	List<Object> obj = new ArrayList<Object>();
	if (!userName.equals("")) {
		sf.append(" act.account.user.userName like ? and ");
		obj.add("%" + userName + "%");
	}
	if (!vehPlate.equals("")) {
		sf.append(" act.vehPlate like ? and ");
		obj.add("%" + vehPlate + "%");
	}
	if (!cardNo.equals("")) {
		sf.append(" act.cardNo like ? and ");
		obj.add("%" + cardNo + "%");
	}
	if (tradeType != null) {
		sf.append(" act.tradeType = ? and ");
		obj.add(tradeType);
	}
	if (startTime != null) {
		sf.append("  act.tradeTime >=? and ");
		obj.add(startTime);
	}
	if (endTime != null) {
		sf.append("  act.tradeTime <= ? and ");
		obj.add(endTime);
	}
	sf = sf.replace(sf.length() - 4, sf.length(), "");
	List<VAccountTrade> validatelist = this.executeQuery(sf.toString() + " order by act.account.sys_id desc", obj.toArray());

	String validateVerify = null;
	String createMD5 = null, sourceMD5 = null;
	List<VAccountTrade> incorrectList = new ArrayList<VAccountTrade>();

	for (int i = 0; i < validatelist.size(); i++) {
		// validateVerify = validatelist.get(i).getAccount().getSys_id() +
		// "_"
		// + validatelist.get(i).getSeqNo() + "_"
		// + validatelist.get(i).getTradeType() + "_"
		// + validatelist.get(i).getFee() + "_"
		// + validatelist.get(i).getBalance() + "_"
		// + validatelist.get(i).getCardNo() + "_"
		// + validatelist.get(i).getCardType() + "_"
		// + validatelist.get(i).getVehPlate() + "_"
		// + validatelist.get(i).getListNo() + "_"
		// + validatelist.get(i).getOperatorID() + "_"
		// + validatelist.get(i).getOperatorPassword() + "_"
		// + validatelist.get(i).getTradeTime() + "_"
		// + validatelist.get(i).getOpTime() + "_" + keyMD5;

		// 值为空则null->""
		// validateVerify = validateVerify.replaceAll("null", "");

		validateVerify = this.TrimNull(validatelist.get(i).getAccount().getSys_id()) + "_" + this.TrimNull(validatelist.get(i).getSeqNo()) + "_" + this.TrimNull(validatelist.get(i).getTradeType()) + "_" + this.TrimNull(validatelist.get(i).getFee()) + "_" + this.TrimNull(validatelist.get(i).getBalance()) + "_" + this.TrimNull(validatelist.get(i).getCardNo()) + "_" + this.TrimNull(validatelist.get(i).getCardType()) + "_" + this.TrimNull(validatelist.get(i).getVehPlate()) + "_" + this.TrimNull(validatelist.get(i).getListNo()) + "_" + this.TrimNull(validatelist.get(i).getOperatorID()) + "_" + this.TrimNull(validatelist.get(i).getOperatorPassword().trim()) + "_" + this.TrimNull(validatelist.get(i).getTradeTime()) + "_" + this.TrimNull(validatelist.get(i).getOpTime()) + "_" + keyMD5;

		// System.out.println("-- 效验前的串 --:"+ validateVerify);

		createMD5 = HashUtil.getMD5String(validateVerify).trim();
		sourceMD5 = validatelist.get(i).getVerify().trim();

		// System.out.println(i + "--incorrect 效验前 --------- 成MD5:"+
		// createMD5);
		// System.out.println(i + "--incorrect 效验前 --------- 源MD5:"+
		// sourceMD5);

		if (!sourceMD5.equals(createMD5)) {
			incorrectList.add(validatelist.get(i));
			// System.out.println(i + "-- incorrect 效验后 --------- 成MD5:"+
			// createMD5);
			// System.out.println(i + "-- incorrect 效验后 --------- 源MD5:"+
			// sourceMD5);
		}

	}
	// System.out.println("incorrectList size:" + incorrectList.size());
	pager.setTotalSize(incorrectList.size());
	int startIndex = (pager.getCurrentPage() - 1) * pager.getPageSize();
	int endIndex = pager.getPageSize();

	if (!incorrectList.isEmpty()) {
		if (pager != null) {
			// IndexOutOfBoundsException - 非法的端点值 (startIndex < 0 ||
			// endIndex > size || startIndex > endIndex)
			try {
				if (endIndex > incorrectList.size()) {
					endIndex = incorrectList.size();
					// System.out.println("1 - endIndex>incorrectList.size()-----startIndex-"
					// + startIndex + "  endIndex-" + endIndex);
					return incorrectList.subList(startIndex, endIndex);

				} else if (startIndex >= endIndex) {
					endIndex = startIndex + endIndex;
					if (incorrectList.size() > endIndex) {

						// System.out.println("2 -1 startIndex >= endIndex-----startIndex-"
						// + startIndex + "  endIndex-" + endIndex);
						return incorrectList.subList(startIndex, endIndex);
					}
					if (incorrectList.size() < endIndex) {
						endIndex = incorrectList.size();
						// System.out.println("2 -2 startIndex >= endIndex-----startIndex-"
						// + startIndex + "  endIndex-" + endIndex);
						return incorrectList.subList(startIndex, endIndex);
					}

				} else {
					// System.out.println("3 - right-----startIndex-" +
					// startIndex
					// + "  endIndex-" + endIndex);

					return incorrectList.subList(startIndex, endIndex);
				}

			} catch (IndexOutOfBoundsException e) {
				e.printStackTrace();
			}

		}
	}
	return null;

}

public Object TrimNull(Object obj) {
	if (obj == null) {
		obj = "";
		return obj;
	} else {
		return obj;
	}
}
}
