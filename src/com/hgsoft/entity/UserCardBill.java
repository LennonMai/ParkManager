package com.hgsoft.entity;

import java.sql.Timestamp;

/**
 * TbUserCardBill entity. @author MyEclipse Persistence Tools
 */

@SuppressWarnings("serial")
public class UserCardBill implements java.io.Serializable {

	// Fields

	private Integer userRecNo;//用户编号
	

	private Timestamp opTime;//缴费时间
	private Integer money;//缴费金额
	private Timestamp startTime;//费用起用时间
	private Timestamp endTime;//费用终止时间
	private Integer operator;//操作员
	
	

	

	private Short version;//费率版本号
	private Short rateRecNo;//费率编号
	private Short amount;//缴费数量

	// Constructors

	/** default constructor */
	public UserCardBill() {
	}
	
	public Integer getUserRecNo() {
		return userRecNo;
	}

	public void setUserRecNo(Integer userRecNo) {
		this.userRecNo = userRecNo;
	}

	public Timestamp getOpTime() {
		return opTime;
	}

	public void setOpTime(Timestamp opTime) {
		this.opTime = opTime;
	}
	
	public Integer getMoney() {
		return this.money;
	}

	public void setMoney(Integer money) {
		this.money = money;
	}

	public Timestamp getStartTime() {
		return this.startTime;
	}

	public void setStartTime(Timestamp startTime) {
		this.startTime = startTime;
	}

	public Timestamp getEndTime() {
		return this.endTime;
	}

	public void setEndTime(Timestamp endTime) {
		this.endTime = endTime;
	}

	

	public Short getVersion() {
		return this.version;
	}

	public void setVersion(Short version) {
		this.version = version;
	}

	public Short getRateRecNo() {
		return this.rateRecNo;
	}

	public void setRateRecNo(Short rateRecNo) {
		this.rateRecNo = rateRecNo;
	}

	public Short getAmount() {
		return this.amount;
	}

	public void setAmount(Short amount) {
		this.amount = amount;
	}
	public Integer getOperator() {
		return operator;
	}

	public void setOperator(Integer operator) {
		this.operator = operator;
	}
	

}