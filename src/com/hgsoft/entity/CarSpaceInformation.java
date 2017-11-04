package com.hgsoft.entity;

import java.util.Date;

@SuppressWarnings("serial")
public class CarSpaceInformation implements java.io.Serializable {


	private Short parkNo ;// parkNo小区编码 ，PK主键
	private String gateNo;//大门编号，大门编号为对应的大门，all代表除了存在的大门编号外的全部
	private Short maxSpace;// 最大车位数
	private Short carCount;// 车辆总数
	private Short criticalNum;// 车位临界值
	private Date modifyTime;// 更新时间

	public CarSpaceInformation() {
	}

	public CarSpaceInformation(Short parkNo,String gateNo,Short maxSpace, Short carCount,
			Short criticalNum, Date modifyTime) {
		this.parkNo = parkNo;
		this.gateNo = gateNo;
		this.maxSpace = maxSpace;
		this.carCount = carCount;
		this.criticalNum = criticalNum;
		this.modifyTime = modifyTime;
	}

	public Short getParkNo() {
		return parkNo;
	}

	public void setParkNo(Short parkNo) {
		this.parkNo = parkNo;
	}



	public Short getMaxSpace() {
		return this.maxSpace;
	}

	public void setMaxSpace(Short maxSpace) {
		this.maxSpace = maxSpace;
	}

	public Short getCarCount() {
		return this.carCount;
	}

	public void setCarCount(Short carCount) {
		this.carCount = carCount;
	}

	public Short getCriticalNum() {
		return this.criticalNum;
	}

	public void setCriticalNum(Short criticalNum) {
		this.criticalNum = criticalNum;
	}

	public Date getModifyTime() {
		return modifyTime;
	}

	public void setModifyTime(Date modifyTime) {
		this.modifyTime = modifyTime;
	}
	public String getGateNo() {
		return gateNo;
	}

	public void setGateNo(String gateNo) {
		this.gateNo = gateNo;
	}

}