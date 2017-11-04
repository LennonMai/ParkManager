package com.hgsoft.entity;

import java.util.Date;

@SuppressWarnings("serial")
public class SecurityUserInfo implements java.io.Serializable {

	private Integer regId;//ע���� pk����
	private String cardNo;//�������
	private String idcardImage;//���֤��ӡ��
	private String callNum;//�ƶ��绰����
	private String password;//����
	private Short isValid;//ʧЧ��־
	private Date regTime;//ע��ʱ��

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