/**
 * 
 */
package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.CarSpaceInformationDao;
import com.hgsoft.entity.CarSpaceInformation;

/**
 * 车位信息
 * 
 * @author qinzuohai
 */
@Service
public class CarSpaceInformationService extends BaseService<CarSpaceInformation> {

	@Autowired
	public void setDao(@Qualifier("carSpaceInformationDao") CarSpaceInformationDao dao) {
		super.setDao(dao);
	}

	private CarSpaceInformationDao getCarSpaceInformationDao() {
		return (CarSpaceInformationDao) this.getDao();
	}

	public List<CarSpaceInformation> ishascarSpace(Object parkNo) {
		return getCarSpaceInformationDao().ishascarSpace(parkNo);
	}

	public boolean deleteByParkNo(Object ParkNo) {
		return getCarSpaceInformationDao().deleteByParkNo(ParkNo);
	}

	public void delete(Short parkNo) {
		if (this.ishascarSpace(parkNo) != null) {
			this.deleteById(parkNo);
		}
	}

	public List<CarSpaceInformation> getAllCarSpaceByParkNoAndGateNo(Object parkNo, Object gateNo) {
		return getCarSpaceInformationDao().getAllCarSpaceByParkNoAndGateNo(parkNo, gateNo);
	}

	public void deleteByParkNoAndGateNo(Object ParkNo, Object gateNo) {
		getCarSpaceInformationDao().deleteByParkNoAndGateNo(ParkNo, gateNo);
	}

	public CarSpaceInformation getCarSpaceByParkNoAndGateNo(Object parkNo, Object gateNo) {
		return getCarSpaceInformationDao().getCarSpaceByParkNoAndGateNo(parkNo, gateNo);
	}
}
