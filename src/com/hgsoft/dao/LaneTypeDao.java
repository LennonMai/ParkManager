package com.hgsoft.dao;


import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Repository;
import com.hgsoft.entity.LaneType;
import com.hgsoft.util.Pager;

@Repository 
public class LaneTypeDao  extends BaseDao<LaneType>{
	//查询
	@SuppressWarnings("unchecked")
	public List<LaneType> findByCondition(Pager pager,Short laneTypeNo,String laneTypeName){
		StringBuffer sf = new StringBuffer("from LaneType laneType where ");
		List<Object> obj = new ArrayList<Object>();
		
		if (laneTypeNo!=null) {
			sf.append(" laneType.laneTypeNo = ? and");
			obj.add(laneTypeNo);
		}
		if (!laneTypeName.equals("")){
			sf.append(" laneType.laneTypeName like ? and");
			obj.add("%"+laneTypeName+"%");
		}
		
		
		sf = sf.replace(sf.length() - 4, sf.length(), "");
		// 查出总行数，对分页进行设置
		Long count = this.executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
		return this.executeQuery(pager, sf.toString(), obj.toArray());
	}
}
