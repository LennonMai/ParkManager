package com.hgsoft.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.GenerateSumDao;
import com.hgsoft.entity.SquadLog;
import com.hgsoft.util.Pager;

/**
 * 生成合计数Service
 * 
 * @author caijunhua
 *
 */

@Service
public class GenerateSumService extends BaseService<SquadLog> {

	@Autowired
	public void setDao(@Qualifier("generateSumDao") GenerateSumDao dao) {
		super.setDao(dao);
	}

	private GenerateSumDao getGenerateSumDao() {
		return (GenerateSumDao) this.getDao();
	}

	// 查询大门总合计数列表
	@SuppressWarnings("unchecked")
	public List queryGateSum(Pager pager, Integer areaNo, Integer parkNo, String gateNo, Date squadDate,
			String stationYNSum) {
		return getGenerateSumDao().queryGateSum(pager, areaNo, parkNo, gateNo, squadDate, stationYNSum);
	}

	// 查询车道合计数列表
	@SuppressWarnings("unchecked")
	public List queryLaneSum(Integer areaNo, Integer parkNo, String gateNo, Date squadDate) {
		return getGenerateSumDao().queryLaneSum(areaNo, parkNo, gateNo, squadDate);
	}

	// //根据大门名称查大门编号
	// public int queryGateNo(String gateName) {
	// return ((GenerateSumDao)getDao()).queryGateNo(gateName);
	// }

	// 计算中心数据
	@SuppressWarnings("unchecked")
	public List countCenterLaneData(String month, Integer areaNo, Integer parkNo, String gateNo, String laneNo,
			Date squadDate, String squadNo) {
		return getGenerateSumDao().countCenterLaneData(month, areaNo, parkNo, gateNo, laneNo, squadDate, squadNo);
	}

	// 查询没合计车道总列表
	@SuppressWarnings("unchecked")
	public List queryLaneNotSum(Integer areaNo, Integer parkNo, String gateNo, Date squadDate) {
		return getGenerateSumDao().queryLaneNotSum(areaNo, parkNo, gateNo, squadDate);
	}

	// 生成车道合计数
	public void generateLaneSum(String areaNo, String parkNo, String gateNo, String laneNo, String squadDate,
			String squadNo, String laneTypeNo, String recordCnt, String moneySummation) {
		getGenerateSumDao().generateLaneSum(areaNo, parkNo, gateNo, laneNo, squadDate, squadNo, laneTypeNo, recordCnt,
				moneySummation);
	}

	// 生成大门合计数
	public void generateGateSum(String areaNo, String parkNo, String gateNo, String squadDate) {
		getGenerateSumDao().generateGateSum(areaNo, parkNo, gateNo, squadDate);
	}

	// 查询车道合计数是否存在
	public int selectLaneSum(String areaNo, String parkNo, String gateNo, String laneNo, String squadDate,
			String squadNo) {
		return getGenerateSumDao().selectLaneSum(areaNo, parkNo, gateNo, laneNo, squadDate, squadNo);
	}

	public void deleteLaneSum(String areaNo, String parkNo, String gateNo, String laneNo, String squadDate,
			String squadNo) {
		getGenerateSumDao().deleteLaneSum(areaNo, parkNo, gateNo, laneNo, squadDate, squadNo);
	}

	public void deleteAllLaneSum(String areaNo, String parkNo, String gateNo, String squadDate) {
		getGenerateSumDao().deleteAllLaneSum(areaNo, parkNo, gateNo, squadDate);
	}

	// 查询大门合计数是否存在
	public int selectGateSum(String areaNo, String parkNo, String gateNo, String squadDate) {
		return getGenerateSumDao().selectGateSum(areaNo, parkNo, gateNo, squadDate);
	}

	// 查询合计时先删除之前生成的数据
	public void deleteGateSum(String areaNo, String parkNo, String gateNo, String squadDate) {
		getGenerateSumDao().deleteGateSum(areaNo, parkNo, gateNo, squadDate);
	}

	// 计算工班数
	public int countSquad() {
		return getGenerateSumDao().countSquad();
	}

	// 计算大门出口车道数
	public int countLane(String gateNo) {
		return getGenerateSumDao().countLane(gateNo);
	}

	// 计算已经合计的大门车道数
	public int countLaneSummation(String areaNo, String parkNo, String gateNo, String squadDate) {
		return getGenerateSumDao().countLaneSummation(areaNo, parkNo, gateNo, squadDate);
	}

	// 计算车道工班表中的记录数
	public int countSquadLog(String areaNo, String parkNo, String gateNo, String squadDate) {
		return getGenerateSumDao().countSquadLog(areaNo, parkNo, gateNo, squadDate);
	}

	// 把做了合计数的站、工班信息，写入报表未统计信息表
	public void insertSunInfo(String areaNo, String parkNo, String gateNo, String squadDate, String squadNo) {
		getGenerateSumDao().insertSunInfo(areaNo, parkNo, gateNo, squadDate, squadNo);
	}

}
