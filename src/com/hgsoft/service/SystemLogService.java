package com.hgsoft.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.SystemLogDao;
import com.hgsoft.entity.Admin;
import com.hgsoft.entity.SystemLog;
import com.hgsoft.util.Pager;

/**
 * 系统日志Service
 * 
 * @author caijunhua
 * 
 */

@Service
public class SystemLogService extends BaseService<SystemLog> {

	private SystemLog systemLog;

	@Autowired
	public void setDao(@Qualifier("systemLogDao") SystemLogDao dao) {
		super.setDao(dao);
	}

	private SystemLogDao getSystemLogDao() {
		return (SystemLogDao) this.getDao();
	}

	// private Admin admin;
	/**
	 * 根据查询条件查询系统日志
	 * 
	 * @param pager
	 * @param logType
	 *            日志类型
	 * @param username
	 *            用户名（操作员名）
	 * @param logData
	 *            日志内容
	 * @param remark
	 *            备注
	 * @param coverage
	 *            影响范围
	 * @param startTime1
	 *            开始时间
	 * @param endTime1
	 *            结束时间
	 * @return
	 */
	public List<SystemLog> findAllSystemLogByHql(Pager pager, Integer logType, String username, String logData,
			String remark, String coverage, Date startTime1, Date endTime1) {
		return getSystemLogDao().findAllSystemLogByHql(pager, logType, username, logData, remark, coverage, startTime1,
				endTime1);
	}

	/**
	 * 保存信息到系统日志
	 * 
	 * @param logTime
	 *            日志时间
	 * @param logType
	 *            日志类型
	 * @param admin
	 *            用户对象（操作员对象）
	 * @param logData
	 *            日志内容
	 * @param coverage
	 *            影响范围
	 * @param remark
	 *            备注
	 * @return
	 */
	public void save(Date logTime, int logType, Admin admin, String logData, String coverage, String remark) {
		systemLog = new SystemLog();
		// System.out.println("systemLog:"+logTime+","+admin+","+logData+","+coverage+","+remark);
		systemLog.setLogTime(logTime);
		systemLog.setLogType(logType);
		systemLog.setOperatorID(admin.getId());
		systemLog.setLogData(logData);
		systemLog.setCoverage(coverage);
		systemLog.setRemark(remark);

		getSystemLogDao().save(systemLog);
	}

	// qinzuohai
	public List<SystemLog> findLogByTime(Date data_startTime, Date data_endTime) {
		return getSystemLogDao().findLogByTime(data_startTime, data_endTime);
	}

	public List<SystemLog> ishasSys_id(Integer sys_id) {
		return getSystemLogDao().ishasSys_id(sys_id);
	}

	public List<SystemLog> ishasLogTime(Date logTime) {
		return getSystemLogDao().ishasLogTime(logTime);
	}

	// qinzuohai
	public List<SystemLog> ishasLogInfo(Integer sys_id, Date logTime, Integer logType) {
		return getSystemLogDao().ishasLogInfo(sys_id, logTime, logType);
	}

	public boolean delLogByTime(Date delStartTime, Date delEndTime) {
		return getSystemLogDao().delLogByTime(delStartTime, delEndTime);
	}

	public List<SystemLog> findSystemLog() {
		return getSystemLogDao().findSystemLog();
	}

	public boolean deleteSystemLog() {
		return getSystemLogDao().deleteSystemLog();
	}

	public SystemLog getSystemLog() {
		return systemLog;
	}

	public void setSystemLog(SystemLog systemLog) {
		this.systemLog = systemLog;
	}

	// @Resource
	// public void setSystemLogDao(SystemLogDao systemLogDao) {
	// this.systemLogDao = systemLogDao;
	// }
	// public SystemLogDao getSystemLogDao() {
	// return systemLogDao;
	// }
	// @Override
	// public List<SystemLog> findByPager(Pager pager) {
	// // TODO Auto-generated method stub
	// return getSystemLogDao().findByPager(pager, Order.desc("sys_id"));
	// }

}
