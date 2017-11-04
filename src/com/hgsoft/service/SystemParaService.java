/**
 * 
 */
package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.SystemParaDao;
import com.hgsoft.entity.SystemPara;
import com.hgsoft.util.Pager;

/**
 * @author qinzuohai
 *
 */
@Service
public class SystemParaService extends BaseService<SystemPara> {

	@Autowired
	public void setDao(@Qualifier("systemParaDao") SystemParaDao dao) {
		super.setDao(dao);
	}

	private SystemParaDao getSystemParaDao() {
		return (SystemParaDao) this.getDao();
	}

	public List<SystemPara> ishasSystemPara(Object paraClass, Object item) {
		return getSystemParaDao().ishasSystemPara(paraClass, item);
	}

	public List<SystemPara> LoadSystemPara(Object paraClass, Object item) {
		return getSystemParaDao().LoadSystemPara(paraClass, item);
	}

	public boolean deleteBycompositeID(Object paraClass, Object item) {
		return getSystemParaDao().deleteBycompositeID(paraClass, item);
	}

	public List<SystemPara> findSystemParaByCondition(Pager pager, Short paraClass, String item, String itemValue,
			String groupName) {
		return getSystemParaDao().findSystemParaByCondition(pager, paraClass, item, itemValue, groupName);
	}

	public List<SystemPara> findAll() {
		return getSystemParaDao().findAll();
	}

	public Short findSecondMaxItemOrderByparaClass(Short paraClass) {
		return getSystemParaDao().findSecondMaxItemOrderByparaClass(paraClass);
	}

	public Short findMaxItemOrderBygroupName(String groupName) {
		return getSystemParaDao().findMaxItemOrderBygroupName(groupName);
	}

	public List<SystemPara> findGroupName() {
		return getSystemParaDao().findGroupName();
	}

}
