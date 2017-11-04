package com.hgsoft.dao;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;
import com.hgsoft.entity.GatewayInformation;
import com.hgsoft.util.JdbcUtil;

@Repository
public class GatewayInformationDao extends BaseDao<GatewayInformation> {
	@Resource
	private JdbcUtil jdbcUtil;

	// 验证保存大门信息时，是否存在相同的大门编码
	@SuppressWarnings("unchecked")
	public List<GatewayInformation> ishasGatewayInfo(Object areaNo,
			Object parkNo, Object gatewayNo) {
		// System.out.println(areaNo+","+parkNo+","+gatewayNo);
		// caijunhua修改为按areaNo，parkNo，gatewayNo查询
		String hql = "select gatewayInfo.gateNo from GatewayInformation gatewayInfo "
				+ " where gatewayInfo.areaNo=? and gatewayInfo.parkNo=? and gatewayInfo.gateNo=?";
		List<GatewayInformation> list = executeQuery(hql, areaNo, parkNo,
				gatewayNo);
		if (!list.isEmpty()) {
			return list;
		} else
			return null;
	}

	// 根据gateNo加载GatewayInformation
	@SuppressWarnings("unchecked")
	public List<GatewayInformation> LoadGatewayInfo(Object areaNo,
			Object parkNo, Object gateNo) {

		String hql = "from GatewayInformation gatewayInfo where gatewayInfo.areaNo=? and gatewayInfo.parkNo=? and gatewayInfo.gateNo=?";
		List<GatewayInformation> list = executeQuery(hql, areaNo, parkNo,
				gateNo);
		if (!list.isEmpty()) {
			return list;
		} else
			return null;
	}

	@SuppressWarnings("unchecked")
	public List<GatewayInformation> LoadGateway(Object areaNo, Object parkNo) {
		String hql = "from GatewayInformation gatewayInfo where gatewayInfo.areaNo=? and gatewayInfo.parkNo=?";
		List<GatewayInformation> list = executeQuery(hql, areaNo, parkNo);
		if (!list.isEmpty()) {
			return list;
		} else
			return null;
	}

	// 根据gateNo删除GatewayInformation
	public boolean deleteBygateInfo(Object areaNo, Object parkNo, Object gateNo) {
		List<GatewayInformation> li=this.LoadGatewayInfo(areaNo,parkNo, gateNo);
		if(li!=null){
			GatewayInformation gatewayInformation = li.get(0);
			getSession().clear();
			getSession().refresh(gatewayInformation);
			getSession().merge(gatewayInformation);
			getSession().delete(gatewayInformation);
		}
	
		if (this.LoadGatewayInfo(areaNo, parkNo, gateNo) == null)
			return true;
		else
			return false;
	}

	// 根据小区删除该小区下的全部大门
	public boolean deleteByParkNo(Object parkNo) {
		String sql = "delete tb_Gateway where ParkNo='" + parkNo + "'";
		jdbcUtil.delete(sql);
		return true;
	}

	// chenfuyuan
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<GatewayInformation> getAllGatewayInformation() {
		String hql = "from GatewayInformation gatewayInformation";
		List resultList = executeQuery(hql);
		if (resultList.isEmpty()) {
			return null;
		} else {

			return resultList;
		}
	}

	// chenfuyuan
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<GatewayInformation> getGatewayInformationByParkNo(Short parkNo) {
		String hql = "from GatewayInformation gatewayInformation where gatewayInformation.parkNo="
				+ parkNo;
		List resultList = executeQuery(hql);
		if (resultList.isEmpty()) {
			return null;
		} else {

			return resultList;
		}
	}

	// 验证大门编号是否存在
	public GatewayInformation ishasGateNo(Short gateNo) {
		String hql = "from GatewayInformation gatewayInfo where gatewayInfo.gateNo=?";
		@SuppressWarnings("unchecked")
		List<GatewayInformation> resultList = executeQuery(hql, gateNo);
		if (resultList.isEmpty()) {
			return null;
		} else {
			return resultList.get(0);
		}
	}

	// caijunhua 验证大门名称是否存在
	@SuppressWarnings({ "rawtypes" })
	public GatewayInformation findGateByName(String gateName) {
		String hql = "from GatewayInformation gatewayInfo where gatewayInfo.gateName=?";
		List resultList = executeQuery(hql, gateName);
		if (resultList.isEmpty()) {
			return null;
		} else {
			return (GatewayInformation) resultList.get(0);
		}
	}
	
	@SuppressWarnings("unchecked")
	public boolean findGateNameInThisParkNoNoThisGateNo(Short parkNo,Short gateNo,String gateName) {
		String hql = "from GatewayInformation gatewayInfo where gatewayInfo.parkNo=? and gatewayInfo.gateNo!=? ";
		List<GatewayInformation>  resultList = executeQuery(hql,parkNo,gateNo);
		for(int i=0;i<resultList.size();i++){
			if(gateName.trim().equals(resultList.get(i).getGateName().trim()))
			return true;
		}
		return false;
	}
	@SuppressWarnings("unchecked")
	public List<GatewayInformation> findGatewayInformation() {
		String hql = "from GatewayInformation gatewayInformation ";
		List<GatewayInformation> list = executeQuery(hql);
		if (list.isEmpty()) {
			return null;
		} else {
			return list;
		}
	}
}
