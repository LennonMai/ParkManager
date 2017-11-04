package com.hgsoft.entity;

import java.sql.Timestamp;

/**
 * TbCardOperation entity. @author MyEclipse Persistence Tools
 */

@SuppressWarnings("serial")
public class CardOperation implements java.io.Serializable {

	// Fields

	private String cardNO;
	private Integer cardType;
	private Integer cardOperate;
	private Integer operator;
	private Timestamp OpTime;
	private Short userCardType;
    private String remark;

	// Constructors

	/** default constructor */
	public CardOperation() {
	}


	public Integer getCardType() {
		return this.cardType;
	}

	public void setCardType(Integer cardType) {
		this.cardType = cardType;
	}

	public Integer getCardOperate() {
		return this.cardOperate;
	}

	public void setCardOperate(Integer cardOperate) {
		this.cardOperate = cardOperate;
	}

	public Integer getOperator() {
		return this.operator;
	}

	public void setOperator(Integer operator) {
		this.operator = operator;
	}

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getCardNO() {
		return cardNO;
	}


	public void setCardNO(String cardNO) {
		this.cardNO = cardNO;
	}
	
	public Timestamp getOpTime() {
		return OpTime;
	}


	public void setOpTime(Timestamp opTime) {
		OpTime = opTime;
	}
    
	public Short getUserCardType() {
		return userCardType;
	}


	public void setUserCardType(Short userCardType) {
		this.userCardType = userCardType;
	}




}