package com.hgsoft.dao;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.hgsoft.entity.SquadLog;
import com.hgsoft.util.JdbcUtil;
import com.hgsoft.util.Pager;

/**
 * 合计数修改DAO
 * @author caijunhua
 *
 */

@Repository
public class SquadLogDao extends BaseDao<SquadLog>{
	@Resource
	private JdbcUtil jdbcUtil;
	
	@SuppressWarnings("unchecked")
	public List<SquadLog> fillAllSquadLog(Pager pager){
		StringBuffer sf = new StringBuffer("from SquadLog squadLog where laneType = 2");
		List<Object> obj = new ArrayList<Object>();
		Long count = this.executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
		//按工班日期降序查出记录返回
		return this.executeQuery(pager, sf.toString() + " order by squadDate desc", obj.toArray());
	}
	
	/**
	 * 根据查询条件查询合计数
	 * @param pager
	 * @param gateNo 大门编码
	 * @param laneNo 车道编码
	 * @param squadDate 工班日期
	 * @param squadNo 工班号
	 * @param operatorNo 收费员工号
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<SquadLog> fillAllSquadLogByHql(Pager pager, Short gateNo,
			Short laneNo, Date squadDate, Short squadNo, Integer operatorNo) {
		
		StringBuffer sf = new StringBuffer("from SquadLog squadLog where");
		List<Object> obj = new ArrayList<Object>();
		if(null != gateNo) {
			sf.append(" gateNo=? and");
			obj.add(gateNo);
		}
		if(null != laneNo) {
			sf.append(" laneNo=? and");
			obj.add(laneNo);
		}
		if(null != squadDate) {
			sf.append(" squadDate=? and");
			obj.add(squadDate);
		}
		if(null != squadNo) {
			sf.append(" squadNo=? and");
			obj.add(squadNo);
		}
		if(null != operatorNo) {
			sf.append(" operatorNo=? and");
			obj.add(operatorNo);
		}
		
		sf = sf.append(" laneType = 2");
		/*if(obj.size() != 0 ) {
			//sf = sf.replace(sf.length() - 4, sf.length(), "");
			sf = sf.append(" laneType = 2");
		} else {
			sf = sf.replace(sf.length() - 6, sf.length(), "");
		}*/
		
		Long count = this.executeCount(sf.toString(), obj.toArray());
		pager.setTotalSize(count);
		//按工班日期降序查出记录返回
		return this.executeQuery(pager, sf.toString() + " order by squadDate desc", obj.toArray());
	}
	
	//通过区域、小区、大门、车道编码，操作员号，工班日期，工班号，登录时间 查询合计数信息
	@SuppressWarnings("unchecked")
	public List<SquadLog> loadSquadLog(Short areaNo, Short parkNo, Short gateNo, 
			Short laneNo, Integer operatorNo, Date squadDate, Short squadNo, Date loginTime) {
		String hql = "from SquadLog squadLog where areaNo=? " +
				"and parkNo=? and gateNo=? and laneNo=? " +
				"and operatorNo=? and squadDate=? and squadNo=? " +
				"and loginTime=? ";
		List resultList = executeQuery(hql, areaNo, parkNo, gateNo, laneNo, operatorNo,
				squadDate, squadNo, loginTime);
		if(resultList.isEmpty()) {
			return null;
		} else {
			return resultList;
		}
	}
	
	//统计中心流水数和通行费
	@SuppressWarnings("unchecked")
	public List loadCenterData(String month, Short areaNO,Short parkNo,Short gateNo,Short laneNo,Date squadDate, Short squadNo, Short listName) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if(null != month) {
			String squadDateTemp = null;
			if(null != squadDate ) {
				squadDateTemp = format.format(squadDate);
			}			
			String sql = "SELECT isnull(SUM(VehCount), 0) AS Count, isnull(SUM(cashMoney + etcMoney), 0) AS Money" +
					" FROM tb_OutList"+month+" WHERE AreaNO = "+areaNO+" and ParkNo = "+parkNo+" and GateNo = "+gateNo+" and LaneNo = "+laneNo+" and SquadDate = '"+squadDateTemp+"' and ListName = "+listName;
//			System.out.println(sql);
			List resultList = jdbcUtil.selectForList(sql);
			
			return resultList;
		} else {
			return null;
		}
	}
	
}
