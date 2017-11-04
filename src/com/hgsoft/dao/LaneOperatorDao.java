package com.hgsoft.dao;

import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Repository;
import com.hgsoft.entity.LaneOperator;
import com.hgsoft.util.Pager;

@Repository 
public class LaneOperatorDao extends BaseDao<LaneOperator>{

	//查询
	@SuppressWarnings("unchecked")
	public List<LaneOperator> findLaneOperatorByCondition(Pager pager,Short parkNo,String status,Integer operatorNo,
			String operatorName,String opCardId,Integer opCardNo){
		StringBuffer sf = new StringBuffer("from LaneOperator laneOperator where");
		List<Object> obj = new ArrayList<Object>();
		
		if (parkNo!=null) {
			sf.append(" laneOperator.parkNo = ? and");
			obj.add(parkNo);
		}
		if (!status.equals("")){
			sf.append(" laneOperator.status = ? and");
			obj.add(status);
		}
		if (operatorNo!=null) {
			sf.append(" laneOperator.operatorNo = ? and");
			obj.add(operatorNo);
		}
		if (!operatorName.equals("")) {
			sf.append(" laneOperator.operatorName like ? and");
			obj.add("%"+operatorName+"%");
		}
		if (!opCardId.equals("")) {
			sf.append(" laneOperator.opCardId like ? and");
			obj.add("%"+opCardId+"%");
		}
		if (opCardNo!=null) {
			sf.append(" laneOperator.opCardNo = ? and");
			obj.add(opCardNo);
		}
		sf = sf.replace(sf.length() - 4, sf.length(), "");
		// 查出总行数，对分页进行设置
		Long count = this.executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
		return this.executeQuery(pager, sf.toString(), obj.toArray());
	}
	
	//验证是否存在相同的模块编码
	@SuppressWarnings("unchecked")
	public List<LaneOperator> ishasLaneOperator(Object operatorNo){
		String hql="from LaneOperator laneOperator where laneOperator.operatorNo=?";
		List<LaneOperator> list=executeQuery(hql,operatorNo);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	
}
