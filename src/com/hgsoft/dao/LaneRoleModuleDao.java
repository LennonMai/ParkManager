package com.hgsoft.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;
import com.hgsoft.entity.LaneRoleModule;
import com.hgsoft.util.JdbcUtil;
import com.hgsoft.util.Pager;

@Repository 
public class LaneRoleModuleDao extends BaseDao<LaneRoleModule>{
	
	@Resource
	private JdbcUtil jdbcUtil;
	
	//查询
	@SuppressWarnings("unchecked")
	public List<LaneRoleModule> findLaneRoleModuleByCondition(Pager pager,Short roleNo,String moduleNo){
		StringBuffer sf = new StringBuffer("from LaneRoleModule laneRoleModule where");
		List<Object> obj = new ArrayList<Object>();
		
		if (roleNo != null) {
			sf.append(" laneRoleModule.roleNo = ? and");
			obj.add(roleNo);
		}
		if (!moduleNo.equals("")) {
			sf.append(" laneRoleModule.moduleNo like ? and");
			obj.add("%"+moduleNo+"%");
		}
		sf = sf.replace(sf.length() - 4, sf.length(), "");
		// 查出总行数，对分页进行设置

		Long count = this.executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
		return this.executeQuery(pager, sf.toString(), obj.toArray());
	}
	//验证是否存在相同的角色 模块 
	@SuppressWarnings("unchecked")
	public List<LaneRoleModule> ishasRoleModule(Short roleNo, String moduleNo){
		String hql="from LaneRoleModule laneRoleModule where laneRoleModule.roleNo=? and laneRoleModule.moduleNo=?";
		List<LaneRoleModule> list=executeQuery(hql,roleNo,moduleNo);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	
	public List initOtherRoleModule(Short roleNo){
		String Mhql="select laneModule.moduleNo from LaneModule laneModule" ;
		String RMhql="select laneRoleModule.moduleNo from LaneRoleModule laneRoleModule where laneRoleModule.roleNo=? and laneRoleModule.privilege!=0";
		List Mlist=executeQuery(Mhql);
		List RMlist=executeQuery(RMhql,roleNo);
		
		//System.out.println("RMlist"+RMlist.size());
		HashMap<String, Short> initMap=new HashMap<String, Short>();
		short privilege=0;

		if(RMlist!=null){
			for(int i=0;i<RMlist.size();i++){
				for(int j=0;j<Mlist.size();j++){
					if(Mlist.get(j).toString().trim().equals(RMlist.get(i).toString().trim())){
						Mlist.remove(j);
					}
				}
			}
		}
		//System.out.println("Mlist"+Mlist.size());
		return Mlist;
		
	}
	
	@SuppressWarnings("unchecked")
	public List<LaneRoleModule> findRoleModule(Short roleNo){
		String hql="from LaneRoleModule laneRoleModule where laneRoleModule.roleNo=?";
		List<LaneRoleModule> list=executeQuery(hql,roleNo);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	
	//删除
	public boolean _delete(Short roleNo){
		String sql="delete from tb_RoleModule where RoleNo="+roleNo+"";
		jdbcUtil.delete(sql);
		return true;
	}
	
}
