package com.hgsoft.entity;

import java.io.Serializable;
import java.util.Date;



public  class CarSpaceDynamic implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	// Fields

	private Integer recNo;
	private String parkNo;
	private Integer totalSpace;
	private Integer monthlyRentSpace;
	private Integer temporarySpace;
	private Integer currentEmptySpace;
	private Integer outParkTotal;
	private Integer inParkTotal;
	private Integer monthlyRentInPark;
	private Integer monthlyRentOutPark;
	private Integer temporaryInPark;
	private Integer temporaryOutPark;
	private Date modifyTime;
	private Integer backUp1;
	private String backUp2;
	public Integer getRecNo() {
		return recNo;
	}
	public void setRecNo(Integer recNo) {
		this.recNo = recNo;
	}
	public String getParkNo() {
		return parkNo;
	}
	public void setParkNo(String parkNo) {
		this.parkNo = parkNo;
	}
	public Integer getTotalSpace() {
		return totalSpace;
	}
	public void setTotalSpace(Integer totalSpace) {
		this.totalSpace = totalSpace;
	}
	public Integer getMonthlyRentSpace() {
		return monthlyRentSpace;
	}
	public void setMonthlyRentSpace(Integer monthlyRentSpace) {
		this.monthlyRentSpace = monthlyRentSpace;
	}
	public Integer getTemporarySpace() {
		return temporarySpace;
	}
	public void setTemporarySpace(Integer temporarySpace) {
		this.temporarySpace = temporarySpace;
	}
	public Integer getCurrentEmptySpace() {
		return currentEmptySpace;
	}
	public void setCurrentEmptySpace(Integer currentEmptySpace) {
		this.currentEmptySpace = currentEmptySpace;
	}
	public Integer getOutParkTotal() {
		return outParkTotal;
	}
	public void setOutParkTotal(Integer outParkTotal) {
		this.outParkTotal = outParkTotal;
	}
	public Integer getInParkTotal() {
		return inParkTotal;
	}
	public void setInParkTotal(Integer inParkTotal) {
		this.inParkTotal = inParkTotal;
	}
	public Integer getMonthlyRentInPark() {
		return monthlyRentInPark;
	}
	public void setMonthlyRentInPark(Integer monthlyRentInPark) {
		this.monthlyRentInPark = monthlyRentInPark;
	}
	public Integer getMonthlyRentOutPark() {
		return monthlyRentOutPark;
	}
	public void setMonthlyRentOutPark(Integer monthlyRentOutPark) {
		this.monthlyRentOutPark = monthlyRentOutPark;
	}
	public Integer getTemporaryInPark() {
		return temporaryInPark;
	}
	public void setTemporaryInPark(Integer temporaryInPark) {
		this.temporaryInPark = temporaryInPark;
	}
	public Integer getTemporaryOutPark() {
		return temporaryOutPark;
	}
	public void setTemporaryOutPark(Integer temporaryOutPark) {
		this.temporaryOutPark = temporaryOutPark;
	}
	public Date getModifyTime() {
		return modifyTime;
	}
	public void setModifyTime(Date modifyTime) {
		this.modifyTime = modifyTime;
	}
	public Integer getBackUp1() {
		return backUp1;
	}
	public void setBackUp1(Integer backUp1) {
		this.backUp1 = backUp1;
	}
	public String getBackUp2() {
		return backUp2;
	}
	public void setBackUp2(String backUp2) {
		this.backUp2 = backUp2;
	}



}