package com.hgsoft.entity;

public class PriceRule_zd implements java.io.Serializable {

	/**
	 * zd���ʹ���
	 */
	private static final long serialVersionUID = 1L;
	private Integer feeRuleType;// �������շ�����
	private Integer vehTypeNo;// ���������� 1��Ħ�г� 2��С����3�������ͳ�
	private Integer feeOfOneCycle;// һ���ڣ�ѭ��ʱ�Σ��շѽ���λ���֣�������Ϊ"0"ʱ������û�����ƣ�ͨ��һ���ڿ����û����ã����ÿ4СʱΪ����һ��Ϊһ���ڣ�Ȼ��ȷ�������շѽ��
	private Integer freeTimes;// ��Ѵ���
	private Integer validateTrim;// ���������Ʒ�ʱ����Чʱ���Ƿ�ض�
	private Integer invalidateTrim;// ���������Ʒ�ʱ����Чʱ���Ƿ�ض�
	private Integer maxFreeTimesUsedEveryTimes;//ÿ��ʹ����Ѵ���,<=0���ⶥ��=1ʱ�������μƷ���5�ι�ҹ��ֻ��һ�Ρ���2ʱ��6ʱ��У��ͣ����ÿ�������20�Σ�����У��Ϊһ�Σ�
	private Integer maxTotalFee;//����շѽ�>=0��Ч��Ϊ�ջ�<0��Ч������ʼ��ֵΪ�ջ���-1
	private String remark;//

	public PriceRule_zd() {
	}

	public PriceRule_zd(Integer feeRuleType, Integer vehTypeNo,
			Integer feeOfOneCycle, Integer freeTimes, Integer validateTrim,
			Integer invalidateTrim,Integer maxFreeTimesUsedEveryTimes, Integer maxTotalFee,String remark) {
		this.feeRuleType = feeRuleType;
		this.vehTypeNo = vehTypeNo;
		this.feeOfOneCycle = feeOfOneCycle;
		this.freeTimes = freeTimes;
		this.validateTrim = validateTrim;
		this.invalidateTrim = invalidateTrim;
		this.maxFreeTimesUsedEveryTimes = maxFreeTimesUsedEveryTimes;
		this.maxTotalFee = maxTotalFee;
		this.remark = remark;
	}

	public Integer getFeeRuleType() {
		return this.feeRuleType;
	}

	public void setFeeRuleType(Integer feeRuleType) {
		this.feeRuleType = feeRuleType;
	}

	public Integer getVehTypeNo() {
		return this.vehTypeNo;
	}

	public void setVehTypeNo(Integer vehTypeNo) {
		this.vehTypeNo = vehTypeNo;
	}

	public Integer getFeeOfOneCycle() {
		return this.feeOfOneCycle;
	}

	public void setFeeOfOneCycle(Integer feeOfOneCycle) {
		this.feeOfOneCycle = feeOfOneCycle;
	}

	public Integer getFreeTimes() {
		return this.freeTimes;
	}

	public void setFreeTimes(Integer freeTimes) {
		this.freeTimes = freeTimes;
	}

	public Integer getValidateTrim() {
		return this.validateTrim;
	}

	public void setValidateTrim(Integer validateTrim) {
		this.validateTrim = validateTrim;
	}

	public Integer getInvalidateTrim() {
		return this.invalidateTrim;
	}

	public void setInvalidateTrim(Integer invalidateTrim) {
		this.invalidateTrim = invalidateTrim;
	}

	public Integer getMaxFreeTimesUsedEveryTimes() {
		return this.maxFreeTimesUsedEveryTimes;
	}

	public void setMaxFreeTimesUsedEveryTimes(Integer maxFreeTimesUsedEveryTimes) {
		this.maxFreeTimesUsedEveryTimes = maxFreeTimesUsedEveryTimes;
	}
	public Integer getMaxTotalFee() {
		return maxTotalFee;
	}

	public void setMaxTotalFee(Integer maxTotalFee) {
		this.maxTotalFee = maxTotalFee;
	}
	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof PriceRule_zd))
			return false;
		PriceRule_zd castOther = (PriceRule_zd) other;

		return ((this.getFeeRuleType() == castOther.getFeeRuleType()) || (this
				.getFeeRuleType() != null && castOther.getFeeRuleType() != null && this
				.getFeeRuleType().equals(castOther.getFeeRuleType())))
				&& ((this.getVehTypeNo() == castOther.getVehTypeNo()) || (this
						.getVehTypeNo() != null
						&& castOther.getVehTypeNo() != null && this
						.getVehTypeNo().equals(castOther.getVehTypeNo())));
	}

	public int hashCode() {
		int result = 17;

		result = 37
				* result
				+ (getFeeRuleType() == null ? 0 : this.getFeeRuleType()
						.hashCode());
		result = 37 * result
				+ (getVehTypeNo() == null ? 0 : this.getVehTypeNo().hashCode());
		return result;
	}

}