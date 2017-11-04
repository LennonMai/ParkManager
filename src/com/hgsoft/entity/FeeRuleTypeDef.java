package com.hgsoft.entity;

public class FeeRuleTypeDef implements java.io.Serializable {


	/**
	 * 收费类型
	 *0 －普通校内车
	 *1 －白天校内车 
	 *2 －白天家属车 
	 *3 －夜间校内车 
	 *4 －MBA学员车 
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer feeRuleType;//收费类型
	private String name;//车辆类别名

	public FeeRuleTypeDef() {
	}

	public FeeRuleTypeDef(String name) {
		this.name = name;
	}

	public Integer getFeeRuleType() {
		return this.feeRuleType;
	}

	public void setFeeRuleType(Integer feeRuleType) {
		this.feeRuleType = feeRuleType;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

}