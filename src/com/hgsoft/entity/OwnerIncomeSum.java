package com.hgsoft.entity;

import java.util.Date;

/**
 * TbOwnerIncomeSum entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class OwnerIncomeSum implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	// Fields
	private Date startTime;	//PK,起始日期时间
	private Date endTime;	//PK,结束日期时间
	private String ownCode;	//PK,业主代码
	private Short ictype;	//PK,粤通卡类型

	private Integer listNo;	//序列号
	private Short areaNo;	//区域编码
	private String ownName;	//业主名称
	private Double income;	//实收金额
	private Double serviceFee;	//服务费
	private Date genDate;	//生成日期时间

	// Constructors

	/** default constructor */
	public OwnerIncomeSum() {
	}

	/** full constructor */
	public OwnerIncomeSum(Date startTime, Date endTime, String ownCode,
			Short ictype, Integer listNo,
			Short areaNo, String ownName, Double income, Double serviceFee,
			Date genDate) {
		this.startTime = startTime;
		this.endTime = endTime;
		this.ownCode = ownCode;
		this.ictype = ictype;
		
		this.listNo = listNo;
		this.areaNo = areaNo;
		this.ownName = ownName;
		this.income = income;
		this.serviceFee = serviceFee;
		this.genDate = genDate;
	}
	
	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof OwnerIncomeSum))
			return false;
		OwnerIncomeSum castOther = (OwnerIncomeSum) other;

		return ((this.getStartTime() == castOther.getStartTime()) || (this
				.getStartTime() != null
				&& castOther.getStartTime() != null && this.getStartTime()
				.equals(castOther.getStartTime())))
				&& ((this.getEndTime() == castOther.getEndTime()) || (this
						.getEndTime() != null
						&& castOther.getEndTime() != null && this.getEndTime()
						.equals(castOther.getEndTime())))
				&& ((this.getOwnCode() == castOther.getOwnCode()) || (this
						.getOwnCode() != null
						&& castOther.getOwnCode() != null && this.getOwnCode()
						.equals(castOther.getOwnCode())))
				&& ((this.getIctype() == castOther.getIctype()) || (this
						.getIctype() != null
						&& castOther.getIctype() != null && this.getIctype()
						.equals(castOther.getIctype())));
	}

	public int hashCode() {
		int result = 17;

		result = 37 * result
				+ (getStartTime() == null ? 0 : this.getStartTime().hashCode());
		result = 37 * result
				+ (getEndTime() == null ? 0 : this.getEndTime().hashCode());
		result = 37 * result
				+ (getOwnCode() == null ? 0 : this.getOwnCode().hashCode());
		result = 37 * result
				+ (getIctype() == null ? 0 : this.getIctype().hashCode());
		return result;
	}

	// Property accessors
	public Date getStartTime() {
		return this.startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public Date getEndTime() {
		return this.endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public String getOwnCode() {
		return this.ownCode;
	}

	public void setOwnCode(String ownCode) {
		this.ownCode = ownCode;
	}

	public Short getIctype() {
		return this.ictype;
	}

	public void setIctype(Short ictype) {
		this.ictype = ictype;
	}

	public Integer getListNo() {
		return this.listNo;
	}

	public void setListNo(Integer listNo) {
		this.listNo = listNo;
	}

	public Short getAreaNo() {
		return this.areaNo;
	}

	public void setAreaNo(Short areaNo) {
		this.areaNo = areaNo;
	}

	public String getOwnName() {
		return this.ownName;
	}

	public void setOwnName(String ownName) {
		this.ownName = ownName;
	}

	public Double getIncome() {
		return this.income;
	}

	public void setIncome(Double income) {
		this.income = income;
	}

	public Double getServiceFee() {
		return this.serviceFee;
	}

	public void setServiceFee(Double serviceFee) {
		this.serviceFee = serviceFee;
	}

	public Date getGenDate() {
		return this.genDate;
	}

	public void setGenDate(Date genDate) {
		this.genDate = genDate;
	}

}