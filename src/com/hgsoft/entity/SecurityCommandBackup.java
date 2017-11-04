package com.hgsoft.entity;

import java.util.Date;



public class SecurityCommandBackup implements java.io.Serializable {

	private String cardNo;
	private Short type;
	private Short validType;
	private Short useType;
	private Date addTime;
	private String startTime;
	private String endTime;
	private Date opTime;
	private Short status;
	private Short attribute;
	private Short operatorType;
	private Integer operatorNo;
	private Short isValid;
	private Integer CommandId;
	private Integer modId;
	public SecurityCommandBackup() {
	}
	
	public Integer getCommandId() {
		return CommandId;
	}

	public void setCommandId(Integer commandId) {
		CommandId = commandId;
	}

	public Integer getModId() {
		return modId;
	}

	public void setModId(Integer modId) {
		this.modId = modId;
	}

	public String getCardNo() {
		return this.cardNo;
	}

	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}

	public Short getType() {
		return this.type;
	}

	public void setType(Short type) {
		this.type = type;
	}

	public Short getValidType() {
		return this.validType;
	}

	public void setValidType(Short validType) {
		this.validType = validType;
	}

	public Short getUseType() {
		return this.useType;
	}

	public void setUseType(Short useType) {
		this.useType = useType;
	}

	public Date getAddTime() {
		return this.addTime;
	}

	public void setAddTime(Date addTime) {
		this.addTime = addTime;
	}

	public String getStartTime() {
		return this.startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return this.endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public Date getOpTime() {
		return this.opTime;
	}

	public void setOpTime(Date opTime) {
		this.opTime = opTime;
	}

	public Short getStatus() {
		return this.status;
	}

	public void setStatus(Short status) {
		this.status = status;
	}

	public Short getAttribute() {
		return this.attribute;
	}

	public void setAttribute(Short attribute) {
		this.attribute = attribute;
	}

	public Short getOperatorType() {
		return this.operatorType;
	}

	public void setOperatorType(Short operatorType) {
		this.operatorType = operatorType;
	}

	public Integer getOperatorNo() {
		return this.operatorNo;
	}

	public void setOperatorNo(Integer operatorNo) {
		this.operatorNo = operatorNo;
	}

	public Short getIsValid() {
		return this.isValid;
	}

	public void setIsValid(Short isValid) {
		this.isValid = isValid;
	}

}