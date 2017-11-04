package com.hgsoft.entity;

import java.util.Date;

/**
 * TbAccountAgentExportLog entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class AccountAgentExportLog implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	// Fields
	private Date squadDate;	//PK,工班日期
	private String packNo;	//PK,数据包编号
	private Date opTime;	//PK,操作时间

	private String fileName;	//文件名
	private Integer recCount;	//数据记录数
	private Integer totalMoney;	//收费金额总数

	// Constructors

	/** default constructor */
	public AccountAgentExportLog() {
	}

	/** minimal constructor */
	public AccountAgentExportLog(Date squadDate, String packNo, Date opTime, String fileName) {
		this.squadDate = squadDate;
		this.packNo = packNo;
		this.opTime = opTime;
		
		this.fileName = fileName;
	}

	/** full constructor */
	public AccountAgentExportLog(Date squadDate, String packNo, Date opTime,
			String fileName, Integer recCount, Integer totalMoney) {
		this.squadDate = squadDate;
		this.packNo = packNo;
		this.opTime = opTime;
		
		this.fileName = fileName;
		this.recCount = recCount;
		this.totalMoney = totalMoney;
	}
	
	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof AccountAgentExportLog))
			return false;
		AccountAgentExportLog castOther = (AccountAgentExportLog) other;

		return ((this.getSquadDate() == castOther.getSquadDate()) || (this
				.getSquadDate() != null
				&& castOther.getSquadDate() != null && this.getSquadDate()
				.equals(castOther.getSquadDate())))
				&& ((this.getPackNo() == castOther.getPackNo()) || (this
						.getPackNo() != null
						&& castOther.getPackNo() != null && this.getPackNo()
						.equals(castOther.getPackNo())))
				&& ((this.getOpTime() == castOther.getOpTime()) || (this
						.getOpTime() != null
						&& castOther.getOpTime() != null && this.getOpTime()
						.equals(castOther.getOpTime())));
	}

	public int hashCode() {
		int result = 17;

		result = 37 * result
				+ (getSquadDate() == null ? 0 : this.getSquadDate().hashCode());
		result = 37 * result
				+ (getPackNo() == null ? 0 : this.getPackNo().hashCode());
		result = 37 * result
				+ (getOpTime() == null ? 0 : this.getOpTime().hashCode());
		return result;
	}

	// Property accessors
	public Date getSquadDate() {
		return this.squadDate;
	}

	public void setSquadDate(Date squadDate) {
		this.squadDate = squadDate;
	}

	public String getPackNo() {
		return this.packNo;
	}

	public void setPackNo(String packNo) {
		this.packNo = packNo;
	}

	public Date getOpTime() {
		return this.opTime;
	}

	public void setOpTime(Date opTime) {
		this.opTime = opTime;
	}
	
	public String getFileName() {
		return this.fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public Integer getRecCount() {
		return this.recCount;
	}

	public void setRecCount(Integer recCount) {
		this.recCount = recCount;
	}

	public Integer getTotalMoney() {
		return this.totalMoney;
	}

	public void setTotalMoney(Integer totalMoney) {
		this.totalMoney = totalMoney;
	}

}