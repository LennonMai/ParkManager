package com.hgsoft.dao;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.hgsoft.entity.LaneInformation;
import com.hgsoft.util.JdbcUtil;

@Repository 
public class LaneInformationDao extends BaseDao<LaneInformation>{
	@Resource
	private JdbcUtil jdbcUtil;
	
	//验证保存车道信息时，是否存在相同的车道编码
	@SuppressWarnings("unchecked")
	public List<LaneInformation> ishasLaneInfo(Object areaNo, Object parkNo, Object gatewayNo,Object laneNo){
		String hql="from LaneInformation laneInfo where laneInfo.areaNo=? and laneInfo.parkNo=? and laneInfo.gateNo=? and laneInfo.laneNo=?";
		 List<LaneInformation> list=executeQuery(hql,areaNo,parkNo,gatewayNo,laneNo);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	@SuppressWarnings("unchecked")
	public List<LaneInformation> ishasLaneNo(Object laneNo){
		String hql="from LaneInformation laneInfo where laneInfo.laneNo=?";
		List<LaneInformation> list=executeQuery(hql,laneNo);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	
	//根据laneNo加载LaneInformation
	@SuppressWarnings("unchecked")
	public List<LaneInformation> LoadLaneInfo(Object areaNo, Object parkNo, Object gatewayNo,Object laneNo){
		String hql="from LaneInformation laneInfo where laneInfo.areaNo=? and laneInfo.parkNo=? and laneInfo.gateNo=? and laneInfo.laneNo=?";
		List<LaneInformation> list=executeQuery(hql,areaNo,parkNo,gatewayNo,laneNo);
		if(!list.isEmpty()){	
			return list;
		}else
			return null;
	}
	@SuppressWarnings("unchecked")
	public LaneInformation getLaneInfoByAPGL(Object areaNo, Object parkNo, Object gatewayNo,Object laneNo){
		String hql="from LaneInformation laneInfo where laneInfo.areaNo=? and laneInfo.parkNo=? and laneInfo.gateNo=? and laneInfo.laneNo=?";
		List<LaneInformation> list=executeQuery(hql,areaNo,parkNo,gatewayNo,laneNo);
		if(!list.isEmpty()){	
			return list.get(0);
		}else
			return null;
	}
	
	//删除
	public boolean deleteBylaneInfo(Object areaNo, Object parkNo, Object gatewayNo,Object laneNo){
		List<LaneInformation> li=this.LoadLaneInfo(areaNo,parkNo,gatewayNo,laneNo);
		if(li!=null){
			LaneInformation laneInformation=li.get(0);
			getSession().clear();
			getSession().refresh(laneInformation);
			getSession().merge(laneInformation);
			getSession().delete(laneInformation);
		}
		if (this.LoadLaneInfo(areaNo,parkNo,gatewayNo,laneNo) == null)
			return true;
		else
			return false;
	}
	
	//根据大门删除该大门下的全部车道
	public boolean deleteByGateNo(Object gatewayNo){
		String sql="delete tb_Lane where GateNo='"+gatewayNo+"'";
		jdbcUtil.delete(sql);
		return true;
	}
	
	//查询车道信息
	public List<LaneInformation> findLaneInformation(){
		String hql="from LaneInformation lane" ;
		@SuppressWarnings("unchecked")
		List<LaneInformation> list=this.executeQuery(hql); 
		if(!list.isEmpty()){
			return list;
		}
		else return null;
	}
	//根据IP查询车道
	public Short findLaneNoByIP(String IP){
		String hql="from LaneInformation lane where lane.laneComputerIp=?" ;
		@SuppressWarnings("unchecked")
		List<LaneInformation> list=this.executeQuery(hql,IP); 
		if(!list.isEmpty()){
			return list.get(0).getLaneNo();
		}
		else return null;
	}
	
	//chenfuyuan
	@SuppressWarnings("unchecked")
	public List<LaneInformation> getLaneInformationByParkNoAndGateNo(Short parkNo ,Short gateNo){
		String hql="from LaneInformation laneInformation where laneInformation.parkNo="+parkNo+"and laneInformation.gateNo="+gateNo;
		List resultList = executeQuery(hql);
		if (resultList.isEmpty()) {
			return null;
		} else {

			return resultList;
		}
	}
	@SuppressWarnings("unchecked")
	public List<LaneInformation> getLaneInformationByParkNo(Short parkNo){
		String hql="from LaneInformation laneInformation where laneInformation.laneTypeNo!=1 and laneInformation.parkNo="+parkNo;
		List resultList = executeQuery(hql);
		if (resultList.isEmpty()) {
			return null;
		} else {
			
			return resultList;
		}
	}
	//chenfuyuan
	@SuppressWarnings("unchecked")
	public List<LaneInformation> getAllLaneInformationByGateNo(Short gateNo){
		String hql="from LaneInformation laneInformation where laneInformation.gateNo="+gateNo;
		List resultList = executeQuery(hql);
		if (resultList.isEmpty()) {
			return null;
		} else {

			return resultList;
		}
	}
	//caijunhua通过大门取 出口 车道
	@SuppressWarnings("unchecked")
	public List<LaneInformation> getLaneInformationByGateNo(Short gateNo){
		String hql="from LaneInformation laneInformation where laneTypeNo=2 and laneInformation.gateNo="+gateNo;
		List resultList = executeQuery(hql);
		if (resultList.isEmpty()) {
			return null;
		} else {
			return resultList;
		}
	}
	
	@SuppressWarnings("unchecked")
	public List<LaneInformation> ishasLaneIP(String laneComputerIp){
		String hql="from LaneInformation laneInfo where laneInfo.laneComputerIp=?";
		List<LaneInformation> list=new ArrayList<LaneInformation>();
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
	//caijunhua添加车道启用/不启用合计方法
	public void allUse() {
		jdbcUtil.update("update tb_lane set isUse=1");
	}
	public void allNotUse() {
		jdbcUtil.update("update tb_lane set isUse=0");
	}

	
	
}
