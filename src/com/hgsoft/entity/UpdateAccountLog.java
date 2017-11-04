package com.hgsoft.entity;

import java.io.Serializable;
import java.util.Date;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;


public class UpdateAccountLog implements Serializable { 
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	//private Integer id;//联合主键id
	private Integer accountNo;//帐号(PK)
	private Integer seqNo;//序号（序号对每个账户来说，从0开始不断递增）(PK)
	private Integer status;//帐号状态（0：有效，1：挂失 2：预销户 3：黑名单 4：其他 除了0外其他都是无效）
    private String cardNo;//缴费卡号
	private Integer cost;//工本费
	private Integer lowestBalanceAfterConsume;//最低余额
	private Integer tollyLowestBalanceAC;//记账最低余额
	private Integer noEntryBalance;//禁止驶入最低余额
	private Integer lowBalanceNotice;//提示用户去续费的最低余额
	private Date openAccountTime;//开户时间
	private Date statusUpdateTime;//状态更新时间
	private String remark;//备注
	private Integer user_id;//用户编号
	private String userName;//用户名称
	private Integer credentialsType;//用户的证件类型(0.身份证，1.其他)
	private String credentialsNo;//用户的证件号码
	private String phone;//用户联系电话
	private String mobileNumber;//手机号码
	private String address;//用户住址
	private Integer car_id;//车辆编号
	private String vehPlate;//车牌号
	private Integer carType;//车辆类型（参照7.22_运营管理系统数据库设计_100722陈富渊.doc中备注）
	private String carColour;//车辆颜色
	private Date updateTime;//更改的时间
	private Integer operator_id;//操作员编号
	private String operatorName;//操作员名称
	private Integer printNumber;
	private String updateRemark;//更改备注
	
	 public Integer getAccountNo() {
		return accountNo;
	}
	public void setAccountNo(Integer accountNo) {
		this.accountNo = accountNo;
	}
	public Integer getSeqNo() {
		return seqNo;
	}
	public void setSeqNo(Integer seqNo) {
		this.seqNo = seqNo;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getCardNo() {
		return cardNo;
	}
	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
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

	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public Integer getCredentialsType() {
		return credentialsType;
	}
	public void setCredentialsType(Integer credentialsType) {
		this.credentialsType = credentialsType;
	}
	public String getCredentialsNo() {
		return credentialsNo;
	}
	public void setCredentialsNo(String credentialsNo) {
		this.credentialsNo = credentialsNo;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getMobileNumber() {
		return mobileNumber;
	}
	public void setMobileNumber(String mobileNumber) {
		this.mobileNumber = mobileNumber;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public Integer getCar_id() {
		return car_id;
	}
	public void setCar_id(Integer car_id) {
		this.car_id = car_id;
	}
	public String getVehPlate() {
		return vehPlate;
	}
	public void setVehPlate(String vehPlate) {
		this.vehPlate = vehPlate;
	}
	public Integer getCarType() {
		return carType;
	}
	public void setCarType(Integer carType) {
		this.carType = carType;
	}
	public String getCarColour() {
		return carColour;
	}
	public void setCarColour(String carColour) {
		this.carColour = carColour;
	}
	public Date getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	public String getOperatorName() {
		return operatorName;
	}
	public void setOperatorName(String operatorName) {
		this.operatorName = operatorName;
	}
	public String getUpdateRemark() {
		return updateRemark;
	}
	public void setUpdateRemark(String updateRemark) {
		this.updateRemark = updateRemark;
	}
	public boolean equals(Object obj) {

	        if(obj == this) {
	            return true;
	        }
	       if(!(obj instanceof UpdateAccountLog)) {
	            return false;
	        }	       
	        UpdateAccountLog updateAccountLog = (UpdateAccountLog) obj;
	        return new EqualsBuilder().append(this.accountNo, updateAccountLog.getAccountNo()).append(this.seqNo, updateAccountLog.getSeqNo()).isEquals();       

	    }
	    public int hashCode() {
	        return new HashCodeBuilder() .append(this.accountNo).append(this.seqNo).toHashCode();
	    }
		
	
		public Integer getUser_id() {
			return user_id;
		}
		public void setUser_id(Integer user_id) {
			this.user_id = user_id;
		}
		public Integer getPrintNumber() {
			return printNumber;
		}
		public void setPrintNumber(Integer printNumber) {
			this.printNumber = printNumber;
		}
		public Integer getOperator_id() {
			return operator_id;
		}
		public void setOperator_id(Integer operatorId) {
			operator_id = operatorId;
		}
		
		
}
