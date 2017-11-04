package com.hgsoft.dao;

import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Repository;
import com.hgsoft.entity.CarClassCode;
import com.hgsoft.util.Pager;

@Repository 
public class CarClassCodeDao extends BaseDao<CarClassCode>{
	//查询
	@SuppressWarnings("unchecked")
	public List<CarClassCode> findByCondition(Pager pager,Integer classNo,String className){
		StringBuffer sf = new StringBuffer("from CarClassCode carClassCode where");
		List<Object> obj = new ArrayList<Object>();
		
		if (classNo!=null) {
			sf.append(" carClassCode.classNo = ? and");
			obj.add(classNo);
		}
		if (!className.equals("")){
			sf.append(" carClassCode.className like ? and");
			obj.add("%"+className+"%");
		}
	
		sf = sf.replace(sf.length() - 4, sf.length(), "");
		// 查出总行数，对分页进行设置
		Long count = this.executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
		return this.executeQuery(pager, sf.toString(), obj.toArray());
	}
}
