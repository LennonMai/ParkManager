package com.hgsoft.entity;

import java.io.Serializable;
import java.util.Date;

public class ICCardTransfer implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer recNO;
	private Integer transferType;//0.车道之间、1.入库、2.出库
	private Integer amount;
    private Integer outPosition;
    private Integer inPosition;
    private Integer transactor ;  
	private Integer operator;
    private Date opTime;
    private Date squadDate;
    private Integer squadNO;
    private Integer verifier;
    private Date verifyTime;
    private String remark;
    public Integer getRecNO() {
		return recNO;
	}
	public void setRecNO(Integer recNO) {
		this.recNO = recNO;
	}
	public Integer getTransferType() {
		return transferType;
	}
	public void setTransferType(Integer transferType) {
		this.transferType = transferType;
	}
	public Integer getAmount() {
		return amount;
	}
	public void setAmount(Integer amount) {
		this.amount = amount;
	}
	public Integer getOutPosition() {
		return outPosition;
	}
	public void setOutPosition(Integer outPosition) {
		this.outPosition = outPosition;
	}
	public Integer getInPosition() {
		return inPosition;
	}
	public void setInPosition(Integer inPosition) {
		this.inPosition = inPosition;
	}
	public Integer getTransactor() {
		return transactor;
	}
	public void setTransactor(Integer transactor) {
		this.transactor = transactor;
	}
	public Integer getOperator() {
		return operator;
	}
	public void setOperator(Integer operator) {
		this.operator = operator;
	}
	public Date getOpTime() {
		return opTime;
	}
	public void setOpTime(Date opTime) {
		this.opTime = opTime;
	}
	public Date getSquadDate() {
		return squadDate;
	}
	public void setSquadDate(Date squadDate) {
		this.squadDate = squadDate;
	}
	public Integer getSquadNO() {
		return squadNO;
	}
	public void setSquadNO(Integer squadNO) {
		this.squadNO = squadNO;
	}
	public Integer getVerifier() {
		return verifier;
	}
	public void setVerifier(Integer verifier) {
		this.verifier = verifier;
	}
	public Date getVerifyTime() {
		return verifyTime;
	}
	public void setVerifyTime(Date verifyTime) {
		this.verifyTime = verifyTime;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
    
    
}
