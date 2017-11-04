package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.FunctionKeyDao;
import com.hgsoft.entity.FunctionKey;
import com.hgsoft.util.Pager;

@Service
public class FunctionKeyService extends BaseService<FunctionKey> {

	@Autowired
	public void setDao(@Qualifier("functionKeyDao") FunctionKeyDao dao) {
		super.setDao(dao);
	}

	private FunctionKeyDao getFunctionKeyDao() {
		return (FunctionKeyDao) this.getDao();
	}

	public List<FunctionKey> findByCondition(Pager pager, Short functionNo, String functionName, Short keyCode) {
		return getFunctionKeyDao().findByCondition(pager, functionNo, functionName, keyCode);
	}

}
