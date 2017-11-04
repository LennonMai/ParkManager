package com.hgsoft.entity;

import java.util.Date;

public class AccountAgentExportLogTemp
{
	private Date squadDate;	//PK,工班日期
	private String packNo;	//PK,数据包编号
	private Date opTime;	//PK,操作时间
	private String fileName;	//文件名
	private Integer recCount;	//数据记录数
	private Integer totalMoney;	//收费金额总数
	public Date getSquadDate() {
		return squadDate;
	}
	public void setSquadDate(Date squadDate) {
		this.squadDate = squadDate;
	}
	public String getPackNo() {
		return packNo;
	}
	public void setPackNo(String packNo) {
		this.packNo = packNo;
	}
	public Date getOpTime() {
		return opTime;
	}
	public void setOpTime(Date opTime) {
		this.opTime = opTime;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public Integer getRecCount() {
		return recCount;
	}
	public void setRecCount(Integer recCount) {
		this.recCount = recCount;
	}
	public Integer getTotalMoney() {
		return totalMoney;
	}
	public void setTotalMoney(Integer totalMoney) {
		this.totalMoney = totalMoney;
	}
}
