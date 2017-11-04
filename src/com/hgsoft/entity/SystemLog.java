package com.hgsoft.entity;

import java.io.Serializable;
import java.util.Date;

public class SystemLog implements Serializable {
	/**
	 * 
	 */
	//private static final long serialVersionUID = 1L;
	private Integer sys_id;//ϵͳ��־��¼��(PK)
	private Date logTime;//��־ʱ��
	private Integer logType;//��־���ͣ�0-��¼�ǳ���1-�û�������2-�쳣���� ; 3-ִ����Ѳ���; 
	private Integer operatorID;
	

	private String logData;//��־��������
	private String coverage;//��־Ӱ�췶Χ�����ݿ�������ֶΡ�sql���ȣ�
	private String remark;//��ע

	public Integer getSys_id() {
		return sys_id;
	}
	public void setSys_id(Integer sys_id) {
		this.sys_id = sys_id;
	}
	public Date getLogTime() {
		return logTime;
	}
	public void setLogTime(Date logTime) {
		this.logTime = logTime;
	}
	public Integer getLogType() {
		return logType;
	}
	public void setLogType(Integer logType) {
		this.logType = logType;
	}
	public String getLogData() {
		return logData;
	}
	public void setLogData(String logData) {
		this.logData = logData;
	}
	public String getCoverage() {
		return coverage;
	}
	public void setCoverage(String coverage) {
		this.coverage = coverage;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Integer getOperatorID() {
		return operatorID;
	}
	public void setOperatorID(Integer operatorID) {
		this.operatorID = operatorID;
	}

	//��־�����ַ���
	public String getLogTypeString(){
		if(this.logType==0) return "��¼�ǳ�";
		else if(this.logType==1) return "����";
		else if(this.logType==2) return "�쳣����";
		else return "";
	}
}
