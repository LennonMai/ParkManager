package com.hgsoft.dao;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.hgsoft.entity.BasisOfSecurityVehPass;
import com.hgsoft.entity.GatewayInformation;
import com.hgsoft.entity.ParkInformation;
import com.hgsoft.entity.SecurityCommandBackup;
import com.hgsoft.entity.SecurityQueryHis;
import com.hgsoft.entity.SecurityVehPass;
import com.hgsoft.util.Pager;




@Repository
public class SecurityVehPassDao extends BaseDao<SecurityVehPass> {

	/**
	 * 查看车道过车记录
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List query(Pager pager,String startTime,String endTime,String cardNo,String onwer,String parkNo,String gateNo, String laneNo,String vehPass){
		String hql = "from SecurityVehPass veh,UserCardInfo info"
			+ " where veh.cardNo=info.cardNo";
		StringBuffer sb = new StringBuffer(0);
		List list = new ArrayList();
		List resultList = new ArrayList();//用于返回结果
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if(null != startTime && !startTime.equals("")){
			sb.append(" and veh.passTime >= ?");
			try {
				list.add(format.parse(startTime));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		if(null != endTime && !endTime.equals("")){
			sb.append(" and veh.passTime <= ?");
			try {
				list.add(format.parse(endTime));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		if(null != cardNo && !cardNo.equals("")){
			sb.append(" and veh.cardNo = ?");
			list.add(cardNo);
		}
		if(null != onwer && !onwer.equals("")){
			sb.append(" and info.owner = ?");
			list.add(onwer);
		}
		if(null != parkNo && !parkNo.equals("")){
			sb.append(" and veh.parkNo = ?");
			list.add(Short.parseShort(parkNo));
		}
		if(null != gateNo && !gateNo.equals("")){
			sb.append(" and veh.gateNo =?");
			list.add(Short.parseShort(gateNo));
		}
		if(null != laneNo && !laneNo.equals("")){
			sb.append(" and veh.laneNo =?");
			list.add(Short.parseShort(laneNo));
		}
		if(null != vehPass && !vehPass.equals("")){
			sb.append(" and veh.vehPass = ?");
			list.add(Short.parseShort(vehPass));
		}
		//System.out.println(hql+sb.toString());
		Long count = this.executeCount(hql+sb.toString(), list.toArray());
		pager.setTotalSize(count);
		List list1 = this.executeQuery(pager,hql+sb.toString()+" order by veh.passTime desc", list.toArray());
		Iterator it = list1.iterator();
		while(it.hasNext()){
			Object[] obj = (Object[]) it.next();
			SecurityVehPass vehPass1 = (SecurityVehPass) obj[0];
			resultList.add(vehPass1);
		}
		return resultList;
	}
	/**
	 * 查看过车依据
	 */
	@SuppressWarnings("unchecked")
	public List query(Pager pager,String vehPassId){
		String hql = "from BasisOfSecurityVehPass basiPass,SecurityCommandBackup command where basiPass.commandId = command.commandId " +
				"and basiPass.vehPassId = ?";
		List resultList = new ArrayList();
		Long count = this.executeCount(hql, vehPassId.trim());
		pager.setTotalSize(count);
		List list = this.executeQuery(pager,hql,vehPassId.trim());
		Iterator it = list.iterator();
		while (it.hasNext()){
			Object[] obj = (Object[]) it.next();
			BasisOfSecurityVehPass vehPass = (BasisOfSecurityVehPass) obj[0];
			SecurityCommandBackup commandBackup = (SecurityCommandBackup)obj[1];
			if(!commandBackup.getStartTime().trim().equals("")){
				if(commandBackup.getStartTime().trim().length()==4){
					String yuan = commandBackup.getStartTime().trim();
					StringBuffer sb1 = new StringBuffer(0);
					sb1.append(yuan.substring(0, 2));
					sb1.append(":"+yuan.substring(2));
					commandBackup.setStartTime(sb1.toString());
				}
				if(commandBackup.getStartTime().trim().length()==12){
					String yuan = commandBackup.getStartTime().trim();
					StringBuffer sb1 = new StringBuffer(0);
					sb1.append(yuan.substring(0, 4));
					sb1.append("-"+yuan.substring(4,6));
					sb1.append("-"+yuan.substring(6,8));
					sb1.append(" "+yuan.substring(8, 10));
					sb1.append(":"+yuan.substring(10));
					commandBackup.setStartTime(sb1.toString());
				}
			}
			if(!commandBackup.getEndTime().trim().equals("")){
				if(commandBackup.getEndTime().trim().length()==4){
					String yuan = commandBackup.getEndTime().trim();
					StringBuffer sb1 = new StringBuffer(0);
					sb1.append(yuan.substring(0, 2));
					sb1.append(":"+yuan.substring(2));
					commandBackup.setEndTime(sb1.toString());
				}
				if(commandBackup.getEndTime().trim().length()==12){
					String yuan = commandBackup.getEndTime().trim();
					StringBuffer sb1 = new StringBuffer(0);
					sb1.append(yuan.substring(0, 4));
					sb1.append("-"+yuan.substring(4,6));
					sb1.append("-"+yuan.substring(6,8));
					sb1.append(" "+yuan.substring(8, 10));
					sb1.append(":"+yuan.substring(10));
					commandBackup.setEndTime(sb1.toString());
				}
			}
			Object[] ay = new Object[]{vehPass,commandBackup};
			resultList.add(ay);
		}
		return resultList;
	}
	/**
	 * 查询历史记录
	 */
	@SuppressWarnings("unchecked")
	public List queryHistory(Pager pager,String startTime,String endTime,String parkNo,String gateNo,String laneNo,String numberType,String number,String operatorType){
		String hql = "from SecurityQueryHis his,ParkInformation park,GatewayInformation gateway"
			+ " where his.parkNo = park.parkNo and park.parkNo = gateway.parkNo and"
			+ " his.gateNo = gateway.gateNo";
		StringBuffer sb = new StringBuffer(0);
		List resultList = new ArrayList();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		List list = new ArrayList();
		if(null != startTime && !startTime.equals("")){
			sb.append(" and his.opTime>= ?");
			try {
				list.add(format.parse(startTime));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		if(null != endTime && !endTime.equals("")){
			sb.append(" and his.opTime <= ?");
			try {
				list.add(format.parse(endTime));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		if(null != parkNo && !parkNo.equals("")){
			sb.append(" and his.parkNo = ?");
			list.add(Short.parseShort(parkNo));
		}
		if(null != gateNo && !gateNo.equals("")){
			sb.append(" and his.gateNo = ?");
			list.add(Short.parseShort(gateNo));
		}
		if(null != laneNo && !laneNo.equals("")){
			sb.append(" and his.laneNo = ?");
			list.add(Short.parseShort(laneNo));
		}
		if(null != numberType && !numberType.equals("")){
			sb.append(" and his.numberType = ?");
			list.add(Short.parseShort(numberType));
		}
		if(null != number && !number.equals("")){
			sb.append(" and his.number = ?");
			list.add(number);
		}
		if(null != operatorType && !operatorType.equals("")){
			sb.append(" and his.operatorType = ?");
			list.add(Short.parseShort(operatorType));
		}
		Long count = this.executeCount(hql + sb.toString(), list.toArray());
		pager.setTotalSize(count);
		List temp = this.executeQuery(pager,hql + sb.toString()+ " order by his.opTime desc", list.toArray());
		Iterator it = temp.iterator();
		while(it.hasNext()){
			Object[] obj =(Object[])it.next();
			SecurityQueryHis his = (SecurityQueryHis) obj[0];
			ParkInformation park = (ParkInformation) obj[1];
			GatewayInformation gateway = (GatewayInformation) obj[2];
			Object[] ay = new Object[]{his,park,gateway};
			resultList.add(ay);
		}
		return resultList;
	}
	
	/**
	 * 获取所有小区信息
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List queryParkList(){
		String hql = "from ParkInformation park";
		List resultList = this.executeQuery(hql, null);
		return resultList;
	}
	
	/**
	 * 根据小区号来获得该小区的所有大门
	 */
	@SuppressWarnings("unchecked")
	public List queryGateList(String parkNo){
		String hql = "from GatewayInformation gateway where gateway.parkNo = ?";
		List resultList = this.executeQuery(hql, Short.parseShort(parkNo));
		return resultList;
	}
	/**
	 * 根据小区号和大门号来获得所有的车道信息
	 * @param parkNo
	 * @param gateNo
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List queryLaneList(String parkNo,String gateNo){
		String hql = "from LaneInformation lane where lane.parkNo = ? and lane.gateNo = ?";
		List resultList = this.executeQuery(hql, Short.parseShort(parkNo),Short.parseShort(gateNo));
		return resultList;
	}
}
