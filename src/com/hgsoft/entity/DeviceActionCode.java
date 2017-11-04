package com.hgsoft.entity;

public class DeviceActionCode implements java.io.Serializable {

	/**
	 * �豸��������
	 */
	private static final long serialVersionUID = 1L;
	private Short deviceActionNo;// �豸�������
	private String deviceActionName;// �豸��������
	private Short deviceNo;// �豸���

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