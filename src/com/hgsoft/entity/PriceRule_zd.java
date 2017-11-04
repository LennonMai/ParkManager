package com.hgsoft.entity;

public class PriceRule_zd implements java.io.Serializable {

	/**
	 * zd费率规则
	 */
	private static final long serialVersionUID = 1L;
	private Integer feeRuleType;// 主键，收费类型
	private Integer vehTypeNo;// 主键，车型 1：摩托车 2：小车，3：大中型车
	private Integer feeOfOneCycle;// 一周期（循环时段）收费金额，单位：分，当周期为"0"时，费率没有限制，通常一周期可由用户设置，如果每4小时为或者一天为一周期，然后确定周期收费金额
	private Integer freeTimes;// 免费次数
	private Integer validateTrim;// 白名单车计费时，生效时间是否截断
	private Integer invalidateTrim;// 白名单车计费时，生效时间是否截断
	private Integer maxFreeTimesUsedEveryTimes;//每次使用免费次数,<=0不封顶，=1时，当本次计费有5次过夜，只算一次。若2时至6时在校内停车，每年可免收20次（进出校门为一次）
	private Integer maxTotalFee;//最大收费金额（>=0有效，为空或<0无效），初始化值为空或者-1
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