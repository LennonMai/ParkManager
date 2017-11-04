package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.SpEventCodeDao;
import com.hgsoft.entity.SpEventCode;
import com.hgsoft.util.Pager;

@Service
public class SpEventCodeService extends BaseService<SpEventCode> {

	@Autowired
	public void setDao(@Qualifier("spEventCodeDao") SpEventCodeDao dao) {
		super.setDao(dao);
	}

	private SpEventCodeDao getSpEventCodeDao() {
		return (SpEventCodeDao) this.getDao();
	}

	public List<SpEventCode> findByCondition(Pager pager, Short spEventNo, String spEventName) {
		return getSpEventCodeDao().findByCondition(pager, spEventNo, spEventName);
	}

}
