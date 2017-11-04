/**
 * 
 */
package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.FreeDaysDao;
import com.hgsoft.entity.FreeDays;

/**
 * @author qinzuohai
 *
 */
@Service
public class FreeDaysService extends BaseService<FreeDays> {

	@Autowired
	public void setDao(@Qualifier("freeDaysDao") FreeDaysDao dao) {
		super.setDao(dao);
	}

	private FreeDaysDao getFreeDaysDao() {
		return (FreeDaysDao) this.getDao();
	}

	public List<FreeDays> ishasFreeDays(Object feeRuleType, Object type, Object value) {
		return getFreeDaysDao().ishasFreeDays(feeRuleType, type, value);
	}

	public List<FreeDays> LoadFreeDays(Object feeRuleType, Object type, Object value) {
		return getFreeDaysDao().LoadFreeDays(feeRuleType, type, value);
	}

	public boolean deleteByFeeRuleType(Object feeRuleType, Object type, Object value) {
		return getFreeDaysDao().deleteByFeeRuleType(feeRuleType, type, value);
	}

	public boolean _update(FreeDays freeDays, Object feeRuleType, Object type, Object value) {
		return getFreeDaysDao()._update(freeDays, feeRuleType, type, value);
	}

}
