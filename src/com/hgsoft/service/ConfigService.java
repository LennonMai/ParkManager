package com.hgsoft.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.ConfigDao;
import com.hgsoft.entity.Config;

@Service
public class ConfigService extends BaseService<Config> {

	@Autowired
	public void setDao(@Qualifier("configDao") ConfigDao dao) {
		super.setDao(dao);
	}

}
