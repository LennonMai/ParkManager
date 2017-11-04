package com.hgsoft.entity;

import java.sql.Timestamp;

/**
 * TbCardHandOutIn entity. @author MyEclipse Persistence Tools
 */

@SuppressWarnings("serial")
public class CardHandOutIn implements java.io.Serializable {

	// Fields

	private Integer recordNo;
	private Timestamp squadDate;
	private Short squadNo;
	private Short parkNo;
	private Short gateNo;
	private Short laneNo;
	private Short type;
	private Integer amount;
	private String operatorName;
	private Integer operatorNo;
	private String recorderName;
	private Integer recorderNo;
	private Timestamp recordTime;

	// Constructors

	/** default constructor */
	public CardHandOutIn() {
	}

	/** full constructor */
	public CardHandOutIn(Timestamp squadDate, Short squadNo, Short parkNo,
			Short gateNo, Short laneNo, Short type, Integer amount,
			String operatorName, Integer operatorNo, String recorderName,
			Integer recorderNo, Timestamp recordTime) {
		this.squadDate = squadDate;
		this.squadNo = squadNo;
		this.parkNo = parkNo;
		this.gateNo = gateNo;
		this.laneNo = laneNo;
		this.type = type;
		this.amount = amount;
		this.operatorName = operatorName;
		this.operatorNo = operatorNo;
		this.recorderName = recorderName;
		this.recorderNo = recorderNo;
		this.recordTime = recordTime;
	}

	// Property accessors

	public Integer getRecordNo() {
		return this.recordNo;
	}

	public void setRecordNo(Integer recordNo) {
		this.recordNo = recordNo;
	}

	public Timestamp getSquadDate() {
		return this.squadDate;
	}

	public void setSquadDate(Timestamp squadDate) {
		this.squadDate = squadDate;
	}

	public Short getSquadNo() {
		return this.squadNo;
	}

	public void setSquadNo(Short squadNo) {
		this.squadNo = squadNo;
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

	public Short getType() {
		return this.type;
	}

	public void setType(Short type) {
		this.type = type;
	}

	public Integer getAmount() {
		return this.amount;
	}

	public void setAmount(Integer amount) {
		this.amount = amount;
	}

	public String getOperatorName() {
		return this.operatorName;
	}

	public void setOperatorName(String operatorName) {
		this.operatorName = operatorName;
	}

	public Integer getOperatorNo() {
		return this.operatorNo;
	}

	public void setOperatorNo(Integer operatorNo) {
		this.operatorNo = operatorNo;
	}

	public String getRecorderName() {
		return this.recorderName;
	}

	public void setRecorderName(String recorderName) {
		this.recorderName = recorderName;
	}

	public Integer getRecorderNo() {
		return this.recorderNo;
	}

	public void setRecorderNo(Integer recorderNo) {
		this.recorderNo = recorderNo;
	}

	public Timestamp getRecordTime() {
		return this.recordTime;
	}

	public void setRecordTime(Timestamp recordTime) {
		this.recordTime = recordTime;
	}

}