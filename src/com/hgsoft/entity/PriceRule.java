package com.hgsoft.entity;

import java.util.Date;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;

public class PriceRule implements java.io.Serializable {

	/**
	 * ���������������ʣ�������
	 */
	private static final long serialVersionUID = 1L;
	private Short parkNo;// ����,С������
	private Short feeTypeNo;// ����,�շ�����
	private Short vehTypeNo;// ����,����
	private Integer startRange;// ����,��Сʱ��
	private Integer endRange;// ���ʱ��
	private Integer allowStay;// ʱ��������շѻ���ʱ�䣩
	private Integer baseFee;// �շѻ���
	private Integer stayAdd;// ʱ�������ֶ��շ�ʱ������
	private Integer addFee;// �շ�����
	private Integer maxFee;// �����ʣ���ʱ��Σ�
	private Integer verNo;// �汾��
	private Date startTime;// ����ʱ��
	private Integer backUp1;// ����

	/** default constructor */
	public PriceRule() {
	}

	/** full constructor */
	public PriceRule(Short parkNo, Short feeTypeNo, Short vehTypeNo,
			Integer startRange, Integer endRange, Integer allowStay,
			Integer baseFee, Integer stayAdd, Integer addFee, Integer maxFee,
			Integer verNo, Date startTime, Integer backUp1) {
		this.parkNo = parkNo;
		this.feeTypeNo = feeTypeNo;
		this.vehTypeNo = vehTypeNo;
		this.startRange = startRange;
		this.endRange = endRange;
		this.allowStay = allowStay;
		this.baseFee = baseFee;
		this.stayAdd = stayAdd;
		this.addFee = addFee;
		this.maxFee = maxFee;
		this.verNo = verNo;
		this.startTime = startTime;
		this.backUp1 = backUp1;
	}

	public Short getParkNo() {
		return this.parkNo;
	}

	public void setParkNo(Short parkNo) {
		this.parkNo = parkNo;
	}

	public Short getFeeTypeNo() {
		return this.feeTypeNo;
	}

	public void setFeeTypeNo(Short feeTypeNo) {
		this.feeTypeNo = feeTypeNo;
	}

	public Short getVehTypeNo() {
		return this.vehTypeNo;
	}

	public void setVehTypeNo(Short vehTypeNo) {
		this.vehTypeNo = vehTypeNo;
	}

	public Integer getStartRange() {
		return this.startRange;
	}

	public void setStartRange(Integer startRange) {
		this.startRange = startRange;
	}

	public Integer getEndRange() {
		return this.endRange;
	}

	public void setEndRange(Integer endRange) {
		this.endRange = endRange;
	}

	public Integer getAllowStay() {
		return this.allowStay;
	}

	public void setAllowStay(Integer allowStay) {
		this.allowStay = allowStay;
	}

	public Integer getBaseFee() {
		return this.baseFee;
	}

	public void setBaseFee(Integer baseFee) {
		this.baseFee = baseFee;
	}

	public Integer getStayAdd() {
		return this.stayAdd;
	}

	public void setStayAdd(Integer stayAdd) {
		this.stayAdd = stayAdd;
	}

	public Integer getAddFee() {
		return this.addFee;
	}

	public void setAddFee(Integer addFee) {
		this.addFee = addFee;
	}

	public Integer getMaxFee() {
		return this.maxFee;
	}

	public void setMaxFee(Integer maxFee) {
		this.maxFee = maxFee;
	}

	public Integer getVerNo() {
		return this.verNo;
	}

	public void setVerNo(Integer verNo) {
		this.verNo = verNo;
	}

	public Date getStartTime() {
		return this.startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public Integer getBackUp1() {
		return this.backUp1;
	}

	public void setBackUp1(Integer backUp1) {
		this.backUp1 = backUp1;
	}

	public boolean equals(Object obj) {
		if (obj == this) {
			return true;
		}

		if (!(obj instanceof PriceRule)) {
			return false;
		}
		PriceRule priceRule = (PriceRule) obj;

		return new EqualsBuilder().append(this.parkNo, priceRule.getParkNo())
				.append(this.feeTypeNo, priceRule.getFeeTypeNo())
				.append(this.vehTypeNo, priceRule.getVehTypeNo())
				.append(this.startRange, priceRule.getStartRange()).isEquals();

	}

	public int hashCode() {
		return new HashCodeBuilder().append(this.parkNo).append(this.feeTypeNo)
				.append(this.vehTypeNo).append(this.startRange).toHashCode();
	}

}