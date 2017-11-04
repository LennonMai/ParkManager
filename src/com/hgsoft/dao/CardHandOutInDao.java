package com.hgsoft.dao;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.hgsoft.entity.CardHandOutIn;
import com.hgsoft.util.Pager;
@Repository 
public class CardHandOutInDao extends BaseDao<CardHandOutIn>{
	@SuppressWarnings("unchecked")
	public List<CardHandOutIn> findAllItemByHql(Pager pager,Timestamp squadDate,Short squadNo,Short type,Short parkNo,Short gateNo,Short laneNo,Integer operatorNo,Integer recorderNo){		
		StringBuffer sf = new StringBuffer("from CardHandOutIn cardHandOutIn where");
		List<Object> obj = new ArrayList<Object>();
		if(squadDate != null){
			sf.append(" cardHandOutIn.squadDate =? and");	   
			obj.add(squadDate);
			
		}
		if(squadNo != null){
			sf.append(" cardHandOutIn.squadNo =? and");		   
			obj.add(squadNo);
			
		}
		if(type != null){
			sf.append(" cardHandOutIn.type =? and");		   
			obj.add(type);
			
		}
		if(parkNo != null){
			sf.append(" cardHandOutIn.parkNo =? and");		   
			obj.add(parkNo);
			
		}
		if(gateNo != null){
			sf.append(" cardHandOutIn.gateNo =? and");		   
			obj.add(gateNo);
			
		}
		if(laneNo != null){
			sf.append(" cardHandOutIn.laneNo =? and");		   
			obj.add(laneNo);
			
		}
		if(operatorNo != null){
			sf.append(" cardHandOutIn.operatorNo =? and");		   
			obj.add(operatorNo);
			
		}
		if(recorderNo != null){
			sf.append(" cardHandOutIn.recorderNo =? and");		   
			obj.add(recorderNo);
			
		}	
		sf = sf.replace(sf.length() - 4, sf.length(), "");
		//查出总行数，对分页进行设置
		//System.out.println(sf.toString()+"obj"+obj.get(0));
		
		Long count = executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
	
		return this.executeQuery(pager,sf.toString(), obj.toArray());
	}
	@SuppressWarnings("unchecked")
	public Integer getMaxRecordNo() {
		String hql = "from CardHandOutIn cardHandOutIn order by cardHandOutIn.recordNo desc";
		List resultList = executeQuery(hql);
		if (resultList.isEmpty())
			return 1;
		else {
			return ((CardHandOutIn) resultList.get(0)).getRecordNo() + 1;
		}

	}
	

}
