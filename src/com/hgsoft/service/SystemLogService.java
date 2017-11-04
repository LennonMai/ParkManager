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
 * ϵͳ��־Service
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
	 * ���ݲ�ѯ������ѯϵͳ��־
	 * 
	 * @param pager
	 * @param logType
	 *            ��־����
	 * @param username
	 *            �û���������Ա����
	 * @param logData
	 *            ��־����
	 * @param remark
	 *            ��ע
	 * @param coverage
	 *            Ӱ�췶Χ
	 * @param startTime1
	 *            ��ʼʱ��
	 * @param endTime1
	 *            ����ʱ��
	 * @return
	 */
	public List<SystemLog> findAllSystemLogByHql(Pager pager, Integer logType, String username, String logData,
			String remark, String coverage, Date startTime1, Date endTime1) {
		return getSystemLogDao().findAllSystemLogByHql(pager, logType, username, logData, remark, coverage, startTime1,
				endTime1);
	}

	/**
	 * ������Ϣ��ϵͳ��־
	 * 
	 * @param logTime
	 *            ��־ʱ��
	 * @param logType
	 *            ��־����
	 * @param admin
	 *            �û����󣨲���Ա����
	 * @param logData
	 *            ��־����
	 * @param coverage
	 *            Ӱ�췶Χ
	 * @param remark
	 *            ��ע
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
