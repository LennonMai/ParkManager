package com.hgsoft.entity;

@SuppressWarnings("serial")
public class AreaInformation implements java.io.Serializable {

	private Short areaNo;// 区域编码 ，PK主键
	private String areaName;// 区域名称
	private String areaServerName;// 区域服务器名称
	private String areaServerIp;// 服务器IP
	private String areaDomain;// 域名
	private String areaDbname;// 数据库名称
	private String areaDbuserName;// 数据库用户名
	private String areaDbpassword;// 数据库密码
//	private CityInformation cityInformation;//外键，cityNo城市编码
	private Short cityNo;

	public AreaInformation() {

	}

	public AreaInformation(Short areaNo, String areaName,
			String areaServerName, String areaServerIp, String areaDomain,
			String areaDbname, String areaDbuserName, String areaDbpassword,
			Short cityNo) {
		this.areaNo = areaNo;
		this.areaName = areaName;
		this.areaServerName = areaServerName;
		this.areaServerIp = areaServerIp;
		this.areaDomain = areaDomain;
		this.areaDbname = areaDbname;
		this.areaDbuserName = areaDbuserName;
		this.areaDbpassword = areaDbpassword;
		this.cityNo = cityNo;
	}

	public Short getAreaNo() {
		return areaNo;
	}

	public void setAreaNo(Short areaNo) {
		this.areaNo = areaNo;
	}

	public String getAreaName() {
		return areaName;
	}

	public void setAreaName(String areaName) {
		this.areaName = areaName;
	}

	public String getAreaServerName() {
		return areaServerName;
	}

	public void setAreaServerName(String areaServerName) {
		this.areaServerName = areaServerName;
	}

	public String getAreaServerIp() {
		return areaServerIp;
	}

	public void setAreaServerIp(String areaServerIp) {
		this.areaServerIp = areaServerIp;
	}

	public String getAreaDomain() {
		return areaDomain;
	}

	public void setAreaDomain(String areaDomain) {
		this.areaDomain = areaDomain;
	}

	public String getAreaDbname() {
		return areaDbname;
	}

	public void setAreaDbname(String areaDbname) {
		this.areaDbname = areaDbname;
	}

	public String getAreaDbuserName() {
		return areaDbuserName;
	}

	public void setAreaDbuserName(String areaDbuserName) {
		this.areaDbuserName = areaDbuserName;
	}

	public String getAreaDbpassword() {
		return areaDbpassword;
	}

	public void setAreaDbpassword(String areaDbpassword) {
		this.areaDbpassword = areaDbpassword;
	}

	public Short getCityNo() {
		return cityNo;
	}

	public void setCityNo(Short cityNo) {
		this.cityNo = cityNo;
	}

}