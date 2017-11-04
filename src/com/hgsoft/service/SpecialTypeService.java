package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.SpecialTypeDao;
import com.hgsoft.entity.SpecialType;

/**
 * @author qinzuohai
 */
@Service
public class SpecialTypeService extends BaseService<SpecialType> {

	@Autowired
	public void setDao(@Qualifier("specialTypeDao") SpecialTypeDao dao) {
		super.setDao(dao);
	}

	private SpecialTypeDao getSpecialTypeDao() {
		return (SpecialTypeDao) this.getDao();
	}

	public List<SpecialType> findSpecialType() {
		return getSpecialTypeDao().findSpecialType();
	}

}
