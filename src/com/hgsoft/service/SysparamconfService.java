package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.SysparamconfDao;
import com.hgsoft.entity.Admin;
import com.hgsoft.entity.Sysparamconf;
import com.hgsoft.util.Order;
import com.hgsoft.util.Pager;

@Service
public class SysparamconfService extends BaseService<Sysparamconf> {

	@Autowired
	public void setDao(@Qualifier("sysparamconfDao") SysparamconfDao dao) {
		super.setDao(dao);
	}

	private SysparamconfDao getSysparamconfDao() {
		return (SysparamconfDao) this.getDao();
	}

	public List<Sysparamconf> findAll() {
		return getSysparamconfDao().findAll(Order.desc("sys_id"));
	}

	public List<Sysparamconf> findPname(Object sys_id) {
		return getSysparamconfDao().findPname(sys_id);
	}

	public List<Sysparamconf> queryForAll(Pager pager, String name, String value, Integer type, String remark) {

		return getSysparamconfDao().findAllSysparamconfByHql(pager, name, value, type, remark);
	}

	// chenfuyuan
	public Sysparamconf queryOrSave(String pname, String initializePvalue, String sysparamconfRemark, String logData,
			Admin admin) {
		return this.getSysparamconfDao().queryOrSave(pname, initializePvalue, sysparamconfRemark, logData, admin);
	}

	public Sysparamconf getSysparamconfByQname(String pname) {
		return this.getSysparamconfDao().getSysparamconfByQname(pname);
	}

	public List<Sysparamconf> checkPnameByPname(Object pname) {
		return getSysparamconfDao().checkPnameByPname(pname);
	}

	public String readSysparameter(String pname) {
		return getSysparamconfDao().readSysparameter(pname);
	}

	public String readSysparameter_NulltoInit(String pname, String pvalue) {
		return getSysparamconfDao().readSysparameter_NulltoInit(pname, pvalue);
	}

	public boolean writeSysparameter(String pname, String pvalue, String remark) {
		return getSysparamconfDao().writeSysparameter(pname, pvalue, remark);
	}

	public boolean writeSysparameter(Sysparamconf sysparamconf) {
		return getSysparamconfDao().writeSysparameter(sysparamconf);
	}

	public List<Sysparamconf> findSysparamconfByPname(Object pname) {
		return getSysparamconfDao().findSysparamconfByPname(pname);
	}

	public boolean _update(Object sys_id, Sysparamconf sysparamconf) {
		return getSysparamconfDao()._update(sys_id, sysparamconf);
	}

	public void delete(Integer sys_id) {
		if (sys_id != null) {
			if (this.findPname(sys_id) != null) {
				this.deleteById(sys_id);
			}
		}

	}
}
