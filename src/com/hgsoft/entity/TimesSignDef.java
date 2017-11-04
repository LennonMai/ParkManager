package com.hgsoft.entity;

public class TimesSignDef implements java.io.Serializable {

	/**
	 * 时间标志
	 */
	private static final long serialVersionUID = 1L;
	private Integer feeRuleType;//主键，收费类型
	private Integer dayType;//主键,日类型，初始化为1，表示"正常工作日"，
	private String startTime;//主键，开始时间
	private String endTime;//结束时间
	private Integer timesSign;//时间标志，0-白天车不过夜，1-过夜车
	private String remark;//

	public TimesSignDef() {
	}

	public TimesSignDef(Integer feeRuleType, Integer dayType, String startTime,
			String endTime, Integer timesSign, String remark) {
		this.feeRuleType = feeRuleType;
		this.dayType = dayType;
		this.startTime = startTime;
		this.endTime = endTime;
		this.timesSign = timesSign;
		this.remark = remark;
	}

	public Integer getFeeRuleType() {
		return this.feeRuleType;
	}

	public void setFeeRuleType(Integer feeRuleType) {
		this.feeRuleType = feeRuleType;
	}

	public Integer getDayType() {
		return this.dayType;
	}

	public void setDayType(Integer dayType) {
		this.dayType = dayType;
	}

	public String getStartTime() {
		return this.startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return this.endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public Integer getTimesSign() {
		return this.timesSign;
	}

	public void setTimesSign(Integer timesSign) {
		this.timesSign = timesSign;
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
		if (!(other instanceof TimesSignDef))
			return false;
		TimesSignDef castOther = (TimesSignDef) other;

		return ((this.getFeeRuleType() == castOther.getFeeRuleType()) || (this
				.getFeeRuleType() != null && castOther.getFeeRuleType() != null && this
				.getFeeRuleType().equals(castOther.getFeeRuleType())))
				&& ((this.getDayType() == castOther.getDayType()) || (this
						.getDayType() != null && castOther.getDayType() != null && this
						.getDayType().equals(castOther.getDayType())))
				&& ((this.getStartTime() == castOther.getStartTime()) || (this
						.getStartTime() != null
						&& castOther.getStartTime() != null && this
						.getStartTime().equals(castOther.getStartTime())));
	}

	public int hashCode() {
		int result = 17;

		result = 37
				* result
				+ (getFeeRuleType() == null ? 0 : this.getFeeRuleType()
						.hashCode());
		result = 37 * result
				+ (getDayType() == null ? 0 : this.getDayType().hashCode());
		result = 37 * result
				+ (getStartTime() == null ? 0 : this.getStartTime().hashCode());
		return result;
	}

}