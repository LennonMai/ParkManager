package com.hgsoft.entity;

public class FeeRuleTypeDef implements java.io.Serializable {


	/**
	 * �շ�����
	 *0 ����ͨУ�ڳ�
	 *1 ������У�ڳ� 
	 *2 ����������� 
	 *3 ��ҹ��У�ڳ� 
	 *4 ��MBAѧԱ�� 
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer feeRuleType;//�շ�����
	private String name;//���������

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