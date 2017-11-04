package com.hgsoft.entity;

import java.util.Date;

public class SecurityCommand implements java.io.Serializable {

	private Integer commandId;
	private String cardNo;
	private Short type;
	private Short validType;
	private Short useType;
	private String startTime;
	private String endTime;
	private Date opTime;
	private Short status;
	private Short attribute;
	private Date handleTime;
	private Short operatorType;
	private Integer operatorNo;

	public SecurityCommand() {
	}

	/** minimal constructor */
	public SecurityCommand(String cardNo, Short type, Short validType,
			Short useType, String startTime, String endTime, Date opTime,
			Short status, Short attribute, Short operatorType) {
		this.cardNo = cardNo;
		this.type = type;
		this.validType = validType;
		this.useType = useType;
		this.startTime = startTime;
		this.endTime = endTime;
		this.opTime = opTime;
		this.status = status;
		this.attribute = attribute;
		this.operatorType = operatorType;
	}

	/** full constructor */
	public SecurityCommand(String cardNo, Short type, Short validType,
			Short useType, String startTime, String endTime, Date opTime,
			Short status, Short attribute, Date handleTime, Short operatorType,
			Integer operatorNo) {
		this.cardNo = cardNo;
		this.type = type;
		this.validType = validType;
		this.useType = useType;
		this.startTime = startTime;
		this.endTime = endTime;
		this.opTime = opTime;
		this.status = status;
		this.attribute = attribute;
		this.handleTime = handleTime;
		this.operatorType = operatorType;
		this.operatorNo = operatorNo;
	}

	// Property accessors

	public Integer getCommandId() {
		return this.commandId;
	}

	public void setCommandId(Integer commandId) {
		this.commandId = commandId;
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

	public Date getHandleTime() {
		return this.handleTime;
	}

	public void setHandleTime(Date handleTime) {
		this.handleTime = handleTime;
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
}