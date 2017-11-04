/**
 * 
 */
package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.TimesSignDefDao;
import com.hgsoft.entity.TimesSignDef;

/**
 * @author qinzuohai
 *
 */
@Service
public class TimesSignDefService extends BaseService<TimesSignDef> {

	@Autowired
	public void setDao(@Qualifier("timesSignDefDao") TimesSignDefDao dao) {
		super.setDao(dao);
	}

	private TimesSignDefDao getTimesSignDefDao() {
		return (TimesSignDefDao) this.getDao();
	}

	public List<TimesSignDef> ishasTimesSignDef(Object feeRuleType, Object dayType, Object startTime) {
		return getTimesSignDefDao().ishasTimesSignDef(feeRuleType, dayType, startTime);
	}

	public List<TimesSignDef> LoadTimesSignDef(Object feeRuleType, Object dayType, Object startTime) {
		return getTimesSignDefDao().LoadTimesSignDef(feeRuleType, dayType, startTime);
	}

	public boolean deleteByCompositeID(Object feeRuleType, Object dayType, Object startTime) {
		return getTimesSignDefDao().deleteByCompositeID(feeRuleType, dayType, startTime);
	}
}
