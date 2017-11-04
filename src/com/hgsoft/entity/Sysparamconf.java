package com.hgsoft.entity;

import java.io.Serializable;

@SuppressWarnings("serial")
public class Sysparamconf implements Serializable {

	private Integer sys_id;//�������(�Զ�������)
	private String pname;//������
	private String pvalue;//����ֵ
	private Integer ptype;//����
	private String remark;//��ע
	
	public Sysparamconf(){}
	public Sysparamconf(Integer sys_id,String pname,String pvalue,Integer ptype,String remark) {
		this.sys_id=sys_id;
		this.pname=pname;
		this.pvalue=pvalue;
		this.ptype=ptype;
		this.remark=remark;
	}
	
	public Integer getSys_id() {
		return sys_id;
	}
	public void setSys_id(Integer sysId) {
		sys_id = sysId;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public String getPvalue() {
		return pvalue;
	}
	public void setPvalue(String pvalue) {
		this.pvalue = pvalue;
	}
	public Integer getPtype() {
		return ptype;
	}
	public void setPtype(Integer ptype) {
		this.ptype = ptype;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}

}
