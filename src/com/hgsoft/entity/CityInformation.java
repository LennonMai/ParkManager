package com.hgsoft.entity;
@SuppressWarnings("serial")
public class CityInformation implements java.io.Serializable {


	private Short cityNo;// ���б��� ��PK����
	private String cityName;// ������
	private String remark;// ��ע

	public CityInformation() {}
	public CityInformation(Short cityNo, String cityName, String remark) {
		this.cityNo = cityNo;
		this.cityName = cityName;
		this.remark = remark;
	}
	public Short getCityNo() {
		return cityNo;
	}
	public void setCityNo(Short cityNo) {
		this.cityNo = cityNo;
	}
	public String getCityName() {
		return cityName;
	}
	public void setCityName(String cityName) {
		this.cityName = cityName;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
}