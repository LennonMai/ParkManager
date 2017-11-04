package com.hgsoft.entity;

public class DeviceActionCode implements java.io.Serializable {

	/**
	 * 设备动作编码
	 */
	private static final long serialVersionUID = 1L;
	private Short deviceActionNo;// 设备动作编号
	private String deviceActionName;// 设备动作名称
	private Short deviceNo;// 设备编号

	public DeviceActionCode() {
	}

	public DeviceActionCode(Short deviceActionNo, String deviceActionName,
			Short deviceNo) {
		this.deviceActionNo = deviceActionNo;
		this.deviceActionName = deviceActionName;
		this.deviceNo = deviceNo;
	}

	public Short getDeviceActionNo() {
		return this.deviceActionNo;
	}

	public void setDeviceActionNo(Short deviceActionNo) {
		this.deviceActionNo = deviceActionNo;
	}

	public String getDeviceActionName() {
		return this.deviceActionName;
	}

	public void setDeviceActionName(String deviceActionName) {
		this.deviceActionName = deviceActionName;
	}

	public Short getDeviceNo() {
		return this.deviceNo;
	}

	public void setDeviceNo(Short deviceNo) {
		this.deviceNo = deviceNo;
	}

}