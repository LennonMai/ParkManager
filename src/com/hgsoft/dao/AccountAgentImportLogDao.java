package com.hgsoft.dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.hgsoft.entity.AccountAgentImportLog;
import com.hgsoft.util.Pager;


/**
 * 粤通卡接口数据导入日志DAO
 * @author caijunhua
 *
 */

@Repository
public class AccountAgentImportLogDao extends BaseDao<AccountAgentImportLog> {
	/**
	 * 根据查询条件查询粤通卡接口数据导入日志
	 * @param pager
	 * @param startTime 开始时间
	 * @param endTime 结束时间
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<AccountAgentImportLog> findAccountAgentImportLogByHql(Pager pager,
			String startTime, String endTime) {

		StringBuffer sf = new StringBuffer("from AccountAgentImportLog accountAgentImportLog where");
		List<Object> list = new ArrayList<Object>();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if (null != startTime && !"".equals(startTime)) {
			sf.append(" accountAgentImportLog.opTime >= ? and");
			try {
				list.add(sdf.parse(startTime));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		if (null != endTime && !"".equals(endTime)) {
			sf.append(" accountAgentImportLog.opTime <= ? and");
			try {
				list.add(sdf.parse(endTime));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		if(list.size() != 0 ) {
			sf = sf.replace(sf.length() - 4, sf.length(), "");
		} else {
			sf = sf.replace(sf.length() - 6, sf.length(), "");
		}
		
		// 查出总行数，对分页进行设置
		Long count = this.executeCount(sf.toString(), list.toArray());
		pager.setTotalSize(count);
		//按时间降序查出记录返回
		return this.executeQuery(pager, sf.toString() + " order by opTime desc", list.toArray());
	}
	
}
