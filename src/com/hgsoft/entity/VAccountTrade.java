package com.hgsoft.entity;

import java.io.Serializable;



public class VAccountTrade implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer seqNo;//序号（序号对每个账户来说，从0开始不断递增）(PK)
	private Integer tradeType;//交易类型0: 通行费扣费 1:充值2：冲正3:销户 4:其他
    private String listNo;//交易流水号
	private String cardNo;//缴费卡号
	private Integer cardType;//卡类型
	private String tradeTime;//交易时间
	private Integer fee;//金额为正则加钱，为负则减钱
    private Integer balance;//余额
    private Integer cardBalance;//关联卡的当前余额
    private String backoutedListNo;//被冲正记录的交易流水号，交易类型是冲正时有值，其他为空
    private Integer backoutedMark;//冲正标识，为了标识这条信息是否被冲正过（0.是 1.否）
	private Integer parkNo;//小区编号 交易类型=0时可能有值
    private String vehPlate;//车牌
	private Integer inGateNo;//入口大门编号
	private String inGateName;//入口大门名称
	private Integer inLaneNo;//入口车道编号
	private String inOpTime;//入口时间
	private Integer gateNo;//出口大门编号
	private String gateName;//出口大门名称
	private Integer laneNo;//出口车道编号
	private String opTime;//出口时间
	private Integer operatorID;//操作员编号
	private String operatorPassword;//操作员密码
	private String verify;//交易信息
	private String remark;//备注
	private Account account;
	public Integer getSeqNo() {
		return seqNo;
	}
	public void setSeqNo(Integer seqNo) {
		this.seqNo = seqNo;
	}
	public Integer getTradeType() {
		return tradeType;
	}
	public void setTradeType(Integer tradeType) {
		this.tradeType = tradeType;
	}
	public String getListNo() {
		return listNo;
	}
	public void setListNo(String listNo) {
		this.listNo = listNo;
	}
	public String getCardNo() {
		return cardNo;
	}
	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}
	public Integer getCardType() {
		return cardType;
	}
	public void setCardType(Integer cardType) {
		this.cardType = cardType;
	}
	public String getTradeTime() {
		return tradeTime;
	}
	public void setTradeTime(String tradeTime) {
		this.tradeTime = tradeTime;
	}
	public Integer getFee() {
		return fee;
	}
	public void setFee(Integer fee) {
		this.fee = fee;
	}
	public Integer getBalance() {
		return balance;
	}
	public void setBalance(Integer balance) {
		this.balance = balance;
	}
	public Integer getCardBalance() {
		return cardBalance;
	}
	public void setCardBalance(Integer cardBalance) {
		this.cardBalance = cardBalance;
	}
	public String getBackoutedListNo() {
		return backoutedListNo;
	}
	public void setBackoutedListNo(String backoutedListNo) {
		this.backoutedListNo = backoutedListNo;
	}
	public Integer getBackoutedMark() {
		return backoutedMark;
	}
	public void setBackoutedMark(Integer backoutedMark) {
		this.backoutedMark = backoutedMark;
	}
	public Integer getParkNo() {
		return parkNo;
	}
	public void setParkNo(Integer parkNo) {
		this.parkNo = parkNo;
	}
	public String getVehPlate() {
		return vehPlate;
	}
	public void setVehPlate(String vehPlate) {
		this.vehPlate = vehPlate;
	}
	public Integer getInGateNo() {
		return inGateNo;
	}
	public void setInGateNo(Integer inGateNo) {
		this.inGateNo = inGateNo;
	}
	public String getInGateName() {
		return inGateName;
	}
	public void setInGateName(String inGateName) {
		this.inGateName = inGateName;
	}
	public Integer getInLaneNo() {
		return inLaneNo;
	}
	public void setInLaneNo(Integer inLaneNo) {
		this.inLaneNo = inLaneNo;
	}
	public String getInOpTime() {
		return inOpTime;
	}
	public void setInOpTime(String inOpTime) {
		this.inOpTime = inOpTime;
	}
	public Integer getGateNo() {
		return gateNo;
	}
	public void setGateNo(Integer gateNo) {
		this.gateNo = gateNo;
	}
	public String getGateName() {
		return gateName;
	}
	public void setGateName(String gateName) {
		this.gateName = gateName;
	}
	public Integer getLaneNo() {
		return laneNo;
	}
	public void setLaneNo(Integer laneNo) {
		this.laneNo = laneNo;
	}
	public String getOpTime() {
		return opTime;
	}
	public void setOpTime(String opTime) {
		this.opTime = opTime;
	}
	public Integer getOperatorID() {
		return operatorID;
	}
	public void setOperatorID(Integer operatorID) {
		this.operatorID = operatorID;
	}
	public String getOperatorPassword() {
		return operatorPassword;
	}
	public void setOperatorPassword(String operatorPassword) {
		this.operatorPassword = operatorPassword;
	}
	public String getVerify() {
		return verify;
	}
	public void setVerify(String verify) {
		this.verify = verify;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Account getAccount() {
		return account;
	}
	public void setAccount(Account account) {
		this.account = account;
	}

}
