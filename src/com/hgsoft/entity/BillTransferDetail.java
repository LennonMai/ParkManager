package com.hgsoft.entity;

/**
 * TbBillTransferDetail entity. @author MyEclipse Persistence Tools
 */

@SuppressWarnings("serial")
public class BillTransferDetail implements java.io.Serializable {

	// Fields

	private Integer recNo;
	private Integer hankNo;
	private Integer startBillNo;
	private Integer endBillNo;
	private Integer amount;

	// Constructors

	/** default constructor */
	public BillTransferDetail() {
	}

	/** full constructor */
	public Integer getRecNo() {
		return recNo;
	}

	public void setRecNo(Integer recNo) {
		this.recNo = recNo;
	}

	public Integer getHankNo() {
		return hankNo;
	}

	public void setHankNo(Integer hankNo) {
		this.hankNo = hankNo;
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

}