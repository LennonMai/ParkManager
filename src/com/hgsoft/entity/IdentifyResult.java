package com.hgsoft.entity;

/**
 * TbIdentifyResult entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class IdentifyResult implements java.io.Serializable {

	// Fields

	private String listNo;
	private String vehPlate;
	private Short carSize;
	private Integer carClass;
	private Integer carBrand;
	private Short inOutMark;

	// Constructors

	/** default constructor */
	public IdentifyResult() {
	}

	/** full constructor */
	public IdentifyResult(String vehPlate, Short carSize, Integer carClass,
			Integer carBrand, Short inOutMark) {
		this.vehPlate = vehPlate;
		this.carSize = carSize;
		this.carClass = carClass;
		this.carBrand = carBrand;
		this.inOutMark = inOutMark;
	}

	// Property accessors

	public String getListNo() {
		return this.listNo;
	}

	public void setListNo(String listNo) {
		this.listNo = listNo;
	}

	public String getVehPlate() {
		return this.vehPlate;
	}

	public void setVehPlate(String vehPlate) {
		this.vehPlate = vehPlate;
	}

	public Short getCarSize() {
		return this.carSize;
	}

	public void setCarSize(Short carSize) {
		this.carSize = carSize;
	}

	public Integer getCarClass() {
		return this.carClass;
	}

	public void setCarClass(Integer carClass) {
		this.carClass = carClass;
	}

	public Integer getCarBrand() {
		return this.carBrand;
	}

	public void setCarBrand(Integer carBrand) {
		this.carBrand = carBrand;
	}

	public Short getInOutMark() {
		return this.inOutMark;
	}

	public void setInOutMark(Short inOutMark) {
		this.inOutMark = inOutMark;
	}

}