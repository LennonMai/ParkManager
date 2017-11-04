
package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.ParkInformationDao;
import com.hgsoft.entity.ParkInformation;

/**
 * 小区信息
 * 
 * @author qinzuohai
 */
@Service
public class ParkInformationService extends BaseService<ParkInformation> {

	@Autowired
	public void setDao(@Qualifier("parkInformationDao") ParkInformationDao dao) {
		super.setDao(dao);
	}

	private ParkInformationDao getParkInformationDao() {
		return (ParkInformationDao) this.getDao();
	}

	public List<ParkInformation> ishasParkNo(Object areaNo) {
		return getParkInformationDao().ishasParkNo(areaNo);
	}

	public List<ParkInformation> ishasParkNoAndAreaNo(Object areaNo, Object parkNo) {
		return getParkInformationDao().ishasParkNoAndAreaNo(areaNo, parkNo);
	}

	public ParkInformation findParkByName(String parkName) {
		return getParkInformationDao().findParkByName(parkName);
	}

	public List<ParkInformation> LoadParkInfo(Object parkNo) {
		return getParkInformationDao().LoadParkInfo(parkNo);
	}

	public List<ParkInformation> LoadPark(Object areaNo) {
		return getParkInformationDao().LoadPark(areaNo);
	}

	public boolean deleteByAreaNo(Object areaNo) {
		return getParkInformationDao().deleteByAreaNo(areaNo);
	}

	public boolean deleteByparkNo(Object parkNo) {
		return getParkInformationDao().deleteByparkNo(parkNo);
	}

	public List<ParkInformation> LoadParkInfo(Object areaNo, Object parkNo) {
		return getParkInformationDao().LoadParkInfo(areaNo, parkNo);
	}

	public boolean deleteByareaNoparkNo(Object areaNo, Object parkNo) {
		return getParkInformationDao().deleteByareaNoparkNo(areaNo, parkNo);
	}

	public List<ParkInformation> getAllParkInformationByAreaNo(Short areaNo) {
		return getParkInformationDao().getAllParkInformationByAreaNo(areaNo);
	}

	public List<ParkInformation> getAllParkInformation() {
		return getParkInformationDao().getAllParkInformation();
	}

	public ParkInformation getParkInformationByParkNo(Short parkNo) {
		return getParkInformationDao().getParkInformationByParkNo(parkNo);
	}

	public boolean findParkNameByNoThisParkNo(Short parkNo, String parkName) {
		return getParkInformationDao().findParkNameByNoThisParkNo(parkNo, parkName);
	}

	public List<ParkInformation> findParkInformation() {
		return getParkInformationDao().findParkInformation();
	}

}
