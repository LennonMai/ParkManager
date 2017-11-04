package com.hgsoft.entity;

import java.io.Serializable;

public class CarSmallType implements Serializable{

	private static final long serialVersionUID = 1L;
	private Integer carType;
	private Integer carSmallType;
	private String carSmallName;
	
	public Integer getCarType() {
		return carType;
	}
	public void setCarType(Integer carType) {
		this.carType = carType;
	}
	public Integer getCarSmallType() {
		return carSmallType;
	}
	public void setCarSmallType(Integer carSmallType) {
		this.carSmallType = carSmallType;
	}
	public String getCarSmallName() {
		return carSmallName;
	}
	public void setCarSmallName(String carSmallName) {
		this.carSmallName = carSmallName;
	}
	

}
