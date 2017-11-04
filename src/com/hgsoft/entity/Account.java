package com.hgsoft.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.Set;

public class Account implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;


	private Integer sys_id;//帐号(PK)(自动增长型)
    private Integer status;//帐号状态（0：有效，1：挂失 2：预销户 3：黑名单 4：其他 除了0外其他都是无效）
//	private Integer user_id;//与用户表中的sys_id相对应
//	private Integer car_id;//与车辆表中的sys_id相对应
	private String cardNo;//缴费卡号
	private Integer cardType;//卡类型	0：缴费卡	 5:粤通卡(储值卡/记账卡)
	private Integer parkNo;//小区编码
	private Integer cost;//工本费
	private Integer balance;//余额
	private Integer lowestBalanceAfterConsume;//最低余额
	private Integer tollyLowestBalanceAC;//记账最低余额
	private Integer noEntryBalance;//禁止驶入最低余额
	private Integer lowBalanceNotice;//提示用户去续费的最低余额
	private Date openAccountTime;//开户时间
	private Date statusUpdateTime;//状态更新时间
	private String remark;//备注
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
