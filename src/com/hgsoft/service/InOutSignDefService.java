/**
 * 
 */
package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.InOutSignDefDao;
import com.hgsoft.entity.InOutSignDef;

/**
 * @author qinzuohai
 *
 */
@Service
public class InOutSignDefService extends BaseService<InOutSignDef> {

	@Autowired
	public void setDao(@Qualifier("inOutSignDefDao") InOutSignDefDao dao) {
		super.setDao(dao);
	}

	private InOutSignDefDao getInOutSignDefDao() {
		return (InOutSignDefDao) this.getDao();
	}

	public List<InOutSignDef> ishasInOutSignDef(Object inGateNo, Object outGateNo) {
		return getInOutSignDefDao().ishasInOutSignDef(inGateNo, outGateNo);
	}

	public List<InOutSignDef> LoadInOutSignDef(Object inGateNo, Object outGateNo) {
		return getInOutSignDefDao().LoadInOutSignDef(inGateNo, outGateNo);
	}

	public boolean deleteByCompositeID(Object inGateNo, Object outGateNo) {
		return getInOutSignDefDao().deleteByCompositeID(inGateNo, outGateNo);
	}
}
