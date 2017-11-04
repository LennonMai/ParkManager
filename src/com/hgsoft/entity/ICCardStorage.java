package com.hgsoft.entity;

import java.io.Serializable;
import java.util.Date;



@SuppressWarnings("serial")
public class ICCardStorage implements Serializable{
	private Integer amount;
	//private GatewayInformation gatewayInformation;	
	private Integer position;	
	private Date opTime;
	public Integer getAmount() {
		return amount;
	}
	public void setAmount(Integer amount) {
		this.amount = amount;
	}
	public Date getOpTime() {
		return opTime;
	}
	public void setOpTime(Date opTime) {
		this.opTime = opTime;
	}
	public Integer getPosition() {
		return position;
	}
	public void setPosition(Integer position) {
		this.position = position;
	}
	
	

}
