package com.hgsoft.dao;


import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;
import com.hgsoft.entity.LaneRole;
import com.hgsoft.util.Pager;


@Repository 
public class LaneRoleDao extends BaseDao<LaneRole>{
	
	//��ѯ
	@SuppressWarnings("unchecked")
	public List<LaneRole> findLaneRoleByCondition(Pager pager,Short roleNo,String roleName){
		StringBuffer sf = new StringBuffer("from LaneRole laneRole where");
		List<Object> obj = new ArrayList<Object>();
		
		if (roleNo != null) {
			sf.append(" laneRole.roleNo = ? and");
			obj.add(roleNo);
		}
		if (!roleName.equals("")) {
			sf.append(" laneRole.roleName like ? and");
			obj.add("%"+roleName+"%");
		}
		sf = sf.replace(sf.length() - 4, sf.length(), "");
		// ������������Է�ҳ��������

		Long count = this.executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
		return this.executeQuery(pager, sf.toString(), obj.toArray());
	}
	
	//��֤�Ƿ������ͬ�Ľ�ɫ����
	@SuppressWarnings("unchecked")
	public List<LaneRole> ishasLaneRole(Object roleNo){
		String hql="from LaneRole laneRole where laneRole.roleNo=?";
		List<LaneRole> list=executeQuery(hql,roleNo);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	public List<LaneRole> findLaneRole(){
		String hql = "from LaneRole laneRole";
		List<LaneRole> list=this.executeQuery(hql);
		if(!list.isEmpty())
			return list;
		else return null;
	}
	
}
