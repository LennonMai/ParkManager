package com.hgsoft.entity;

import java.util.Date;

/**
 * TbSecurityVehPass entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class SecurityVehPass implements java.io.Serializable {

	// Fields

	private String vehPassId;
	private String cardNo;
	private Date passTime;
	private Short isAllowPass;
	private Short allowPassRemark;
	private Short vehPass;
	private Short passRemark;
	private Integer operatorNo;
	private String operatorName;
	private Short parkNo;
	private Short gateNo;
	private Short laneNo;

	// Constructors

	/** default constructor */
	public SecurityVehPass() {
	}

	/** full constructor */
	public SecurityVehPass(String cardNo, Date passTime, Short isAllowPass,
			Short allowPassRemark, Short vehPass, Short passRemark,
			Integer operatorNo, String operatorName, Short parkNo,
			Short gateNo, Short laneNo) {
		this.cardNo = cardNo;
		this.passTime = passTime;
		this.isAllowPass = isAllowPass;
		this.allowPassRemark = allowPassRemark;
		this.vehPass = vehPass;
		this.passRemark = passRemark;
		this.operatorNo = operatorNo;
		this.operatorName = operatorName;
		this.parkNo = parkNo;
		this.gateNo = gateNo;
		this.laneNo = laneNo;
	}

	// Property accessors

	public String getVehPassId() {
		return this.vehPassId;
	}

	public void setVehPassId(String vehPassId) {
		this.vehPassId = vehPassId;
	}

	public String getCardNo() {
		return this.cardNo;
	}

	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}

	public Date getPassTime() {
		return this.passTime;
	}

	public void setPassTime(Date passTime) {
		this.passTime = passTime;
	}

	public Short getIsAllowPass() {
		return this.isAllowPass;
	}

	public void setIsAllowPass(Short isAllowPass) {
		this.isAllowPass = isAllowPass;
	}

	public Short getAllowPassRemark() {
		return this.allowPassRemark;
	}

	public void setAllowPassRemark(Short allowPassRemark) {
		this.allowPassRemark = allowPassRemark;
	}

	public Short getVehPass() {
		return this.vehPass;
	}

	public void setVehPass(Short vehPass) {
		this.vehPass = vehPass;
	}

	public Short getPassRemark() {
		return this.passRemark;
	}

	public void setPassRemark(Short passRemark) {
		this.passRemark = passRemark;
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

}