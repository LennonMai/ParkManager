package com.hgsoft.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.UnitollIntfUploadDao;
import com.hgsoft.entity.UnitollIntfUpload;
import com.hgsoft.util.Pager;

@Service
public class UnitollIntfUploadService extends BaseService<UnitollIntfUpload> {

	@Autowired
	public void setDao(@Qualifier("unitollIntfUploadDao") UnitollIntfUploadDao dao) {
		super.setDao(dao);
	}

	private UnitollIntfUploadDao getUnitollIntfUploadDao() {
		return (UnitollIntfUploadDao) this.getDao();
	}

	public List<UnitollIntfUpload> findUnitollIntfUploadByHql(Pager pager, String startTime, String endTime,
			UnitollIntfUpload unitollIntfUpload) {
		return getUnitollIntfUploadDao().findUnitollIntfUploadByHql(pager, startTime, endTime, unitollIntfUpload);
	}

	public List<Object[]> export(String fileds, Map map) {
		return getUnitollIntfUploadDao().export(fileds, map);
	}
}
