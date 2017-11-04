package com.hgsoft.util;

import javax.annotation.Resource;
import org.springframework.stereotype.Repository;

import com.hgsoft.entity.Sysparamconf;
import com.hgsoft.service.SysparamconfService;
@Repository
public class SysparamconfUtil {

	@Resource
	private  SysparamconfService sysparamconfService;

	//���ݲ�������ȡϵͳ������Ϣ
	public String readSysparameter(String pname){	
		return sysparamconfService.readSysparameter(pname);
	}
	
	//���ݲ�������ȡϵͳ������Ϣ�����û�������Ĭ�ϵ�һ������
	public String readSysparameter_NulltoInit(String pname,String pvalue){	
		return sysparamconfService.readSysparameter_NulltoInit(pname,pvalue);
	}

	//��ϵͳд�������Ϣ
	public boolean writeSysparameter(String pname,String pvalue,String remark){
		return sysparamconfService.writeSysparameter(pname, pvalue, remark);
	}
	
	//��ϵͳд�������Ϣ���ݶ���
	public boolean writeSysparameter(Sysparamconf sysparamconf){
		return sysparamconfService.writeSysparameter(sysparamconf);
	}
}