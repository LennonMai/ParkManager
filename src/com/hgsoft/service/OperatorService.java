package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.OperatorDao;
import com.hgsoft.entity.Operator;

/**
 * ����ԱService
 *
 */

@Service
public class OperatorService extends BaseService<Operator> {

	@Autowired
	public void setDao(@Qualifier("operatorDao") OperatorDao dao) {
		super.setDao(dao);
	}

	private OperatorDao getOperatorDao() {
		return (OperatorDao) this.getDao();
	}

	// ȡ���в���Ա
	public List<Operator> getAllOperator() {
		return getOperatorDao().getAllOperator();
	}
}
