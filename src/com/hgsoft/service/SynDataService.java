package com.hgsoft.service;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.SynDataDao;
import com.hgsoft.entity.Sysparamconf;

@Service
public class SynDataService extends BaseService<Sysparamconf> {

	@Resource
	private SysparamconfService sysparamconfService;

	@Autowired
	public void setDao(@Qualifier("synDataDao") SynDataDao dao) {
		super.setDao(dao);
	}

	private SynDataDao getSynDataDao() {
		return (SynDataDao) this.getDao();
	}

	public void synOperator() {
		// TODO Auto-generated method stub
		System.out.println("synOperator");
		getSynDataDao().synOperator();

	}

	public void synWhiteList() {
		// TODO Auto-generated method stub
		System.out.println("synWhiteList");
		getSynDataDao().synWhiteList();
	}

}
