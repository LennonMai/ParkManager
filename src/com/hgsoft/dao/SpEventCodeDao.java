package com.hgsoft.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.hgsoft.entity.SpEventCode;
import com.hgsoft.util.Pager;

@Repository 
public class SpEventCodeDao  extends BaseDao<SpEventCode>{
	//查询
	@SuppressWarnings("unchecked")
	public List<SpEventCode> findByCondition(Pager pager,Short spEventNo,String spEventName){
		StringBuffer sf = new StringBuffer("from SpEventCode spEventCode where");
		List<Object> obj = new ArrayList<Object>();
		
		if (spEventNo!=null) {
			sf.append(" spEventCode.spEventNo = ? and");
			obj.add(spEventNo);
		}
		if (!spEventName.equals("")){
			sf.append(" spEventCode.spEventName like ? and");
			obj.add("%"+spEventName+"%");
		}
		
		sf = sf.replace(sf.length() - 4, sf.length(), "");
		// 查出总行数，对分页进行设置
		Long count = this.executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
		return this.executeQuery(pager, sf.toString(), obj.toArray());
	}
}
