package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.VehTypeCodeDao;
import com.hgsoft.entity.VehTypeCode;
import com.hgsoft.util.Pager;

@Service
public class VehTypeCodeService extends BaseService<VehTypeCode> {

	@Autowired
	public void setDao(@Qualifier("vehTypeCodeDao") VehTypeCodeDao dao) {
		super.setDao(dao);
	}

	private VehTypeCodeDao getVehTypeCodeDao() {
		return (VehTypeCodeDao) this.getDao();
	}

	public List<VehTypeCode> findByCondition(Pager pager, Short vehTypeNo, String vehTypeName, Short keyCode) {
		return getVehTypeCodeDao().findByCondition(pager, vehTypeNo, vehTypeName, keyCode);
	}

}
