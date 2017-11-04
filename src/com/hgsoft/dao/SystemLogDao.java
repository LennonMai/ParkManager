package com.hgsoft.dao;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.hgsoft.entity.Admin;
import com.hgsoft.entity.SystemLog;
import com.hgsoft.service.AdminService;
import com.hgsoft.util.JdbcUtil;
import com.hgsoft.util.Pager;

/**
 * 系统日志DAO
 * @author caijunhua
 *
 */

@Repository 
public class SystemLogDao extends BaseDao<SystemLog> {
	@Resource
	private JdbcUtil jdbcUtil;
	@Resource
	private AdminService adminService;
	
	/**
	 * 根据查询条件查询系统日志
	 * @param pager
	 * @param logType 日志类型
	 * @param username 用户名（操作员名）
	 * @param logData 日志内容
	 * @param remark 备注
	 * @param coverage 影响范围
	 * @param startTime1 开始时间
	 * @param endTime1 结束时间
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<SystemLog> findAllSystemLogByHql(Pager pager,Integer logType, String username, 
			String logData, String remark, String coverage,Date startTime1,Date endTime1) {
		Admin admin = null;
		
		
		StringBuffer sf = new StringBuffer("from SystemLog systemlog where");
		List<Object> obj = new ArrayList<Object>();
		if (logType != null) {
			sf.append(" systemlog.logType=? and");
			obj.add(logType);
		}
		if(!username.equals("")){
			 admin = adminService.getAdminByUsername(username);
			 if (admin!=null) {
					sf.append(" systemlog.operatorID = ? and");
					obj.add (admin.getId());
				}else{
					return null;
				}
		}
		
		if (!logData.equals("")) {
			sf.append(" systemlog.logData like ? and");
			obj.add("%" + logData + "%");
		}
		if (!remark.equals("")) {
			sf.append(" systemlog.remark like ? and");
			obj.add("%" + remark + "%");
		}
		if (!coverage.equals("")) {
			sf.append(" systemlog.coverage like ? and");
			obj.add("%" + coverage + "%");
		}
		if (startTime1 != null) {
			sf.append(" systemlog.logTime>=? and");
			obj.add(startTime1);
		}
		if (endTime1 != null) {
			sf.append(" systemlog.logTime<=? and");
			obj.add(endTime1);
		}
		sf = sf.replace(sf.length() - 4, sf.length(), "");
		//System.out.println(sf.toString()+"--------------"+obj.get(1));
		
		// 查出总行数，对分页进行设置
		Long count = this.executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
		//按时间升序查出记录返回
		return this.executeQuery(pager, sf.toString() + "order by logTime desc", obj.toArray());
	}
	//qinzuohai 根据时间查询日志
	public List<SystemLog> findLogByTime(Date data_startTime,Date data_endTime){
		//System.out.println(data_startTime+"----dao-----"+data_endTime);
		StringBuffer sf = new StringBuffer("from SystemLog systemlog where ");
		List<Object> obj = new ArrayList<Object>();
		if (data_startTime != null) {
			sf.append(" systemlog.logTime>=? and");
			obj.add(data_startTime);
		}
		if (data_endTime != null) {
			sf.append(" systemlog.logTime<=? and");
			obj.add(data_endTime);
		}
		sf = sf.replace(sf.length() - 4, sf.length(), "");
		//System.out.println(sf.toString());
		@SuppressWarnings("unchecked")
		List<SystemLog> list=this.executeQuery( sf.toString() , obj.toArray());
		
		if(!list.isEmpty())return list;
		else return null;
		
	}
	
	//qinzuohai 验证是否存在相同的sys_id,logTime,logType
	public List<SystemLog> ishasLogInfo(Integer sys_id,Date logTime,Integer logType){
		String hql="from SystemLog systemlog where systemlog.sys_id=? and systemlog.logTime=? and systemlog.logType=?";
		//SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		//String _logTime=dateFormat.format(logTime);
		@SuppressWarnings("unchecked")
		List<SystemLog> list=executeQuery(hql,sys_id,logTime,logType);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	
	//qinzuohai 验证是否存在相同的sys_id
	public List<SystemLog> ishasSys_id(Integer sys_id){
		String hql="from SystemLog systemlog where systemlog.sys_id=?";
		@SuppressWarnings("unchecked")
		List<SystemLog> list=executeQuery(hql,sys_id);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	//qinzuohai 验证是否存在相同的logTime
	public List<SystemLog> ishasLogTime(Date logTime){
		String hql="from SystemLog systemlog where systemlog.logTime=?";
		@SuppressWarnings("unchecked")
		List<SystemLog> list=executeQuery(hql,logTime);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}

	//qinzuohai 查询全部日志
	public List<SystemLog> findSystemLog(){
		String hql="from SystemLog systemlog";
		@SuppressWarnings("unchecked")
		List<SystemLog> list=executeQuery(hql);
		if(!list.isEmpty()){
			return list;
		}else
			return null;
	}
	//qinzuohai 删除全部日志
	public boolean deleteSystemLog(){
		String sql="delete from t_park_systemLog";
		jdbcUtil.select(sql);
	    return true;
	}
	//qinzuohai 根据时间删除日志
	public boolean delLogByTime(Date delStartTime,Date delEndTime){
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		StringBuffer sf = new StringBuffer("delete from t_park_systemLog where ");
		if (delStartTime != null) {
			sf.append(" logTime>='"+dateFormat.format(delStartTime)+"' and");
		}
		if (delEndTime != null) {
			sf.append(" logTime<='"+dateFormat.format(delEndTime)+"' and");
		}
		sf = sf.replace(sf.length() - 4, sf.length(), "");
		//System.out.println(sf.toString());
		jdbcUtil.delete(sf.toString());
		return true;
		
	}
}
