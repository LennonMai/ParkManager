package com.hgsoft.entity;

import java.sql.Timestamp;



/**
 * TbCardInfo entity. @author MyEclipse Persistence Tools
 */

@SuppressWarnings("serial")
public class CardInfo implements java.io.Serializable {

	// Fields

	private String cardNo;
	private String cardId;
	private Short cardType;
	private Short status;
	private Timestamp opTime;
	private Short userCardType;

	// Constructors

	/** default constructor */
	public CardInfo() {
	}

	/** full constructor */
	public CardInfo(String cardId, Short cardType, Short status, Timestamp opTime) {
		this.cardId = cardId;
		this.cardType = cardType;
		this.status = status;
		this.opTime = opTime;
	}

	// Property accessors

	public String getCardNo() {
		return this.cardNo;
	}

	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}

	public String getCardId() {
		return this.cardId;
	}

	public void setCardId(String cardId) {
		this.cardId = cardId;
	}

	public Short getCardType() {
		return this.cardType;
	}

	public void setCardType(Short cardType) {
		this.cardType = cardType;
	}

	public Short getStatus() {
		return this.status;
	}

	public void setStatus(Short status) {
		this.status = status;
	}

	public Timestamp getOpTime() {
		return this.opTime;
	}

	public void setOpTime(Timestamp opTime) {
		this.opTime = opTime;
	}
	public Short getUserCardType() {
		return this.userCardType;
	}

	public void setUserCardType(Short userCardType) {
		this.userCardType = userCardType;
	}

}