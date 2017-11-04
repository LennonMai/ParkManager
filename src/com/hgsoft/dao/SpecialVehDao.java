package com.hgsoft.dao;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.hgsoft.entity.SpecialVeh;
import com.hgsoft.util.JdbcUtil;
import com.hgsoft.util.Pager;

/**
 * 
 * @author qinzuohai
 *
 */
@Repository
public class SpecialVehDao extends BaseDao<SpecialVeh>{

	@Resource private JdbcUtil jdbcUtil;
	@SuppressWarnings("unchecked")
	public List<SpecialVeh> findSpecialVehByCondition(Pager pager,String vehPlate, String cardNo, 
			Integer specialType, Short lanetype) {

		StringBuffer sf = new StringBuffer(
				"from SpecialVeh specialVeh where ");
		List<Object> obj = new ArrayList<Object>();
		
		if (!vehPlate.equals("")) {
			sf.append(" specialVeh.vehPlate like ? and");
			obj.add("%" + vehPlate + "%");
		}
		if (!cardNo.equals("")) {
			sf.append(" specialVeh.cardNo like ? and");
			obj.add("%" + cardNo + "%");
		}
		if (specialType!=null) {
			sf.append(" specialVeh.specialType = ? and");
			obj.add(specialType);
		}
		if (lanetype!=null) {
			sf.append(" specialVeh.lanetype = ? and");
			obj.add(lanetype);
		}
		
		sf = sf.replace(sf.length() - 4, sf.length(), "");
		// 查出总行数，对分页进行设置
		
		Long count = this.executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
		return this.executeQuery(pager, sf.toString(), obj.toArray());
	}
	
	@SuppressWarnings("unchecked")
	public List<SpecialVeh> LoadSpecialVeh(String vehPlate, String cardNo){
	
		String hql=" from SpecialVeh specialVeh where specialVeh.vehPlate=? and specialVeh.cardNo=? " ;
		List<SpecialVeh> specialVeh=executeQuery(hql,vehPlate,cardNo);
		if(!specialVeh.isEmpty()){
			return specialVeh;
		}else
			return null;
	}
	
	@SuppressWarnings("unchecked")
	public boolean findSpecialVehByVehPlateCardNo(String vehPlate){
		String hql=" from SpecialVeh specialVeh where specialVeh.vehPlate=?" ;
		List<SpecialVeh> specialVeh=executeQuery(hql,vehPlate);
		if(!specialVeh.isEmpty()){
			return true;
		}else
			return false;
	}
	
	//根据联合主键删除数据
	public boolean deleteBycompositeID(String vehPlate, String cardNo){
		List<SpecialVeh> li=this.LoadSpecialVeh(vehPlate, cardNo);
		if(li!=null){
			SpecialVeh specialVeh=li.get(0);
			getSession().clear();
			getSession().refresh(specialVeh);
			getSession().merge(specialVeh);
			delete(specialVeh);
		}
		
		
		if (this.LoadSpecialVeh(vehPlate, cardNo)==null)
			return true;
		else
			return false;
	}
	//车道监控  曾
	@SuppressWarnings("unchecked")
	public List queryMonitoring(Pager pager,String station, String road, String status, String systemType,String device){
		String sql = "select gw.GateName,ss.RoadNum,dc.DeviceName,ss.SystemTypeNo,ss.Status,ss.OccurTime,ss.Info from tb_SystemStatus ss,tb_Gateway gw,tb_DeviceCode dc " +
				"where ss.StationId=gw.GateNo and ss.DeviceNo=dc.DeviceNo";
		StringBuffer sb = new StringBuffer(0);
		if(null != station && !station.equals("")){
			sb.append(" and ss.StationId="+Integer.parseInt(station));
		}
		if(null != road && !road.equals("")){
			sb.append(" and ss.RoadNum="+Integer.parseInt(road));
		}
		if(null != status && !status.equals("")){
			if(status.equals("0")){
				sb.append(" and ss.Status not in (select DeviceErrorNo from tb_DeviceErrorCode)");
			}else{
				sb.append(" and ss.Status="+Integer.parseInt(status));
			}
		}
		if(null != systemType && !systemType.equals("")){
			sb.append(" and ss.SystemTypeNo="+Integer.parseInt(systemType));
		}
		if(null != device && !device.equals("")){
			sb.append(" and ss.DeviceNo="+Integer.parseInt(device));
		}
		//System.out.println(sql + sb.toString() + " order by OccurTime desc");
		int count = jdbcUtil.select(sql + sb.toString() + " order by OccurTime desc");
		pager.setTotalSize(count);
		Query query = getSession().createSQLQuery(sql + sb.toString() + " order by OccurTime desc").addScalar("GateName", Hibernate.STRING).addScalar("RoadNum", Hibernate.INTEGER).addScalar("DeviceName", Hibernate.STRING).addScalar("SystemTypeNo", Hibernate.INTEGER)
		.addScalar("Status", Hibernate.INTEGER).addScalar("OccurTime", Hibernate.STRING).addScalar("Info", Hibernate.STRING);
		if (pager != null) {
			query.setFirstResult((pager.getCurrentPage() - 1) * pager.getPageSize());
			query.setMaxResults(pager.getPageSize());
		}
		return query.list();
	}
	//获得所有设备信息 曾
	@SuppressWarnings("unchecked")
	public List allDevice(){
		String sql = "Select DeviceNo,DeviceName from tb_DeviceCode";
		List list = jdbcUtil.selectForList(sql);
		return list;
	}
	
	//获得所有设备错误信息 曾
	@SuppressWarnings("unchecked")
	public List allDeviceError(){
		String sql = "Select DeviceErrorNo,DeviceErrorName from tb_DeviceErrorCode";
		List list = jdbcUtil.selectForList(sql);
		return list;
	}
	
	
	
}
