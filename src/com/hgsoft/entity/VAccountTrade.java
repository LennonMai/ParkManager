package com.hgsoft.entity;

import java.io.Serializable;



public class VAccountTrade implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer seqNo;//��ţ���Ŷ�ÿ���˻���˵����0��ʼ���ϵ�����(PK)
	private Integer tradeType;//��������0: ͨ�зѿ۷� 1:��ֵ2������3:���� 4:����
    private String listNo;//������ˮ��
	private String cardNo;//�ɷѿ���
	private Integer cardType;//������
	private String tradeTime;//����ʱ��
	private Integer fee;//���Ϊ�����Ǯ��Ϊ�����Ǯ
    private Integer balance;//���
    private Integer cardBalance;//�������ĵ�ǰ���
    private String backoutedListNo;//��������¼�Ľ�����ˮ�ţ����������ǳ���ʱ��ֵ������Ϊ��
    private Integer backoutedMark;//������ʶ��Ϊ�˱�ʶ������Ϣ�Ƿ񱻳�������0.�� 1.��
	private Integer parkNo;//С����� ��������=0ʱ������ֵ
    private String vehPlate;//����
	private Integer inGateNo;//��ڴ��ű��
	private String inGateName;//��ڴ�������
	private Integer inLaneNo;//��ڳ������
	private String inOpTime;//���ʱ��
	private Integer gateNo;//���ڴ��ű��
	private String gateName;//���ڴ�������
	private Integer laneNo;//���ڳ������
	private String opTime;//����ʱ��
	private Integer operatorID;//����Ա���
	private String operatorPassword;//����Ա����
	private String verify;//������Ϣ
	private String remark;//��ע
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
