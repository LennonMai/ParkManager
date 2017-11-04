package com.hgsoft.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;
import com.hgsoft.entity.SpVehHandle;
import com.hgsoft.util.Pager;


/**
 * 特殊车辆处理信息DAO
 * @author caijunhua
 *
 */

@Repository
public class SpVehHandleDao extends BaseDao<SpVehHandle> {
	/**
	 * 根据查询条件查询特殊车辆处理信息
	 * @param pager
	 * @param laneType 车道类型
	 * @param tableName 表名
	 * @param status 状态
	 * @param handleType 处理类型
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<SpVehHandle> findSpVehHandleByHql(Pager pager,
			Short laneType, String tableName, Integer status, Integer handleType) {

		StringBuffer sf = new StringBuffer("from SpVehHandle spVehHandle where");
		List<Object> list = new ArrayList<Object>();
		if (null != laneType && !"".equals(laneType)) {
			sf.append(" spVehHandle.laneType = ? and");
			list.add(laneType);
		}
		if (null != tableName && !"".equals(tableName)) {
			sf.append(" spVehHandle.tableName like ? and");
			list.add("%" + tableName + "%");
		}
		if (null != status && !"".equals(status)) {
			sf.append(" spVehHandle.status = ? and");
			list.add(status);
		}
		if (null != handleType && !"".equals(handleType)) {
			sf.append(" spVehHandle.handleType = ? and");
			list.add(handleType);
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
		return this.executeQuery(pager, sf.toString() + " order by laneType,tableName,status asc", list.toArray());
	}
	
}
