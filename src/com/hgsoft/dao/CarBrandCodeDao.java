package com.hgsoft.dao;

import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Repository;
import com.hgsoft.entity.CarBrandCode;
import com.hgsoft.util.Pager;

@Repository 
public class CarBrandCodeDao  extends BaseDao<CarBrandCode>{
	//查询
	@SuppressWarnings("unchecked")
	public List<CarBrandCode> findByCondition(Pager pager,Integer brandNo,String brandName){
		StringBuffer sf = new StringBuffer("from CarBrandCode carBrandCode where ");
		List<Object> obj = new ArrayList<Object>();
		
		if (brandNo!=null) {
			sf.append(" carBrandCode.brandNo = ? and");
			obj.add(brandNo);
		}
		if (!brandName.equals("")){
			sf.append(" carBrandCode.brandName like ? and");
			obj.add("%"+brandName+"%");
		}
	
		sf = sf.replace(sf.length() - 4, sf.length(), "");
		// 查出总行数，对分页进行设置
		Long count = this.executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
		return this.executeQuery(pager, sf.toString(), obj.toArray());
	}
}
