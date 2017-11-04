package com.hgsoft.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.CardOperationDao;
import com.hgsoft.entity.CardOperation;

@Service
public class CardOperationService extends BaseService<CardOperation> {

	@Autowired
	public void setDao(@Qualifier("cardOperationDao") CardOperationDao dao) {
		super.setDao(dao);
	}

}
