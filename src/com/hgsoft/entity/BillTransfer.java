package com.hgsoft.entity;

import java.sql.Timestamp;

/**
 * TbBillTransfer entity. @author MyEclipse Persistence Tools
 */

@SuppressWarnings("serial")
public class BillTransfer implements java.io.Serializable {

	// Fields

	private Integer recNo;
	private Short transferType;
	private Integer amount;
	private Short outPosition;
	private Short inPosition;
	private Integer ratifier;
	private Integer transactor;
	private Integer operator;
	private Timestamp opTime;
	private Timestamp squadDate;
	private Integer squadNo;
	private Integer verifier;
	private Timestamp verifyTime;
	private String remark;

	// Constructors

	/** default constructor */
	public BillTransfer() {
	}

	/** minimal constructor */
	public BillTransfer(Short transferType, Integer amount, Short outPosition, Short inPosition, Integer transactor, Integer operator, Timestamp opTime) {
		this.transferType = transferType;
		this.amount = amount;
		this.outPosition = outPosition;
		this.inPosition = inPosition;
		this.transactor = transactor;
		this.operator = operator;
		this.opTime = opTime;
	}

	/** full constructor */
	public BillTransfer(Short transferType, Integer amount, Short outPosition, Short inPosition, Integer ratifier, Integer transactor, Integer operator, Timestamp opTime, Timestamp squadDate, Integer squadNo, Integer verifier, Timestamp verifyTime, String remark) {
		this.transferType = transferType;
		this.amount = amount;
		this.outPosition = outPosition;
		this.inPosition = inPosition;
		this.ratifier = ratifier;
		this.transactor = transactor;
		this.operator = operator;
		this.opTime = opTime;
		this.squadDate = squadDate;
		this.squadNo = squadNo;
		this.verifier = verifier;
		this.verifyTime = verifyTime;
		this.remark = remark;
	}

	// Property accessors

	public Integer getRecNo() {
		return this.recNo;
	}

	public void setRecNo(Integer recNo) {
		this.recNo = recNo;
	}

	public Short getTransferType() {
		return this.transferType;
	}

	public void setTransferType(Short transferType) {
		this.transferType = transferType;
	}

	public Integer getAmount() {
		return this.amount;
	}

	public void setAmount(Integer amount) {
		this.amount = amount;
	}

	public Short getOutPosition() {
		return this.outPosition;
	}

	public void setOutPosition(Short outPosition) {
		this.outPosition = outPosition;
	}

	public Short getInPosition() {
		return this.inPosition;
	}

	public void setInPosition(Short inPosition) {
		this.inPosition = inPosition;
	}

	public Integer getRatifier() {
		return this.ratifier;
	}

	public void setRatifier(Integer ratifier) {
		this.ratifier = ratifier;
	}

	public Integer getTransactor() {
		return this.transactor;
	}

	public void setTransactor(Integer transactor) {
		this.transactor = transactor;
	}

	public Integer getOperator() {
		return this.operator;
	}

	public void setOperator(Integer operator) {
		this.operator = operator;
	}

	public Timestamp getOpTime() {
		return this.opTime;
	}

	public void setOpTime(Timestamp opTime) {
		this.opTime = opTime;
	}

	public Timestamp getSquadDate() {
		return this.squadDate;
	}

	public void setSquadDate(Timestamp squadDate) {
		this.squadDate = squadDate;
	}

	public Integer getSquadNo() {
		return this.squadNo;
	}

	public void setSquadNo(Integer squadNo) {
		this.squadNo = squadNo;
	}

	public Integer getVerifier() {
		return this.verifier;
	}

	public void setVerifier(Integer verifier) {
		this.verifier = verifier;
	}

	public Timestamp getVerifyTime() {
		return this.verifyTime;
	}

	public void setVerifyTime(Timestamp verifyTime) {
		this.verifyTime = verifyTime;
	}

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

}