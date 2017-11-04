package com.hgsoft.entity;

import java.util.Date;


@SuppressWarnings("serial")
public class CardDynamic implements java.io.Serializable {
	private String cardNo;
	private Short status;//卡状态：11 入口发出，12 出口回收，13 丢卡，14未知（丢失，但数据不足，无法追回），15 坏卡，16 已罚款
	private Date opTime;
	private Short parkNo;
	private Short gateNo;
	private Short laneNo;
	private String vehPlate;
	private Integer operatorNo;
	private String operatorName;
	private Date squadDate;
	private String owner;
	private Short userCardType;
	private Short vehType;
	private Short squadNo;
	private String inListNo;
	private String outListNo;
	private String vehBrand;
	private Short ticketType;
	private String gateName;

	public Short getTicketType() {
		return ticketType;
	}

	public void setTicketType(Short ticketType) {
		this.ticketType = ticketType;
	}

	/** default constructor */
	public CardDynamic() {
	}

	public String getCardNo() {
		return this.cardNo;
	}

	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}

	public Short getStatus() {
		return this.status;
	}

	public void setStatus(Short status) {
		this.status = status;
	}

	public Date getOpTime() {
		return this.opTime;
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
	public String getOwner() {
		return this.owner;
	}

	public void setOwner(String owner) {
		this.owner = owner;
	}

	public Short getUserCardType() {
		return userCardType;
	}

	public void setUserCardType(Short userCardType) {
		this.userCardType = userCardType;
	}

	public Short getVehType() {
		return vehType;
	}

	public void setVehType(Short vehType) {
		this.vehType = vehType;
	}

	public Short getSquadNo() {
		return squadNo;
	}

	public void setSquadNo(Short squadNo) {
		this.squadNo = squadNo;
	}

	public String getInListNo() {
		return inListNo;
	}

	public void setInListNo(String inListNo) {
		this.inListNo = inListNo;
	}

	public String getOutListNo() {
		return outListNo;
	}

	public void setOutListNo(String outListNo) {
		this.outListNo = outListNo;
	}

	public String getVehBrand() {
		return vehBrand;
	}

	public void setVehBrand(String vehBrand) {
		this.vehBrand = vehBrand;
	}

	public String getGateName() {
		return gateName;
	}

	public void setGateName(String gateName) {
		this.gateName = gateName;
	}
}