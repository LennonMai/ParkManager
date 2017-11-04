package com.hgsoft.entity;

import java.io.Serializable;
import java.util.Date;

@SuppressWarnings("serial")
public class UnitollIntfUpload  implements Serializable{
	private Date squadDate;
	private Integer isUpload;
	private int recCount;
	private int totalMoney;
	private Date opTime;

	public UnitollIntfUpload() {
	}

	public Date getSquadDate() {
		return squadDate;
	}

	public void setSquadDate(Date squadDate) {
		this.squadDate = squadDate;
	}

	public Integer getIsUpload() {
		return isUpload;
	}

	public void setIsUpload(Integer isUpload) {
		this.isUpload = isUpload;
	}

	public int getRecCount() {
		return recCount;
	}

	public void setRecCount(int recCount) {
		this.recCount = recCount;
	}

	public int getTotalMoney() {
		return totalMoney;
	}

	public void setTotalMoney(int totalMoney) {
		this.totalMoney = totalMoney;
	}

	public Date getOpTime() {
		return opTime;
	}

	public void setOpTime(Date opTime) {
		this.opTime = opTime;
	}

}
