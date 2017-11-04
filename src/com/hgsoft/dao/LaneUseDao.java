package com.hgsoft.dao;

import java.util.ArrayList;
import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Repository;
import com.hgsoft.entity.LaneUse;
import com.hgsoft.util.JdbcUtil;

@Repository 
public class LaneUseDao extends BaseDao<LaneUse>{
	@Resource
	private JdbcUtil jdbcUtil;
	
	@SuppressWarnings("unchecked")
	public List<LaneUse> ishasLaneUse(Short areaNo, Short parkNo, Short gatewayNo,Short laneNo){
		String hql="from LaneUse laneUse where laneUse.areaNo=? and laneUse.parkNo=? and laneUse.gateNo=? and laneUse.laneNo=?";
		List<LaneUse> list=executeQuery(hql,areaNo,parkNo,gatewayNo,laneNo);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	

	@SuppressWarnings("unchecked")
	public List<LaneUse> LoadLaneUse(Short areaNo, Short parkNo, Short gatewayNo,Short laneNo){
		String hql="from LaneUse laneUse where laneUse.areaNo=? and laneUse.parkNo=? and laneUse.gateNo=? and laneUse.laneNo=?";
		List<LaneUse> list=executeQuery(hql,areaNo,parkNo,gatewayNo,laneNo);
		if(!list.isEmpty()){	
			return list;
		}else
			return null;
	}
	
	//É¾³ý
	public boolean deleteBylaneUse(Short areaNo, Short parkNo, Short gatewayNo,Short laneNo){
		LaneUse laneUse=this.LoadLaneUse(areaNo,parkNo,gatewayNo,laneNo).get(0);
		getSession().clear();
		getSession().refresh(laneUse);
		getSession().merge(laneUse);
		getSession().delete(laneUse);
		
		if (this.LoadLaneUse(areaNo,parkNo,gatewayNo,laneNo) == null)
			return true;
		else
			return false;
	}
	
	@SuppressWarnings("unchecked")
	public List<LaneUse> ishasLaneUseIP(String laneComputerIp){
		String hql="from LaneUse laneUse where laneUse.laneComputerIp=?";
		List<LaneUse> list=new ArrayList<LaneUse>();
		if(laneComputerIp.equals("")||laneComputerIp==null){
			list=executeQuery(hql,laneComputerIp);
		}
		else{
			list=executeQuery(hql,laneComputerIp.trim());
		}
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	
	public List<LaneUse> ishasLaneUseNo(Short laneNo){
		String hql="from LaneUse laneUse where laneUse.laneNo=?";
		 @SuppressWarnings("unchecked")
		List<LaneUse> list=executeQuery(hql,laneNo);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	
	public boolean deleteByGateNo(Short gatewayNo){
		String sql="delete tb_LaneUse where GateNo='"+gatewayNo+"'";
		jdbcUtil.delete(sql);
		return true;
	}
	public void deleteAllLaneUse(){
		String sql="delete tb_LaneUse";
		jdbcUtil.delete(sql);
	}
	public void deleteLaneUseByAPGL(Short areaNo, Short parkNo, Short gateNo,Short laneNo){
		String sql="delete tb_LaneUse where AreaNo="+areaNo+" and ParkNo="+parkNo+" and GateNo="+gateNo+" and LaneNo="+laneNo;
		jdbcUtil.delete(sql);
	}
	public void insertLaneUseByLane(){
		String sql="insert into tb_LaneUse(AreaNo,ParkNo,GateNo,LaneNo,LaneComputerIP) select AreaNo,ParkNo,GateNo,LaneNo,LaneComputerIP from tb_Lane";
		jdbcUtil.update(sql);
	}
	
	public List<LaneUse> findLaneUse(){
		String hql="from LaneUse laneUse" ;
		@SuppressWarnings("unchecked")
		List<LaneUse> list=this.executeQuery(hql); 
		if(!list.isEmpty()){
			return list;
		}
		else return null;
	}

	public Short findLaneUseNoByIP(String IP){
		String hql="from LaneUse laneUse where laneUse.laneComputerIp=?" ;
		@SuppressWarnings("unchecked")
		List<LaneUse> list=this.executeQuery(hql,IP); 
		if(!list.isEmpty()){
			return list.get(0).getLaneNo();
		}
		else return null;
	}
	
	public List<LaneUse> findLaneUseByIsUse(){
		String hql="from LaneUse laneUse" ;
		@SuppressWarnings("unchecked")
		List<LaneUse> list=this.executeQuery(hql); 
		if(!list.isEmpty()){
			return list;
		}
		else return null;
	}
}
