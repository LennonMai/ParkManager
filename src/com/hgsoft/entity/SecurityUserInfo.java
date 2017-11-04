package com.hgsoft.entity;

import java.util.Date;

@SuppressWarnings("serial")
public class SecurityUserInfo implements java.io.Serializable {

	private Integer regId;//注册编号 pk主键
	private String cardNo;//卡表面号
	private String idcardImage;//身份证复印件
	private String callNum;//移动电话号码
	private String password;//密码
	private Short isValid;//失效标志
	private Date regTime;//注册时间

	public SecurityUserInfo() {
	}

	public SecurityUserInfo(String cardNo, String callNum, String password,
			Short isValid, Date regTime) {
		this.cardNo = cardNo;
		this.callNum = callNum;
		this.password = password;
		this.isValid = isValid;
		this.regTime = regTime;
	}

	public SecurityUserInfo(String cardNo, String idcardImage,
			String callNum, String password, Short isValid, Date regTime) {
		this.cardNo = cardNo;
		this.idcardImage = idcardImage;
		this.callNum = callNum;
		this.password = password;
		this.isValid = isValid;
		this.regTime = regTime;
	}


	public Integer getRegId() {
		return this.regId;
	}

	public void setRegId(Integer regId) {
		this.regId = regId;
	}

	public String getCardNo() {
		return this.cardNo;
	}

	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}

	public String getIdcardImage() {
		return this.idcardImage;
	}

	public void setIdcardImage(String idcardImage) {
		this.idcardImage = idcardImage;
	}

	public String getCallNum() {
		return this.callNum;
	}

	public void setCallNum(String callNum) {
		this.callNum = callNum;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Short getIsValid() {
		return this.isValid;
	}

	public void setIsValid(Short isValid) {
		this.isValid = isValid;
	}

	public Date getRegTime() {
		return this.regTime;
	}

	public void setRegTime(Date regTime) {
		this.regTime = regTime;
	}

}