package com.hgsoft.entity;

import java.sql.Timestamp;

/**
 * TbBillStorage entity. @author MyEclipse Persistence Tools
 */

@SuppressWarnings("serial")
public class BillStorage implements java.io.Serializable {

	// Fields

	private Integer hankNo;
	private Short position;
	private Short billType;
	private String billHead;
	private Integer startBillNo;
	private Integer endBillNo;
	private Integer amount;
	private Integer usedBillNo;
	private Integer usedAmount;
	private Timestamp opTime;

	// Constructors

	/** default constructor */
	public BillStorage() {
	}

	/** minimal constructor */
	public BillStorage(Short position, Short billType, String billHead, Integer startBillNo, Integer endBillNo, Integer amount, Integer usedAmount, Timestamp opTime) {
		this.position = position;
		this.billType = billType;
		this.billHead = billHead;
		this.startBillNo = startBillNo;
		this.endBillNo = endBillNo;
		this.amount = amount;
		this.usedAmount = usedAmount;
		this.opTime = opTime;
	}

	/** full constructor */
	public BillStorage(Short position, Short billType, String billHead, Integer startBillNo, Integer endBillNo, Integer amount, Integer usedBillNo, Integer usedAmount, Timestamp opTime) {
		this.position = position;
		this.billType = billType;
		this.billHead = billHead;
		this.startBillNo = startBillNo;
		this.endBillNo = endBillNo;
		this.amount = amount;
		this.usedBillNo = usedBillNo;
		this.usedAmount = usedAmount;
		this.opTime = opTime;
	}

	// Property accessors

	public Integer getHankNo() {
		return this.hankNo;
	}

	public void setHankNo(Integer hankNo) {
		this.hankNo = hankNo;
	}

	public Short getPosition() {
		return this.position;
	}

	public void setPosition(Short position) {
		this.position = position;
	}

	public Short getBillType() {
		return this.billType;
	}

	public void setBillType(Short billType) {
		this.billType = billType;
	}

	public String getBillHead() {
		return this.billHead;
	}

	public void setBillHead(String billHead) {
		this.billHead = billHead;
	}

	public Integer getStartBillNo() {
		return this.startBillNo;
	}

	public void setStartBillNo(Integer startBillNo) {
		this.startBillNo = startBillNo;
	}

	public Integer getEndBillNo() {
		return this.endBillNo;
	}

	public void setEndBillNo(Integer endBillNo) {
		this.endBillNo = endBillNo;
	}

	public Integer getAmount() {
		return this.amount;
	}

	public void setAmount(Integer amount) {
		this.amount = amount;
	}

	public Integer getUsedBillNo() {
		return this.usedBillNo;
	}

	public void setUsedBillNo(Integer usedBillNo) {
		this.usedBillNo = usedBillNo;
	}

	public Integer getUsedAmount() {
		return this.usedAmount;
	}

	public void setUsedAmount(Integer usedAmount) {
		this.usedAmount = usedAmount;
	}

	public Timestamp getOpTime() {
		return this.opTime;
	}

	public void setOpTime(Timestamp opTime) {
		this.opTime = opTime;
	}

}