package com.hgsoft.dao;

import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Repository;
import com.hgsoft.entity.CarTypeTrans;
import com.hgsoft.util.Pager;

@Repository 
public class CarTypeTransDao extends BaseDao<CarTypeTrans>{
	//查询
	@SuppressWarnings("unchecked")
	public List<CarTypeTrans> findByCondition(Pager pager,String startDate,String class_,Integer weight,String vehType){
		StringBuffer sf = new StringBuffer("from CarTypeTrans carTypeTrans where ");
		List<Object> obj = new ArrayList<Object>();
		if (!startDate.equals("")){
			sf.append(" carTypeTrans.startDate like ? and");
			obj.add("%"+startDate+"%");
		}
		if (!class_.equals("")){
			sf.append(" carTypeTrans.class_ like ? and");
			obj.add("%"+class_+"%");
		}
		if (weight!=null) {
			sf.append(" carTypeTrans.weight = ? and");
			obj.add(weight);
		}
		if (!vehType.equals("")){
			sf.append(" carTypeTrans.vehType like ? and");
			obj.add("%"+vehType+"%");
		}
	
		sf = sf.replace(sf.length() - 4, sf.length(), "");
		// 查出总行数，对分页进行设置
		Long count = this.executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
		return this.executeQuery(pager, sf.toString(), obj.toArray());
	}
}
