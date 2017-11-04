package com.hgsoft.entity;

/**
 * Config entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class Config implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
	private String siteName;
	private String propertyName;
	private String company;
	private String copyright;
	private String recordCode;
	private String email;
	private String phone;
	private String mobile;

	// Constructors

	/** default constructor */
	public Config() {
	}

	/** minimal constructor */
	public Config(String siteName) {
		this.siteName = siteName;
	}

	/** full constructor */
	public Config(String siteName, String propertyName, String company,
			String copyright, String recordCode, String email, String phone,
			String mobile) {
		this.siteName = siteName;
		this.propertyName = propertyName;
		this.company = company;
		this.copyright = copyright;
		this.recordCode = recordCode;
		this.email = email;
		this.phone = phone;
		this.mobile = mobile;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getSiteName() {
		return this.siteName;
	}

	public void setSiteName(String siteName) {
		this.siteName = siteName;
	}

	public String getPropertyName() {
		return this.propertyName;
	}

	public void setPropertyName(String propertyName) {
		this.propertyName = propertyName;
	}

	public String getCompany() {
		return this.company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getCopyright() {
		return this.copyright;
	}

	public void setCopyright(String copyright) {
		this.copyright = copyright;
	}

	public String getRecordCode() {
		return this.recordCode;
	}

	public void setRecordCode(String recordCode) {
		this.recordCode = recordCode;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return this.phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getMobile() {
		return this.mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

}