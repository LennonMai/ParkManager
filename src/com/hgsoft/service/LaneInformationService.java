/**
 * 
 */
package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.LaneInformationDao;
import com.hgsoft.entity.LaneInformation;

/**
 * 车道信息
 * 
 * @author qinzuohai
 */
@Service
public class LaneInformationService extends BaseService<LaneInformation> {

	@Autowired
	public void setDao(@Qualifier("laneInformationDao") LaneInformationDao dao) {
		super.setDao(dao);
	}

	private LaneInformationDao getLaneInformationDao() {
		return (LaneInformationDao) this.getDao();
	}

	public List<LaneInformation> LoadLaneInfo(Object areaNo, Object parkNo, Object gatewayNo, Object laneNo) {
		return getLaneInformationDao().LoadLaneInfo(areaNo, parkNo, gatewayNo, laneNo);
	}

	public boolean deleteBylaneInfo(Object areaNo, Object parkNo, Object gatewayNo, Object laneNo) {
		return getLaneInformationDao().deleteBylaneInfo(areaNo, parkNo, gatewayNo, laneNo);
	}

	public List<LaneInformation> ishasLaneNo(Object laneNo) {
		return getLaneInformationDao().ishasLaneNo(laneNo);
	}

	public List<LaneInformation> ishasLaneInfo(Object areaNo, Object parkNo, Object gatewayNo, Object laneNo) {
		return getLaneInformationDao().ishasLaneInfo(areaNo, parkNo, gatewayNo, laneNo);
	}

	public List<LaneInformation> getLaneInformationByParkNoAndGateNo(Short parkNo, Short gateNo) {
		return getLaneInformationDao().getLaneInformationByParkNoAndGateNo(parkNo, gateNo);
	}

	public List<LaneInformation> getLaneInformationByParkNo(Short parkNo) {
		return getLaneInformationDao().getLaneInformationByParkNo(parkNo);
	}

	public List<LaneInformation> getAllLaneInformationByGateNo(Short gateNo) {
		return getLaneInformationDao().getAllLaneInformationByGateNo(gateNo);
	}

	public List<LaneInformation> findLaneInformation() {
		return getLaneInformationDao().findLaneInformation();
	}

	public Short findLaneNoByIP(String IP) {
		return getLaneInformationDao().findLaneNoByIP(IP);
	}

	public boolean deleteByGateNo(Object gatewayNo) {
		return getLaneInformationDao().deleteByGateNo(gatewayNo);
	}

	// caijunhua通过大门取 出口 车道
	public List<LaneInformation> getLaneInformationByGateNo(Short gateNo) {
		return getLaneInformationDao().getLaneInformationByGateNo(gateNo);
	}

	public List<LaneInformation> ishasLaneIP(String laneComputerIp) {
		return getLaneInformationDao().ishasLaneIP(laneComputerIp);
	}

	public LaneInformation getLaneInfoByAPGL(Object areaNo, Object parkNo, Object gatewayNo, Object laneNo) {
		return getLaneInformationDao().getLaneInfoByAPGL(areaNo, parkNo, gatewayNo, laneNo);
	}

	// caijunhua添加车道启用/不启用合计方法
	public void allUse() {
		getLaneInformationDao().allUse();
	}

	public void allNotUse() {
		getLaneInformationDao().allNotUse();
	}
}
