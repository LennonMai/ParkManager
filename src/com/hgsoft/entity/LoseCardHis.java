package com.hgsoft.entity;

import java.util.Date;

/**
 * TbLoseCardHis entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class LoseCardHis implements java.io.Serializable {

	// Fields

	private String cardNo;
    private Date opTime;
	private Short parkNo;
	private Short gateNo;
	private Short laneNo;
	private String vehPlate;
	private Integer operatorNo;
	private String operatorName;
	private Date squadDate;
	private String listNo;
	private String owner;
	private String outListNo;
	private Short outParkNo;
	private Short outGateNo;
	private Short outLaneNo;
	private Date outOpTime;
	private Date outSquadDate;
	private String outRemark;
	private Integer outOperatorNo;
	private String outOperatorName;
	private Short cardStatus;

	
	public LoseCardHis() {
	}
	
	public String getCardNo() {
		return cardNo;
	}

	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}

	public Date getOpTime() {
		return opTime;
	}

	public void setOpTime(Date opTime) {
		this.opTime = opTime;
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

	public String getVehPlate() {
		return this.vehPlate;
	}

	public void setVehPlate(String vehPlate) {
		this.vehPlate = vehPlate;
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

	public Date getSquadDate() {
		return this.squadDate;
	}

	public void setSquadDate(Date squadDate) {
		this.squadDate = squadDate;
	}

	public String getListNo() {
		return this.listNo;
	}

	public void setListNo(String listNo) {
		this.listNo = listNo;
	}

	public String getOwner() {
		return this.owner;
	}

	public void setOwner(String owner) {
		this.owner = owner;
	}

	public String getOutListNo() {
		return this.outListNo;
	}

	public void setOutListNo(String outListNo) {
		this.outListNo = outListNo;
	}

	public Short getOutParkNo() {
		return this.outParkNo;
	}

	public void setOutParkNo(Short outParkNo) {
		this.outParkNo = outParkNo;
	}

	public Short getOutGateNo() {
		return this.outGateNo;
	}

	public void setOutGateNo(Short outGateNo) {
		this.outGateNo = outGateNo;
	}

	public Short getOutLaneNo() {
		return this.outLaneNo;
	}

	public void setOutLaneNo(Short outLaneNo) {
		this.outLaneNo = outLaneNo;
	}

	public Date getOutOpTime() {
		return this.outOpTime;
	}

	public void setOutOpTime(Date outOpTime) {
		this.outOpTime = outOpTime;
	}

	public Date getOutSquadDate() {
		return this.outSquadDate;
	}

	public void setOutSquadDate(Date outSquadDate) {
		this.outSquadDate = outSquadDate;
	}

	public String getOutRemark() {
		return this.outRemark;
	}

	public void setOutRemark(String outRemark) {
		this.outRemark = outRemark;
	}

	public Integer getOutOperatorNo() {
		return this.outOperatorNo;
	}

	public void setOutOperatorNo(Integer outOperatorNo) {
		this.outOperatorNo = outOperatorNo;
	}

	public String getOutOperatorName() {
		return this.outOperatorName;
	}

	public void setOutOperatorName(String outOperatorName) {
		this.outOperatorName = outOperatorName;
	}

	public Short getCardStatus() {
		return this.cardStatus;
	}

	public void setCardStatus(Short cardStatus) {
		this.cardStatus = cardStatus;
	}

}