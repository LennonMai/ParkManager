package com.hgsoft.entity;

import java.util.Date;

public class PassCardBlackList implements java.io.Serializable {

	/**
	 * ͨ�п�������
	 */
	private static final long serialVersionUID = 1L;
	private String cardNo;// ����������
	private Date opTime;// ʧЧ����
	private Short inValidTypeNo;// ʧЧԭ��

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