package com.hgsoft.entity;

import java.util.Date;

@SuppressWarnings("serial")
public class SquadInformation implements java.io.Serializable {

	private Short squadNo;//工班编号,PK主键
	private String squadName;//工班名称
	private String startTime;//工班开始时间
	private String endTime;//工班结束时间
	private Date startDate;//生效日期
	private Short timeDiff;//日期偏移
	private String remark;//描述

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