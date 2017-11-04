/**
 * 
 */
package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.UserCardRateDao;
import com.hgsoft.entity.UserCardRate;
import com.hgsoft.util.Pager;

/**
 * @author qinzuohai
 *
 */
@Service
public class UserCardRateService extends BaseService<UserCardRate> {

	@Autowired
	public void setDao(@Qualifier("userCardRateDao") UserCardRateDao dao) {
		super.setDao(dao);
	}

	private UserCardRateDao getUserCardRateDao() {
		return (UserCardRateDao) this.getDao();
	}

	public List<UserCardRate> ishasUserCardRate(Object version, Object recNo) {
		return getUserCardRateDao().ishasUserCardRate(version, recNo);
	}

	public List<UserCardRate> LoadUserCardRate(Object version, Object recNo) {
		return getUserCardRateDao().LoadUserCardRate(version, recNo);
	}

	public boolean deleteBycompositeID(Object version, Object recNo) {
		return getUserCardRateDao().deleteBycompositeID(version, recNo);
	}

	// chenfuyuan
	public List<UserCardRate> getAllUserCardRate() {
		return getUserCardRateDao().getAllUserCardRate();
	}

	public UserCardRate getUserCardRateByVersionAndRecNo(Short version, Short recNo) {
		return getUserCardRateDao().getUserCardRateByVersionAndRecNo(version, recNo);
	}

	// zenggenbao
	public int getMax() {
		return getUserCardRateDao().getMax();
	}

	public List<UserCardRate> findByCondition(Pager pager, Short version, Short userCardType, Short recNo) {
		return getUserCardRateDao().findByCondition(pager, version, userCardType, recNo);
	}

}
