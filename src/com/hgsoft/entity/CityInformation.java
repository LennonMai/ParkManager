package com.hgsoft.entity;
@SuppressWarnings("serial")
public class CityInformation implements java.io.Serializable {


	private Short cityNo;// 城市编码 ，PK主键
	private String cityName;// 城市名
	private String remark;// 备注

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