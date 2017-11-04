package com.hgsoft.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;
import com.hgsoft.entity.FunctionKey;
import com.hgsoft.util.Pager;

@Repository 
public class FunctionKeyDao  extends BaseDao<FunctionKey>{
	//查询
	@SuppressWarnings("unchecked")
	public List<FunctionKey> findByCondition(Pager pager,Short functionNo,String functionName,Short keyCode){
		StringBuffer sf = new StringBuffer("from FunctionKey functionKey where");
		List<Object> obj = new ArrayList<Object>();
		
		if (functionNo!=null) {
			sf.append(" functionKey.functionNo = ? and");
			obj.add(functionNo);
		}
		if (!functionName.equals("")){
			sf.append(" functionKey.functionName like ? and");
			obj.add("%"+functionName+"%");
		}
		if (keyCode!=null) {
			sf.append(" functionKey.keyCode = ? and");
			obj.add(keyCode);
		}
		sf = sf.replace(sf.length() - 4, sf.length(), "");
		// 查出总行数，对分页进行设置
		Long count = this.executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
		return this.executeQuery(pager, sf.toString(), obj.toArray());
	}
}
