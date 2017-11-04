package com.hgsoft.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.hgsoft.entity.BillStorage;
import com.hgsoft.util.Pager;

@Repository
public class BillStorageDao extends BaseDao<BillStorage>{

	@SuppressWarnings("unchecked")
	public List<BillStorage> findAllItemByHql(Pager pager,Integer hankNo,Short position,Short billType,String billHead){
		
		StringBuffer sf = new StringBuffer("from BillStorage billStorage where");
		List<Object> obj = new ArrayList<Object>();
		if(hankNo != null){
			sf.append(" billStorage.hankNo =? and");	   
			obj.add(hankNo);
			
		}
		if(position != null){
			sf.append(" billStorage.position =? and");		   
			obj.add(position);
			
		}
		if(billType != null){
			sf.append(" billStorage.billType =? and");		   
			obj.add(billType);
			
		}
		if(!"".equals(billHead)){			
			sf.append(" billStorage.billHead like? and");
		    obj.add("%"+billHead+"%");
		}				
		
		sf = sf.replace(sf.length() - 4, sf.length(), "");
		//查出总行数，对分页进行设置
		//System.out.println(sf.toString()+"obj"+obj.get(0));
		
		Long count = executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
	
		return this.executeQuery(pager,sf.toString() + " order by billStorage.opTime desc", obj.toArray());
	}
	@SuppressWarnings("unchecked")
	public List<BillStorage> getBillStorageByPosition(short position) {
		String hql = "from BillStorage billStorage where billStorage.position="+position;
		List resultList = executeQuery(hql);
		if(resultList.isEmpty()) {
			return null;
		} else {
			return resultList;
		}
	}
	

}
