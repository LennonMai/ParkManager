package com.hgsoft.entity;

import java.io.Serializable;


public class User implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer sys_id;////����ǰ�ʺ�sys_id+1)	
	private String userName;//�û�����
	private Integer credentialsType;//�û���֤������(0.���֤,1.����)
	private String credentialsNo;//�û���֤������
	private String phone;//�û���ϵ�绰
	private String mobileNumber;//�ֻ�����
	private String address;//�û�סַ
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
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
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getMobileNumber() {
		return mobileNumber;
	}
	public void setMobileNumber(String mobileNumber) {
		this.mobileNumber = mobileNumber;
	}
	public Integer getCredentialsType() {
		return credentialsType;
	}
	public void setCredentialsType(Integer credentialsType) {
		this.credentialsType = credentialsType;
	}
	public Integer getSys_id() {
		return sys_id;
	}
	public void setSys_id(Integer sys_id) {
		this.sys_id = sys_id;
	}
	
	
	
	

}
