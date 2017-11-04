package com.hgsoft.entity;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;

public class UserCardRate implements java.io.Serializable {

	/**
	 * ���⿨����
	 */
	private static final long serialVersionUID = 1L;
	private Short version;// ����,�汾��
	private Short recNo;// ����,���ʱ�ţ���¼�ţ�
	private Short userCardType;// �û�������
	private Short year;// ��
	private Short month;//��
	private Short day;// ��
	private Integer money;// ���
	private String versionAndRecNo;

	

	/** default constructor */
	public UserCardRate() {
	}

	/** full constructor */
	public UserCardRate(Short version, Short recNo, Short userCardType,
			Short year, Short month, Short day, Integer money) {
		this.version = version;
		this.recNo = recNo;
		this.userCardType = userCardType;
		this.year = year;
		this.month = month;
		this.day = day;
		this.money = money;
	}

	public Short getVersion() {
		return this.version;
	}

	public void setVersion(Short version) {
		this.version = version;
	}

	public Short getRecNo() {
		return this.recNo;
	}

	public void setRecNo(Short recNo) {
		this.recNo = recNo;
	}

	public Short getUserCardType() {
		return this.userCardType;
	}

	public void setUserCardType(Short userCardType) {
		this.userCardType = userCardType;
	}

	public Short getYear() {
		return this.year;
	}

	public void setYear(Short year) {
		this.year = year;
	}

	public Short getMonth() {
		return this.month;
	}

	public void setMonth(Short month) {
		this.month = month;
	}

	public Short getDay() {
		return this.day;
	}

	public void setDay(Short day) {
		this.day = day;
	}

	public Integer getMoney() {
		return this.money;
	}

	public void setMoney(Integer money) {
		this.money = money;
	}
	public String getVersionAndRecNo() {
		return versionAndRecNo;
	}

	public void setVersionAndRecNo(String versionAndRecNo) {
		this.versionAndRecNo = versionAndRecNo;
	}

	public boolean equals(Object obj) {
		if (obj == this) {
			return true;
		}

		if (!(obj instanceof PriceRule)) {
			return false;
		}
		UserCardRate userCardRate = (UserCardRate) obj;

		return new EqualsBuilder()
				.append(this.version, userCardRate.getVersion())
				.append(this.recNo, userCardRate.getRecNo()).isEquals();

	}

	public int hashCode() {
		return new HashCodeBuilder().append(this.version).append(this.recNo)
				.toHashCode();
	}

}