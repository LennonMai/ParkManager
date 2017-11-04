package com.hgsoft.dao;

import java.util.ArrayList;
import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Repository;
import com.hgsoft.entity.LaneOperatorRole;
import com.hgsoft.util.JdbcUtil;
import com.hgsoft.util.Pager;

@Repository 
public class LaneOperatorRoleDao extends BaseDao<LaneOperatorRole>{
	@Resource
	private JdbcUtil jdbcUtil;
	
	//查询
	@SuppressWarnings("unchecked")
	public List<LaneOperatorRole> findLaneOperatorRoleByCondition(Pager pager,Integer operatorNo,Short roleNo){
		StringBuffer sf = new StringBuffer("from LaneOperatorRole laneOperatorRole where");
		List<Object> obj = new ArrayList<Object>();
		
		if (operatorNo != null) {
			sf.append(" laneOperatorRole.operatorNo = ? and");
			obj.add(operatorNo);
		}
		if (roleNo != null) {
			sf.append(" laneOperatorRole.roleNo = ? and");
			obj.add(roleNo);
		}
		sf = sf.replace(sf.length() - 4, sf.length(), "");
		// 查出总行数，对分页进行设置

		Long count = this.executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
		return this.executeQuery(pager, sf.toString(), obj.toArray());
	}
	
	//验证是否存在相同的操作员角色信息
	@SuppressWarnings("unchecked")
	public List<LaneOperatorRole> ishasLaneOperatorRole(Integer operatorNo,Short roleNo){
		String hql="from LaneOperatorRole laneOperatorRole where laneOperatorRole.operatorNo=? and laneOperatorRole.roleNo=?";
		List<LaneOperatorRole> list=executeQuery(hql,operatorNo,roleNo);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	//更新
	public boolean _update(LaneOperatorRole laneOperatorRole,Integer operatorNo,Short roleNo){
		String sql=" update tb_OperatorRole set OperatorNo='"+laneOperatorRole.getOperatorNo()+"',roleNo='"+laneOperatorRole.getRoleNo()+"' where OperatorNo='"+laneOperatorRole.getOperatorNo()+"' and roleNo='"+laneOperatorRole.getRoleNo()+"'";
		//System.out.println(sql);
		jdbcUtil.update(sql);
		return true;
	}
	//删除
	public boolean _delete(Integer operatorNo){
		String sql="delete from tb_OperatorRole where OperatorNo="+operatorNo+"";
		jdbcUtil.delete(sql);
		return true;
	}
	
	//根据角色编码删除
	public boolean _deleteByroleNo(Short roleNo){
		String sql="delete from tb_OperatorRole where RoleNo="+roleNo+"";
		jdbcUtil.delete(sql);
		return true;
	}
	
	@SuppressWarnings("unchecked")
	public String[] fineLaneOperatorRole(Integer operatorNo){
		String hql="from LaneOperatorRole laneOperatorRole where laneOperatorRole.operatorNo=? ";
		List<LaneOperatorRole> list=executeQuery(hql,operatorNo);
		if(!list.isEmpty()){
			String[] role=new String[list.size()];
			for(int i=0;i<list.size();i++){
				role[i]=list.get(i).getRoleNo().toString();
			}
			return role;
		}else
			return null;
	}
	
}
