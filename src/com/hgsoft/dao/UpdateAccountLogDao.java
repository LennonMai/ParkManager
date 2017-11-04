package com.hgsoft.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.hgsoft.entity.UpdateAccountLog;
import com.hgsoft.util.Pager;
@Repository
public class UpdateAccountLogDao extends BaseDao<UpdateAccountLog>{
/*	@SuppressWarnings("unchecked")
	public List<UpdateAccountLog> getUpdateAccountLogByAccountNo(int accountNo) {
		String hql="from UpdateAccountLog updateAccountLog where  updateAccountLog.accountNo=? order by SeqNo desc";
		List resultList=executeQuery(hql,accountNo);
		return resultList;
		
	}*/

	@SuppressWarnings("unchecked")
	public UpdateAccountLog getUpdateAccountLogByAccountNoOrder(int accountNo) {
		String hql="from UpdateAccountLog updateAccountLog where  updateAccountLog.accountNo=? order by updateAccountLog.seqNo desc";
		List resultList=executeQuery(hql,accountNo);
		if(resultList.isEmpty())return null;
		else return (UpdateAccountLog) resultList.get(0);
		
	}
	
	@SuppressWarnings("unchecked")
	public UpdateAccountLog getUpdateAccountLogByAccountNoAndSeqNo(int accountNo,int seqNo) {
		String hql="from UpdateAccountLog updateAccountLog where  updateAccountLog.accountNo=? and updateAccountLog.seqNo=?";
		List resultList=executeQuery(hql,accountNo,seqNo);
		if(resultList.isEmpty())return null;
		else return (UpdateAccountLog) resultList.get(0);
		
	}
	@SuppressWarnings("unchecked")
	public List<UpdateAccountLog> findAllItemByHql(Pager pager,Integer accountNo,String cardNo,String userName,Integer credentialsType,String credentialsNo,String vehPlate,Integer status){
		
		StringBuffer sf = new StringBuffer("from UpdateAccountLog updateAccountLog where");
		List<Object> obj = new ArrayList<Object>();
		if(accountNo != null){
			sf.append(" updateAccountLog.accountNo =? and");
		   
			obj.add(accountNo);
			
		}
		if(!"".equals(cardNo)){
			
			sf.append(" updateAccountLog.cardNo like? and");
		    obj.add("%"+cardNo+"%");
		}
		
		if(!"".equals(userName)){
			sf.append(" updateAccountLog.userName like ? and");
			obj.add("%"+userName+"%");
		
		}
		if(credentialsType != null){
			sf.append(" updateAccountLog.credentialsType=? and");
			obj.add(credentialsType);
		}
		if(!"".equals(credentialsNo)){
			sf.append(" updateAccountLog.credentialsNo like? and");
			obj.add("%"+credentialsNo+"%");
		}
		
		if(!"".equals(vehPlate)){
			sf.append(" updateAccountLog.vehPlate like? and");
			obj.add("%"+vehPlate+"%");
		}
		if(status != null){
			sf.append(" updateAccountLog.status =? and");
		    
			obj.add(status);
			
		}
		
		sf = sf.replace(sf.length() - 4, sf.length(), "");
		//查出总行数，对分页进行设置
		//System.out.println(sf.toString()+"obj"+obj.get(0));
		
		Long count = executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
	
		return this.executeQuery(pager,sf.toString(), obj.toArray());
	}
	
	@SuppressWarnings("unchecked")
	public List<UpdateAccountLog> findAllItemByHqlAndTime(Pager pager,Integer accountNo,String cardNo,String userName,Integer credentialsType,String credentialsNo,String vehPlate,Integer status,Date startTime1,Date endTime1){
		
		StringBuffer sf = new StringBuffer("from UpdateAccountLog updateAccountLog where");
		List<Object> obj = new ArrayList<Object>();
		if(accountNo != null){
			sf.append(" updateAccountLog.accountNo =? and");
		   
			obj.add(accountNo);
			
		}
		if(!"".equals(cardNo)){
			
			sf.append(" updateAccountLog.cardNo like? and");
		    obj.add("%"+cardNo+"%");
		}
		
		if(!"".equals(userName)){
			sf.append(" updateAccountLog.userName like ? and");
			obj.add("%"+userName+"%");
		
		}
		if(credentialsType != null){
			sf.append(" updateAccountLog.credentialsType=? and");
			obj.add(credentialsType);
		}
		if(!"".equals(credentialsNo)){
			sf.append(" updateAccountLog.credentialsNo like? and");
			obj.add("%"+credentialsNo+"%");
		}
		
		if(!"".equals(vehPlate)){
			sf.append(" updateAccountLog.vehPlate like? and");
			obj.add("%"+vehPlate+"%");
		}
		if(status != null){
			sf.append(" updateAccountLog.status =? and");
		    
			obj.add(status);
			
		}
		if (startTime1 != null) {
			sf.append(" updateAccountLog.updateTime>=? and");
			obj.add(startTime1);
		}
		if (endTime1 != null) {
			sf.append(" updateAccountLog.updateTime<=? and");
			obj.add(endTime1);
		}
		
		sf = sf.replace(sf.length() - 4, sf.length(), "");
		//查出总行数，对分页进行设置
		//System.out.println(sf.toString()+"obj"+obj.get(0));
		
		Long count = executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
	
		return this.executeQuery(pager,sf.toString() + " order by updateAccountLog.updateTime desc", obj.toArray());
	}
	
	

}
