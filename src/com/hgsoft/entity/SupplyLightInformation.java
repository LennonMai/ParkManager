package com.hgsoft.entity;

@SuppressWarnings("serial")
public class SupplyLightInformation implements java.io.Serializable {

	private String startTime;// ��ʼʱ�䣬PK����
	private String endTime;// ����ʱ��

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