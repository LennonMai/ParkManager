package com.hgsoft.entity;

import java.sql.Timestamp;

/**
 * TbCardGroupInfo entity. @author MyEclipse Persistence Tools
 */

@SuppressWarnings("serial")
public class CardGroupInfo implements java.io.Serializable {

	// Fields
	private Integer groupNo;
	private Integer laneGroupNo;
	private String groupName;
	private Integer parkSum;
	private Integer parkRemant;
	private Timestamp optime;

	// Constructors

	/** default constructor */
	public CardGroupInfo() {
	}

	/** minimal constructor */
	
	public Integer getGroupNo() {
		return groupNo;
	}

	public void setGroupNo(Integer groupNo) {
		this.groupNo = groupNo;
	}


	public String getGroupName() {
		return this.groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public Integer getParkSum() {
		return this.parkSum;
	}

	public void setParkSum(Integer parkSum) {
		this.parkSum = parkSum;
	}

	public Integer getParkRemant() {
		return this.parkRemant;
	}

	public void setParkRemant(Integer parkRemant) {
		this.parkRemant = parkRemant;
	}

	public Timestamp getOptime() {
		return this.optime;
	}

	public void setOptime(Timestamp optime) {
		this.optime = optime;
	}
	public Integer getLaneGroupNo() {
		return laneGroupNo;
	}

	public void setLaneGroupNo(Integer laneGroupNo) {
		this.laneGroupNo = laneGroupNo;
	}

}