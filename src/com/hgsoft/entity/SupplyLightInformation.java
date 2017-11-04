package com.hgsoft.entity;

@SuppressWarnings("serial")
public class SupplyLightInformation implements java.io.Serializable {

	private String startTime;// 开始时间，PK主键
	private String endTime;// 结束时间

	public SupplyLightInformation() {
	}

	public SupplyLightInformation(String startTime, String endTime) {
		this.startTime = startTime;
		this.endTime = endTime;
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

}