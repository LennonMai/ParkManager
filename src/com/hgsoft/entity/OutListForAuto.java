package com.hgsoft.entity;

import java.util.Date;


public class OutListForAuto implements java.io.Serializable {


	private String listNo;
	private Short cityNo;
	private Short areaNo;
	private Short parkNo;
	private Short gateNo;
	private Short laneNo;
	private Date opTime;
	private Date squadDate;

	// Constructors

	/** default constructor */
	public OutListForAuto() {
	}

	public String getListNo() {
		return this.listNo;
	}

	public void setListNo(String listNo) {
		this.listNo = listNo;
	}

	public Short getCityNo() {
		return this.cityNo;
	}

	public void setCityNo(Short cityNo) {
		this.cityNo = cityNo;
	}

	public Short getAreaNo() {
		return this.areaNo;
	}

	public void setAreaNo(Short areaNo) {
		this.areaNo = areaNo;
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

	public Date getOpTime() {
		return this.opTime;
	}

	public void setOpTime(Date opTime) {
		this.opTime = opTime;
	}

	public Date getSquadDate() {
		return this.squadDate;
	}

	public void setSquadDate(Date squadDate) {
		this.squadDate = squadDate;
	}

}