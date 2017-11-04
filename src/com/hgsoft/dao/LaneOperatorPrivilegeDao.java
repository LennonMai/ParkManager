package com.hgsoft.dao;

import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Repository;
import com.hgsoft.entity.LaneOperatorPrivilege;
import com.hgsoft.util.Pager;

@Repository 
public class LaneOperatorPrivilegeDao extends BaseDao<LaneOperatorPrivilege>{

	//查询
	@SuppressWarnings("unchecked")
	public List<LaneOperatorPrivilege> findLaneOperatorPrivilegeByCondition(Pager pager,Integer operatorNo,String moduleNo){
		StringBuffer sf = new StringBuffer("from LaneOperatorPrivilege laneOperatorPrivilege where");
		List<Object> obj = new ArrayList<Object>();
		
		if (operatorNo != null) {
			sf.append(" laneOperatorPrivilege.operatorNo = ? and");
			obj.add(operatorNo);
		}
		if (!moduleNo.equals("")) {
			sf.append(" laneOperatorPrivilege.moduleNo like ? and");
			obj.add("%"+moduleNo+"%");
		}
		sf = sf.replace(sf.length() - 4, sf.length(), "");
		// 查出总行数，对分页进行设置

		Long count = this.executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
		return this.executeQuery(pager, sf.toString(), obj.toArray());
	}
	
}
