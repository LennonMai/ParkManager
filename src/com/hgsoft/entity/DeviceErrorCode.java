package com.hgsoft.entity;

public class DeviceErrorCode implements java.io.Serializable {

	/**
	 * �豸�������
	 */
	private static final long serialVersionUID = 1L;

	private Short deviceErrorNo;// PK �豸�������
	private String deviceErrorName;// �豸��������
	private Short deviceNo;// �豸���

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