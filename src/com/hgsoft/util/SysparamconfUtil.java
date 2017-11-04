package com.hgsoft.util;

import javax.annotation.Resource;
import org.springframework.stereotype.Repository;

import com.hgsoft.entity.Sysparamconf;
import com.hgsoft.service.SysparamconfService;
@Repository
public class SysparamconfUtil {

	@Resource
	private  SysparamconfService sysparamconfService;

	//根据参数名读取系统参数信息
	public String readSysparameter(String pname){	
		return sysparamconfService.readSysparameter(pname);
	}
	
	//根据参数名读取系统参数信息，如果没有则插入默认的一条参数
	public String readSysparameter_NulltoInit(String pname,String pvalue){	
		return sysparamconfService.readSysparameter_NulltoInit(pname,pvalue);
	}

	//向系统写入参数信息
	public boolean writeSysparameter(String pname,String pvalue,String remark){
		return sysparamconfService.writeSysparameter(pname, pvalue, remark);
	}
	
	//向系统写入参数信息根据对象
	public boolean writeSysparameter(Sysparamconf sysparamconf){
		return sysparamconfService.writeSysparameter(sysparamconf);
	}
}