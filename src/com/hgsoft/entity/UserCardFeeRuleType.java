package com.hgsoft.entity;

/**
 * TbUserCardFeeRuleType entity. @author MyEclipse Persistence Tools
 */

public class UserCardFeeRuleType implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Short userCardType;
	private Integer feeRuleType;
	private String typeName;
	// Constructors

	public String getTypeName() {
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	/** default constructor */
	public UserCardFeeRuleType() {
	}

	/** full constructor */
	public UserCardFeeRuleType(Integer feeRuleType) {
		this.feeRuleType = feeRuleType;
	}

	// Property accessors

	public Short getUserCardType() {
		return this.userCardType;
	}

	public void setUserCardType(Short userCardType) {
		this.userCardType = userCardType;
	}

	public Integer getFeeRuleType() {
		return this.feeRuleType;
	}

	public void setFeeRuleType(Integer feeRuleType) {
		this.feeRuleType = feeRuleType;
	}

}