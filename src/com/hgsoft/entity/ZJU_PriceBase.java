package com.hgsoft.entity;

import java.util.Date;

public class ZJU_PriceBase implements java.io.Serializable {

	/**
	 * ZJU��������
	 */
	private static final long serialVersionUID = 1L;
	
	private Integer verNo;//���������ʰ汾
	private Integer feeNo;//���������ʱ��
	private Integer rebateType;//�������Ż�����,��ʼ��ֵΪ0����ʾ���Ż�
	private Integer inOutSign;//�����������ڱ�־
	private Integer timesSign;//������ʱ��α�־
	private Integer vehTypeNo;//����������1��Ħ�г� 2��С����3�������ͳ�
	private Integer allowStayTime;//����ͣ��ʱ�䣨���ӣ�
	private Integer baseFeeTime;//�׶�ͣ��ʱ��
	private Integer baseFee;//�׶��շѽ��
	private Integer stayAdd;//��λ�շ�ʱ�䣨���ӣ�
	private Integer addFee;//��λ�շѽ��֣�
	private Integer addStart;//��λ����ʱ��
	private Integer maxFee;//����շѽ��֣�
	private Integer maxTime;//���ͣ��ʱ��
	private Integer maxFeeTime;//ÿ���Ʒ���������շ�ʱ��
	private Integer sumFeeCtr;//������ʿ���
	private String backup1;//����1,�ɿ�
	private String backup2;//����2,�ɿ�
	private Date startTime;//����ʱ��
	private String remark;//��ע,�ɿ�

	public ZJU_PriceBase() {
	}

	public ZJU_PriceBase(Integer verNo, Integer feeNo, Integer rebateType,
			Integer inOutSign, Integer timesSign, Integer vehTypeNo,
			Integer allowStayTime, Integer baseFeeTime, Integer baseFee,
			Integer stayAdd, Integer addFee, Integer addStart, Integer maxFee,
			Integer maxTime, Integer maxFeeTime, Integer sumFeeCtr,
			String backup1, String backup2, Date startTime, String remark) {
		this.verNo = verNo;
		this.feeNo = feeNo;
		this.rebateType = rebateType;
		this.inOutSign = inOutSign;
		this.timesSign = timesSign;
		this.vehTypeNo = vehTypeNo;
		this.allowStayTime = allowStayTime;
		this.baseFeeTime = baseFeeTime;
		this.baseFee = baseFee;
		this.stayAdd = stayAdd;
		this.addFee = addFee;
		this.addStart = addStart;
		this.maxFee = maxFee;
		this.maxTime = maxTime;
		this.maxFeeTime = maxFeeTime;
		this.sumFeeCtr = sumFeeCtr;
		this.backup1 = backup1;
		this.backup2 = backup2;
		this.startTime = startTime;
		this.remark = remark;
	}

	public Integer getVerNo() {
		return this.verNo;
	}

	public void setVerNo(Integer verNo) {
		this.verNo = verNo;
	}

	public Integer getFeeNo() {
		return this.feeNo;
	}

	public void setFeeNo(Integer feeNo) {
		this.feeNo = feeNo;
	}

	public Integer getRebateType() {
		return this.rebateType;
	}

	public void setRebateType(Integer rebateType) {
		this.rebateType = rebateType;
	}

	public Integer getInOutSign() {
		return this.inOutSign;
	}

	public void setInOutSign(Integer inOutSign) {
		this.inOutSign = inOutSign;
	}

	public Integer getTimesSign() {
		return this.timesSign;
	}

	public void setTimesSign(Integer timesSign) {
		this.timesSign = timesSign;
	}

	public Integer getVehTypeNo() {
		return this.vehTypeNo;
	}

	public void setVehTypeNo(Integer vehTypeNo) {
		this.vehTypeNo = vehTypeNo;
	}

	public Integer getAllowStayTime() {
		return this.allowStayTime;
	}

	public void setAllowStayTime(Integer allowStayTime) {
		this.allowStayTime = allowStayTime;
	}

	public Integer getBaseFeeTime() {
		return this.baseFeeTime;
	}

	public void setBaseFeeTime(Integer baseFeeTime) {
		this.baseFeeTime = baseFeeTime;
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

	public Integer getAddStart() {
		return this.addStart;
	}

	public void setAddStart(Integer addStart) {
		this.addStart = addStart;
	}

	public Integer getMaxFee() {
		return this.maxFee;
	}

	public void setMaxFee(Integer maxFee) {
		this.maxFee = maxFee;
	}

	public Integer getMaxTime() {
		return this.maxTime;
	}

	public void setMaxTime(Integer maxTime) {
		this.maxTime = maxTime;
	}

	public Integer getMaxFeeTime() {
		return this.maxFeeTime;
	}

	public void setMaxFeeTime(Integer maxFeeTime) {
		this.maxFeeTime = maxFeeTime;
	}

	public Integer getSumFeeCtr() {
		return this.sumFeeCtr;
	}

	public void setSumFeeCtr(Integer sumFeeCtr) {
		this.sumFeeCtr = sumFeeCtr;
	}

	public String getBackup1() {
		return this.backup1;
	}

	public void setBackup1(String backup1) {
		this.backup1 = backup1;
	}

	public String getBackup2() {
		return this.backup2;
	}

	public void setBackup2(String backup2) {
		this.backup2 = backup2;
	}

	public Date getStartTime() {
		return this.startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
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
		if (!(other instanceof ZJU_PriceBase))
			return false;
		ZJU_PriceBase castOther = (ZJU_PriceBase) other;

		return ((this.getVerNo() == castOther.getVerNo()) || (this.getVerNo() != null
				&& castOther.getVerNo() != null && this.getVerNo().equals(
				castOther.getVerNo())))
				&& ((this.getFeeNo() == castOther.getFeeNo()) || (this
						.getFeeNo() != null && castOther.getFeeNo() != null && this
						.getFeeNo().equals(castOther.getFeeNo())))
				&& ((this.getRebateType() == castOther.getRebateType()) || (this
						.getRebateType() != null
						&& castOther.getRebateType() != null && this
						.getRebateType().equals(castOther.getRebateType())))
				&& ((this.getInOutSign() == castOther.getInOutSign()) || (this
						.getInOutSign() != null
						&& castOther.getInOutSign() != null && this
						.getInOutSign().equals(castOther.getInOutSign())))
				&& ((this.getTimesSign() == castOther.getTimesSign()) || (this
						.getTimesSign() != null
						&& castOther.getTimesSign() != null && this
						.getTimesSign().equals(castOther.getTimesSign())))
				&& ((this.getVehTypeNo() == castOther.getVehTypeNo()) || (this
						.getVehTypeNo() != null
						&& castOther.getVehTypeNo() != null && this
						.getVehTypeNo().equals(castOther.getVehTypeNo())));
	}

	public int hashCode() {
		int result = 17;

		result = 37 * result
				+ (getVerNo() == null ? 0 : this.getVerNo().hashCode());
		result = 37 * result
				+ (getFeeNo() == null ? 0 : this.getFeeNo().hashCode());
		result = 37
				* result
				+ (getRebateType() == null ? 0 : this.getRebateType()
						.hashCode());
		result = 37 * result
				+ (getInOutSign() == null ? 0 : this.getInOutSign().hashCode());
		result = 37 * result
				+ (getTimesSign() == null ? 0 : this.getTimesSign().hashCode());
		result = 37 * result
				+ (getVehTypeNo() == null ? 0 : this.getVehTypeNo().hashCode());
		return result;
	}

}