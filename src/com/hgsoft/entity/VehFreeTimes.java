package com.hgsoft.entity;

public class VehFreeTimes implements java.io.Serializable {

	/**
	 * 车辆免费次数
	 */
	private static final long serialVersionUID = 1L;
	private String vehPlate;// 主键，车牌号码
	private Integer year;// 年
	private Integer leftFreeTimes;// 剩余次数

	public VehFreeTimes() {
	}

	public VehFreeTimes(String vehPlate, Integer year, Integer leftFreeTimes) {
		this.vehPlate = vehPlate;
		this.year = year;
		this.leftFreeTimes = leftFreeTimes;
	}

	public String getVehPlate() {
		return this.vehPlate;
	}

	public void setVehPlate(String vehPlate) {
		this.vehPlate = vehPlate;
	}

	public Integer getYear() {
		return this.year;
	}

	public void setYear(Integer year) {
		this.year = year;
	}

	public Integer getLeftFreeTimes() {
		return this.leftFreeTimes;
	}

	public void setLeftFreeTimes(Integer leftFreeTimes) {
		this.leftFreeTimes = leftFreeTimes;
	}

}