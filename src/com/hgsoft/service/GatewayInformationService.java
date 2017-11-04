/**
 * 
 */
package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.GatewayInformationDao;
import com.hgsoft.entity.GatewayInformation;

/**
 * 大门信息
 * 
 * @author qinzuohai
 */
@Service
public class GatewayInformationService extends BaseService<GatewayInformation> {

	@Autowired
	public void setDao(@Qualifier("gatewayInformationDao") GatewayInformationDao dao) {
		super.setDao(dao);
	}

	private GatewayInformationDao getGatewayInformationDao() {
		return (GatewayInformationDao) this.getDao();
	}

	public List<GatewayInformation> LoadGatewayInfo(Object areaNo, Object parkNo, Object gateNo) {
		return getGatewayInformationDao().LoadGatewayInfo(areaNo, parkNo, gateNo);
	}

	public boolean deleteBygateInfo(Object areaNo, Object parkNo, Object gateNo) {
		return getGatewayInformationDao().deleteBygateInfo(areaNo, parkNo, gateNo);
	}

	public List<GatewayInformation> ishasGatewayInfo(Object areaNo, Object parkNo, Object gatewayNo) {
		return getGatewayInformationDao().ishasGatewayInfo(areaNo, parkNo, gatewayNo);
	}

	public List<GatewayInformation> getAllGatewayInformation() {
		return getGatewayInformationDao().getAllGatewayInformation();
	}

	public List<GatewayInformation> getGatewayInformationByParkNo(Short parkNo) {
		return getGatewayInformationDao().getGatewayInformationByParkNo(parkNo);
	}

	public GatewayInformation ishasGateNo(Short gateNo) {
		return getGatewayInformationDao().ishasGateNo(gateNo);
	}

	public boolean deleteByParkNo(Object parkNo) {
		return getGatewayInformationDao().deleteByParkNo(parkNo);
	}

	public List<GatewayInformation> LoadGateway(Object areaNo, Object parkNo) {
		return getGatewayInformationDao().LoadGateway(areaNo, parkNo);
	}

	public GatewayInformation findGateByName(String gateName) {
		return getGatewayInformationDao().findGateByName(gateName);
	}

	public boolean findGateNameInThisParkNoNoThisGateNo(Short parkNo, Short gateNo, String gateName) {
		return getGatewayInformationDao().findGateNameInThisParkNoNoThisGateNo(parkNo, gateNo, gateName);
	}

	public List<GatewayInformation> findGatewayInformation() {
		return getGatewayInformationDao().findGatewayInformation();
	}
}
