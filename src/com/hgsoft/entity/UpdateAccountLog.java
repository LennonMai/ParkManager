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
	//private Integer id;//��������id
	private Integer accountNo;//�ʺ�(PK)
	private Integer seqNo;//��ţ���Ŷ�ÿ���˻���˵����0��ʼ���ϵ�����(PK)
	private Integer status;//�ʺ�״̬��0����Ч��1����ʧ 2��Ԥ���� 3�������� 4������ ����0������������Ч��
    private String cardNo;//�ɷѿ���
	private Integer cost;//������
	private Integer lowestBalanceAfterConsume;//������
	private Integer tollyLowestBalanceAC;//����������
	private Integer noEntryBalance;//��ֹʻ��������
	private Integer lowBalanceNotice;//��ʾ�û�ȥ���ѵ�������
	private Date openAccountTime;//����ʱ��
	private Date statusUpdateTime;//״̬����ʱ��
	private String remark;//��ע
	private Integer user_id;//�û����
	private String userName;//�û�����
	private Integer credentialsType;//�û���֤������(0.���֤��1.����)
	private String credentialsNo;//�û���֤������
	private String phone;//�û���ϵ�绰
	private String mobileNumber;//�ֻ�����
	private String address;//�û�סַ
	private Integer car_id;//�������
	private String vehPlate;//���ƺ�
	private Integer carType;//�������ͣ�����7.22_��Ӫ����ϵͳ���ݿ����_100722�¸�Ԩ.doc�б�ע��
	private String carColour;//������ɫ
	private Date updateTime;//���ĵ�ʱ��
	private Integer operator_id;//����Ա���
	private String operatorName;//����Ա����
	private Integer printNumber;
	private String updateRemark;//���ı�ע
	
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
