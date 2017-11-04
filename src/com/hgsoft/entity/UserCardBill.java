package com.hgsoft.entity;

import java.sql.Timestamp;

/**
 * TbUserCardBill entity. @author MyEclipse Persistence Tools
 */

@SuppressWarnings("serial")
public class UserCardBill implements java.io.Serializable {

	// Fields

	private Integer userRecNo;//�û����
	

	private Timestamp opTime;//�ɷ�ʱ��
	private Integer money;//�ɷѽ��
	private Timestamp startTime;//��������ʱ��
	private Timestamp endTime;//������ֹʱ��
	private Integer operator;//����Ա
	
	

	

	private Short version;//���ʰ汾��
	private Short rateRecNo;//���ʱ��
	private Short amount;//�ɷ�����

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