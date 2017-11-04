/**
 * 
 */
package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.LaneUseDao;
import com.hgsoft.entity.LaneUse;

/**
 * 有用车道信息
 * 
 * @author qinzuohai
 */
@Service
public class LaneUseService extends BaseService<LaneUse> {

	@Autowired
	public void setDao(@Qualifier("laneUseDao") LaneUseDao dao) {
		super.setDao(dao);
	}

	private LaneUseDao getLaneUseDao() {
		return (LaneUseDao) this.getDao();
	}

	public List<LaneUse> ishasLaneUse(Short areaNo, Short parkNo, Short gatewayNo, Short laneNo) {
		return getLaneUseDao().ishasLaneUse(areaNo, parkNo, gatewayNo, laneNo);
	}

	public List<LaneUse> LoadLaneUse(Short areaNo, Short parkNo, Short gatewayNo, Short laneNo) {
		return getLaneUseDao().LoadLaneUse(areaNo, parkNo, gatewayNo, laneNo);
	}

	public boolean deleteBylaneUse(Short areaNo, Short parkNo, Short gatewayNo, Short laneNo) {
		return getLaneUseDao().deleteBylaneUse(areaNo, parkNo, gatewayNo, laneNo);
	}

	public void deleteLaneUseByAPGL(Short areaNo, Short parkNo, Short gateNo, Short laneNo) {
		getLaneUseDao().deleteLaneUseByAPGL(areaNo, parkNo, gateNo, laneNo);
	}

	public List<LaneUse> ishasLaneUseIP(String laneComputerIp) {
		return getLaneUseDao().ishasLaneUseIP(laneComputerIp);
	}

	public List<LaneUse> ishasLaneUseNo(Short laneNo) {
		return getLaneUseDao().ishasLaneUseNo(laneNo);
	}

	public boolean deleteByGateNo(Short gatewayNo) {
		return getLaneUseDao().deleteByGateNo(gatewayNo);
	}

	public List<LaneUse> findLaneUse() {
		return getLaneUseDao().findLaneUse();
	}

	public Short findLaneUseNoByIP(String IP) {
		return getLaneUseDao().findLaneUseNoByIP(IP);
	}

	public List<LaneUse> findLaneUseByIsUse() {
		return getLaneUseDao().findLaneUseByIsUse();
	}

	public void insertLaneUseByLane() {
		getLaneUseDao().insertLaneUseByLane();
	}

	public void deleteAllLaneUse() {
		getLaneUseDao().deleteAllLaneUse();
	}

}
