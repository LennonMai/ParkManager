package com.hgsoft.entity;

/**
 * TbUserCardType entity. @author MyEclipse Persistence Tools
 */

public class UserCardType implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Short userCardType;
	private String typeName;
	private String remark;

	// Constructors

	/** default constructor */
	public UserCardType() {
	}

	/** minimal constructor */
	public UserCardType(String typeName) {
		this.typeName = typeName;
	}

	/** full constructor */
	public UserCardType(String typeName, String remark) {
		this.typeName = typeName;
		this.remark = remark;
	}

	// Property accessors

	public Short getUserCardType() {
		return this.userCardType;
	}

	public void setUserCardType(Short userCardType) {
		this.userCardType = userCardType;
	}

	public String getTypeName() {
		return this.typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

}