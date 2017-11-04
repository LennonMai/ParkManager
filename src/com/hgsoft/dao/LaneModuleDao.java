package com.hgsoft.dao;

import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Repository;
import com.hgsoft.entity.LaneModule;
import com.hgsoft.util.Pager;

@Repository 
public class LaneModuleDao extends BaseDao<LaneModule>{
	//查询
	@SuppressWarnings("unchecked")
	public List<LaneModule> findLaneModuleByCondition(Pager pager,String moduleNo,String moduleName){
		StringBuffer sf = new StringBuffer("from LaneModule laneModule where");
		List<Object> obj = new ArrayList<Object>();
		
		if (!moduleNo.equals("")) {
			sf.append(" laneModule.moduleNo like ? and");
			obj.add("%"+moduleNo+"%");
		}
		if (!moduleName.equals("")) {
			sf.append(" laneModule.moduleName like ? and");
			obj.add("%"+moduleName+"%");
		}
		sf = sf.replace(sf.length() - 4, sf.length(), "");
		// 查出总行数，对分页进行设置

		Long count = this.executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
		return this.executeQuery(pager, sf.toString(), obj.toArray());
	}
	
	public List<LaneModule> findLaneModule(){
		String hql = "from LaneModule laneModule";
		List<LaneModule> list=this.executeQuery(hql);
		if(!list.isEmpty())
			return list;
		else return null;
	}
	
	//验证是否存在相同的模块编码
	@SuppressWarnings("unchecked")
	public List<LaneModule> ishasLaneModule(Object moduleNo){
		String hql="from LaneModule laneModule where laneModule.moduleNo=?";
		List<LaneModule> list=executeQuery(hql,moduleNo);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	
}
