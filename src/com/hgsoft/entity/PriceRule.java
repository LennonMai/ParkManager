package com.hgsoft.entity;

import java.util.Date;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;

public class PriceRule implements java.io.Serializable {

	/**
	 * （车道）基本费率（华工）
	 */
	private static final long serialVersionUID = 1L;
	private Short parkNo;// 主键,小区编码
	private Short feeTypeNo;// 主键,收费类型
	private Short vehTypeNo;// 主键,车型
	private Integer startRange;// 主键,最小时间
	private Integer endRange;// 最大时间
	private Integer allowStay;// 时间基数（收费基数时间）
	private Integer baseFee;// 收费基数
	private Integer stayAdd;// 时间间隔（分段收费时间间隔）
	private Integer addFee;// 收费增量
	private Integer maxFee;// 最大费率（本时间段）
	private Integer verNo;// 版本号
	private Date startTime;// 启用时间
	private Integer backUp1;// 备用

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