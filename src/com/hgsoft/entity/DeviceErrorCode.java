package com.hgsoft.entity;

public class DeviceErrorCode implements java.io.Serializable {

	/**
	 * 设备错误编码
	 */
	private static final long serialVersionUID = 1L;

	private Short deviceErrorNo;// PK 设备动作编号
	private String deviceErrorName;// 设备动作名称
	private Short deviceNo;// 设备编号

	public DeviceErrorCode() {
	}

	public DeviceErrorCode(Short deviceErrorNo, String deviceErrorName,
			Short deviceNo) {
		this.deviceErrorNo = deviceErrorNo;
		this.deviceErrorName = deviceErrorName;
		this.deviceNo = deviceNo;
	}

	public Short getDeviceErrorNo() {
		return this.deviceErrorNo;
	}

	public void setDeviceErrorNo(Short deviceErrorNo) {
		this.deviceErrorNo = deviceErrorNo;
	}

	public String getDeviceErrorName() {
		return this.deviceErrorName;
	}

	public void setDeviceErrorName(String deviceErrorName) {
		this.deviceErrorName = deviceErrorName;
	}

	public Short getDeviceNo() {
		return this.deviceNo;
	}

	public void setDeviceNo(Short deviceNo) {
		this.deviceNo = deviceNo;
	}

}