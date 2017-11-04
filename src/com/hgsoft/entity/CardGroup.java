package com.hgsoft.entity;

import java.sql.Timestamp;

/**
 * TbCardGroup entity. @author MyEclipse Persistence Tools
 */

@SuppressWarnings("serial")
public class CardGroup implements java.io.Serializable {

	// Fields

    private Integer recNo;
    private Integer laneGroupNo;
	private String cardNo;
	private String vehPlate;
	private Integer groupNo;
	private Integer firstInOut;
	private Timestamp optime;

	// Constructors

	/** default constructor */
	public CardGroup() {
	}
	public Integer getRecNo() {
		return recNo;
	}

	public void setRecNo(Integer recNo) {
		this.recNo = recNo;
	}


	public Integer getLaneGroupNo() {
		return laneGroupNo;
	}


	public void setLaneGroupNo(Integer laneGroupNo) {
		this.laneGroupNo = laneGroupNo;
	}
	
	public String getCardNo() {
		return this.cardNo;
	}

	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}

	public String getVehPlate() {
		return this.vehPlate;
	}

	public void setVehPlate(String vehPlate) {
		this.vehPlate = vehPlate;
	}

	public Integer getGroupNo() {
		return this.groupNo;
	}

	public void setGroupNo(Integer groupNo) {
		this.groupNo = groupNo;
	}

	public Integer getFirstInOut() {
		return this.firstInOut;
	}

	public void setFirstInOut(Integer firstInOut) {
		this.firstInOut = firstInOut;
	}

	public Timestamp getOptime() {
		return this.optime;
	}

	public void setOptime(Timestamp optime) {
		this.optime = optime;
	}

}