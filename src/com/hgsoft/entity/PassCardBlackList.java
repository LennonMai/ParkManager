package com.hgsoft.entity;

import java.util.Date;

public class PassCardBlackList implements java.io.Serializable {

	/**
	 * 通行卡黑名单
	 */
	private static final long serialVersionUID = 1L;
	private String cardNo;// 主键，卡号
	private Date opTime;// 失效日期
	private Short inValidTypeNo;// 失效原因

	public PassCardBlackList() {
	}

	public PassCardBlackList(String cardNo, Date opTime, Short inValidTypeNo) {
		this.cardNo = cardNo;
		this.opTime = opTime;
		this.inValidTypeNo = inValidTypeNo;
	}

	public String getCardNo() {
		return this.cardNo;
	}

	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}

	public Date getOpTime() {
		return this.opTime;
	}

	public void setOpTime(Date opTime) {
		this.opTime = opTime;
	}

	public Short getInValidTypeNo() {
		return this.inValidTypeNo;
	}

	public void setInValidTypeNo(Short inValidTypeNo) {
		this.inValidTypeNo = inValidTypeNo;
	}

}