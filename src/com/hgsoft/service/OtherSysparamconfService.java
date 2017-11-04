package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.OtherSysparamconfDao;
import com.hgsoft.entity.Admin;
import com.hgsoft.entity.Sysparamconf;
import com.hgsoft.util.Order;
import com.hgsoft.util.Pager;

@Service
public class OtherSysparamconfService extends OtherBaseService<Sysparamconf> {

	@Autowired
	public void setDao(@Qualifier("otherSysparamconfDao") OtherSysparamconfDao dao) {
		super.setDao(dao);
	}

	private OtherSysparamconfDao getOtherSysparamconfDao() {
		return (OtherSysparamconfDao) this.getDao();
	}

	public List<Sysparamconf> findAll() {
		return getOtherSysparamconfDao().findAll(Order.desc("sys_id"));
	}

	public List<Sysparamconf> findPname(Object sys_id) {
		return getOtherSysparamconfDao().findPname(sys_id);
	}

	public List<Sysparamconf> queryForAll(Pager pager, String name, String value, Integer type, String remark) {

		return getOtherSysparamconfDao().findAllSysparamconfByHql(pager, name, value, type, remark);
	}

	// chenfuyuan
	public Sysparamconf queryOrSave(String pname, String initializePvalue, String sysparamconfRemark, String logData,
			Admin admin) {
		return this.getOtherSysparamconfDao().queryOrSave(pname, initializePvalue, sysparamconfRemark, logData, admin);
	}

	public Sysparamconf getSysparamconfByQname(String pname) {
		return this.getOtherSysparamconfDao().getSysparamconfByQname(pname);
	}

	public List<Sysparamconf> checkPnameByPname(Object pname) {
		return getOtherSysparamconfDao().checkPnameByPname(pname);
	}

	public String readSysparameter(String pname) {
		return getOtherSysparamconfDao().readSysparameter(pname);
	}

	public String readSysparameter_NulltoInit(String pname, String pvalue) {
		return getOtherSysparamconfDao().readSysparameter_NulltoInit(pname, pvalue);
	}

	public boolean writeSysparameter(String pname, String pvalue, String remark) {
		return getOtherSysparamconfDao().writeSysparameter(pname, pvalue, remark);
	}

	public boolean writeSysparameter(Sysparamconf sysparamconf) {
		return getOtherSysparamconfDao().writeSysparameter(sysparamconf);
	}

	public List<Sysparamconf> findSysparamconfByPname(Object pname) {
		return getOtherSysparamconfDao().findSysparamconfByPname(pname);
	}

	public boolean _update(Object sys_id, Sysparamconf sysparamconf) {
		return getOtherSysparamconfDao()._update(sys_id, sysparamconf);
	}

	public void delete(Integer sys_id) {
		if (sys_id != null) {
			if (this.findPname(sys_id) != null) {
				this.deleteById(sys_id);
			}
		}

	}
}
