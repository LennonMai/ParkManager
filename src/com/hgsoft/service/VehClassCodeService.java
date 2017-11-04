package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.VehClassCodeDao;
import com.hgsoft.entity.VehClassCode;
import com.hgsoft.util.Pager;

@Service
public class VehClassCodeService extends BaseService<VehClassCode> {

	@Autowired
	public void setDao(@Qualifier("vehClassCodeDao") VehClassCodeDao dao) {
		super.setDao(dao);
	}

	private VehClassCodeDao getVehClassCodeDao() {
		return (VehClassCodeDao) this.getDao();
	}

	public List<VehClassCode> findByCondition(Pager pager, Short vehClassNo, String vehClassName, Short keyCode) {
		return getVehClassCodeDao().findByCondition(pager, vehClassNo, vehClassName, keyCode);
	}

}
