package com.hgsoft.entity;

import java.util.Date;

/**
 * TbAccountAgentImportLog entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class AccountAgentImportLog implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	// Fields
	private String packNo;	//PK,数据包编号
	private Date opTime;	//PK,操作时间

	private String fileName;	//文件名
	private Integer recCount;	//数据记录数
	private String reserved;	//备注

	// Constructors

	/** default constructor */
	public AccountAgentImportLog() {
	}

	/** minimal constructor */
	public AccountAgentImportLog(String packNo, Date opTime, String fileName) {
		this.packNo = packNo;
		this.opTime = opTime;
		
		this.fileName = fileName;
	}

	/** full constructor */
	public AccountAgentImportLog(String packNo, Date opTime,
			String fileName, Integer recCount, String reserved) {
		this.packNo = packNo;
		this.opTime = opTime;
		
		this.fileName = fileName;
		this.recCount = recCount;
		this.reserved = reserved;
	}
	
	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof AccountAgentImportLog))
			return false;
		AccountAgentImportLog castOther = (AccountAgentImportLog) other;

		return ((this.getPackNo() == castOther.getPackNo()) || (this
				.getPackNo() != null
				&& castOther.getPackNo() != null && this.getPackNo().equals(
				castOther.getPackNo())))
				&& ((this.getOpTime() == castOther.getOpTime()) || (this
						.getOpTime() != null
						&& castOther.getOpTime() != null && this.getOpTime()
						.equals(castOther.getOpTime())));
	}

	public int hashCode() {
		int result = 17;

		result = 37 * result
				+ (getPackNo() == null ? 0 : this.getPackNo().hashCode());
		result = 37 * result
				+ (getOpTime() == null ? 0 : this.getOpTime().hashCode());
		return result;
	}

	// Property accessors
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

	public String getReserved() {
		return this.reserved;
	}

	public void setReserved(String reserved) {
		this.reserved = reserved;
	}

}