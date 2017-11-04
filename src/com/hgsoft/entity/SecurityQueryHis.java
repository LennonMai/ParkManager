package com.hgsoft.entity;

import java.util.Date;

/**
 * TbSecurityQueryHis entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class SecurityQueryHis implements java.io.Serializable {

	// Fields

	private String queryRcId;
	private String number;
	private Short numberType;
	private Date opTime;
	private Short result;
	private Short resultRemark;
	private Short parkNo;
	private Short gateNo;
	private Short laneNo;
	private Integer operatorNo;
	private String operatorName;
	private Short operatorType;

	// Constructors

	/** default constructor */
	public SecurityQueryHis() {
	}

	/** minimal constructor */
	public SecurityQueryHis(String number, Short numberType, Date opTime,
			Short result, Short resultRemark, Short operatorType) {
		this.number = number;
		this.numberType = numberType;
		this.opTime = opTime;
		this.result = result;
		this.resultRemark = resultRemark;
		this.operatorType = operatorType;
	}

	/** full constructor */
	public SecurityQueryHis(String number, Short numberType, Date opTime,
			Short result, Short resultRemark, Short parkNo, Short gateNo,
			Short laneNo, Integer operatorNo, String operatorName,
			Short operatorType) {
		this.number = number;
		this.numberType = numberType;
		this.opTime = opTime;
		this.result = result;
		this.resultRemark = resultRemark;
		this.parkNo = parkNo;
		this.gateNo = gateNo;
		this.laneNo = laneNo;
		this.operatorNo = operatorNo;
		this.operatorName = operatorName;
		this.operatorType = operatorType;
	}

	// Property accessors

	public String getQueryRcId() {
		return this.queryRcId;
	}

	public void setQueryRcId(String queryRcId) {
		this.queryRcId = queryRcId;
	}

	public String getNumber() {
		return this.number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public Short getNumberType() {
		return this.numberType;
	}

	public void setNumberType(Short numberType) {
		this.numberType = numberType;
	}

	public Date getOpTime() {
		return this.opTime;
	}

	public void setOpTime(Date opTime) {
		this.opTime = opTime;
	}

	public Short getResult() {
		return this.result;
	}

	public void setResult(Short result) {
		this.result = result;
	}

	public Short getResultRemark() {
		return this.resultRemark;
	}

	public void setResultRemark(Short resultRemark) {
		this.resultRemark = resultRemark;
	}

	public Short getParkNo() {
		return this.parkNo;
	}

	public void setParkNo(Short parkNo) {
		this.parkNo = parkNo;
	}

	public Short getGateNo() {
		return this.gateNo;
	}

	public void setGateNo(Short gateNo) {
		this.gateNo = gateNo;
	}

	public Short getLaneNo() {
		return this.laneNo;
	}

	public void setLaneNo(Short laneNo) {
		this.laneNo = laneNo;
	}

	public Integer getOperatorNo() {
		return this.operatorNo;
	}

	public void setOperatorNo(Integer operatorNo) {
		this.operatorNo = operatorNo;
	}

	public String getOperatorName() {
		return this.operatorName;
	}

	public void setOperatorName(String operatorName) {
		this.operatorName = operatorName;
	}

	public Short getOperatorType() {
		return this.operatorType;
	}

	public void setOperatorType(Short operatorType) {
		this.operatorType = operatorType;
	}

}