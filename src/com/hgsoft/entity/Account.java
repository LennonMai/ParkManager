package com.hgsoft.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.Set;

public class Account implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;


	private Integer sys_id;//�ʺ�(PK)(�Զ�������)
    private Integer status;//�ʺ�״̬��0����Ч��1����ʧ 2��Ԥ���� 3�������� 4������ ����0������������Ч��
//	private Integer user_id;//���û����е�sys_id���Ӧ
//	private Integer car_id;//�복�����е�sys_id���Ӧ
	private String cardNo;//�ɷѿ���
	private Integer cardType;//������	0���ɷѿ�	 5:��ͨ��(��ֵ��/���˿�)
	private Integer parkNo;//С������
	private Integer cost;//������
	private Integer balance;//���
	private Integer lowestBalanceAfterConsume;//������
	private Integer tollyLowestBalanceAC;//����������
	private Integer noEntryBalance;//��ֹʻ��������
	private Integer lowBalanceNotice;//��ʾ�û�ȥ���ѵ�������
	private Date openAccountTime;//����ʱ��
	private Date statusUpdateTime;//״̬����ʱ��
	private String remark;//��ע
	private User user;
	private Car car;
	private Set<AccountTrade> accountTrades;
	public Integer getSys_id() {
		return sys_id;
	}
	public void setSys_id(Integer sysId) {
		sys_id = sysId;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	/*public Integer getUser_id() {
		return user_id;
	}
	public void setUser_id(Integer userId) {
		user_id = userId;
	}*/
	/*public Integer getCar_id() {
		return car_id;
	}
	public void setCar_id(Integer carId) {
		car_id = carId;
	}*/
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
	public Integer getCost() {
		return cost;
	}
	public void setCost(Integer cost) {
		this.cost = cost;
	}
	public Integer getLowestBalanceAfterConsume() {
		return lowestBalanceAfterConsume;
	}
	public void setLowestBalanceAfterConsume(Integer lowestBalanceAfterConsume) {
		this.lowestBalanceAfterConsume = lowestBalanceAfterConsume;
	}
	public Integer getTollyLowestBalanceAC() {
		return tollyLowestBalanceAC;
	}
	public void setTollyLowestBalanceAC(Integer tollyLowestBalanceAC) {
		this.tollyLowestBalanceAC = tollyLowestBalanceAC;
	}
	public Integer getNoEntryBalance() {
		return noEntryBalance;
	}
	public void setNoEntryBalance(Integer noEntryBalance) {
		this.noEntryBalance = noEntryBalance;
	}
	public Integer getLowBalanceNotice() {
		return lowBalanceNotice;
	}
	public void setLowBalanceNotice(Integer lowBalanceNotice) {
		this.lowBalanceNotice = lowBalanceNotice;
	}
	public Date getOpenAccountTime() {
		return openAccountTime;
	}
	public void setOpenAccountTime(Date openAccountTime) {
		this.openAccountTime = openAccountTime;
	}
	public Date getStatusUpdateTime() {
		return statusUpdateTime;
	}
	public void setStatusUpdateTime(Date statusUpdateTime) {
		this.statusUpdateTime = statusUpdateTime;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Car getCar() {
		return car;
	}
	public void setCar(Car car) {
		this.car = car;
	}
	public Set<AccountTrade> getAccountTrades() {
		return accountTrades;
	}
	public void setAccountTrades(Set<AccountTrade> accountTrades) {
		this.accountTrades = accountTrades;
	}
	
	public Integer getBalance() {
		return balance;
	}
	public void setBalance(Integer balance) {
		this.balance = balance;
	}
	public Integer getParkNo() {
		return parkNo;
	}
	public void setParkNo(Integer parkNo) {
		this.parkNo = parkNo;
	}
	


}
