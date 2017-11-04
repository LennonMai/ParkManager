package com.hgsoft.entity;

public class CarType implements java.io.Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer carType;
	private String carTypeName;
	public CarType(){};
	public CarType(Integer carType,String carTypeName){
		this.carType = carType;
		this.carTypeName= carTypeName;
	}
	public Integer getCarType() {
		return carType;
	}
	public void setCarType(Integer carType) {
		this.carType = carType;
	}
	public String getCarTypeName() {
		return carTypeName;
	}
	public void setCarTypeName(String carTypeName) {
		this.carTypeName = carTypeName;
	}
	
}
