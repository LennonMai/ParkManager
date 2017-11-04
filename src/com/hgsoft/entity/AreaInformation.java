package com.hgsoft.entity;

@SuppressWarnings("serial")
public class AreaInformation implements java.io.Serializable {

	private Short areaNo;// ������� ��PK����
	private String areaName;// ��������
	private String areaServerName;// �������������
	private String areaServerIp;// ������IP
	private String areaDomain;// ����
	private String areaDbname;// ���ݿ�����
	private String areaDbuserName;// ���ݿ��û���
	private String areaDbpassword;// ���ݿ�����
//	private CityInformation cityInformation;//�����cityNo���б���
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