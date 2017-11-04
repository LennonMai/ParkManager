package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.SpVehHandleDao;
import com.hgsoft.entity.SpVehHandle;
import com.hgsoft.util.Pager;

/**
 * 特殊车辆处理信息Service
 * 
 * @author caijunhua
 *
 */

@Service
public class SpVehHandleService extends BaseService<SpVehHandle> {

	@Autowired
	public void setDao(@Qualifier("spVehHandleDao") SpVehHandleDao dao) {
		super.setDao(dao);
	}

	private SpVehHandleDao getSpVehHandleDao() {
		return (SpVehHandleDao) this.getDao();
	}

	/**
	 * 根据查询条件查询特殊车辆处理信息
	 * 
	 * @param pager
	 * @param laneType
	 *            车道类型
	 * @param tableName
	 *            表名
	 * @param status
	 *            状态
	 * @param handleType
	 *            处理类型
	 * @return
	 */
	public List<SpVehHandle> findSpVehHandleByHql(Pager pager, Short laneType, String tableName, Integer status,
			Integer handleType) {
		return getSpVehHandleDao().findSpVehHandleByHql(pager, laneType, tableName, status, handleType);
	}

}
