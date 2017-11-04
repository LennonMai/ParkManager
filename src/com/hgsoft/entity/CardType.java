package com.hgsoft.entity;

/**
 * TbCardType entity. @author MyEclipse Persistence Tools
 */

public class CardType implements java.io.Serializable {

	// Fields

	private Short cardType;
	private String typeName;
	private Short cardClass;

	// Constructors

	/** default constructor */
	public CardType() {
	}

	/** minimal constructor */
	public CardType(String typeName) {
		this.typeName = typeName;
	}

	/** full constructor */
	public CardType(String typeName, Short cardClass) {
		this.typeName = typeName;
		this.cardClass = cardClass;
	}

	// Property accessors

	public Short getCardType() {
		return this.cardType;
	}

	public void setCardType(Short cardType) {
		this.cardType = cardType;
	}

	public String getTypeName() {
		return this.typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	public Short getCardClass() {
		return this.cardClass;
	}

	public void setCardClass(Short cardClass) {
		this.cardClass = cardClass;
	}

}