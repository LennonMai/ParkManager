/**
 * 
 */
package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.PositionInformationDao;
import com.hgsoft.entity.PositionInformation;

/**
 * Œª÷√–≈œ¢
 * 
 * @author qinzuohai
 */
@Service
public class PositionInformationService extends BaseService<PositionInformation> {

	@Autowired
	public void setDao(@Qualifier("positionInformationDao") PositionInformationDao dao) {
		super.setDao(dao);
	}

	private PositionInformationDao getPositionInformationDao() {
		return (PositionInformationDao) this.getDao();
	}

	public List<PositionInformation> LoadPositionInfo(Object no) {
		return getPositionInformationDao().LoadPositionInfo(no);
	}

	public boolean deleteByNo(Object no) {
		return getPositionInformationDao().deleteByNo(no);
	}

	public List<PositionInformation> ishasPositionNo(Object positionNo) {
		return getPositionInformationDao().ishasPositionNo(positionNo);
	}

	public List<PositionInformation> ishasPositionNoAndClass(Object positionNo, Object class_) {
		return getPositionInformationDao().ishasPositionNoAndClass(positionNo, class_);
	}

	public List<PositionInformation> ishasiid(Object iid) {
		return getPositionInformationDao().ishasiid(iid);
	}

	public List<PositionInformation> LoadPositionInfo(Object no, Object class_) {
		return getPositionInformationDao().LoadPositionInfo(no, class_);
	}

	public boolean deleteByNoAndClass(Object no, Object class_) {
		return getPositionInformationDao().deleteByNoAndClass(no, class_);
	}
}
