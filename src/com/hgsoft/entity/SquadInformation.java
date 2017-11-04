package com.hgsoft.entity;

import java.util.Date;

@SuppressWarnings("serial")
public class SquadInformation implements java.io.Serializable {

	private Short squadNo;//������,PK����
	private String squadName;//��������
	private String startTime;//���࿪ʼʱ��
	private String endTime;//�������ʱ��
	private Date startDate;//��Ч����
	private Short timeDiff;//����ƫ��
	private String remark;//����

	public SquadInformation() {
	}

	public SquadInformation(Short squadNo, String squadName, String startTime,
			String endTime, Date startDate, Short timeDiff, String remark) {
		this.squadNo = squadNo;
		this.squadName = squadName;
		this.startTime = startTime;
		this.endTime = endTime;
		this.startDate = startDate;
		this.timeDiff = timeDiff;
		this.remark = remark;
	}

	public Short getSquadNo() {
		return this.squadNo;
	}

	public void setSquadNo(Short squadNo) {
		this.squadNo = squadNo;
	}

	public String getSquadName() {
		return this.squadName;
	}

	public void setSquadName(String squadName) {
		this.squadName = squadName;
	}

	public String getStartTime() {
		return this.startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return this.endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public Short getTimeDiff() {
		return this.timeDiff;
	}

	public void setTimeDiff(Short timeDiff) {
		this.timeDiff = timeDiff;
	}

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

}