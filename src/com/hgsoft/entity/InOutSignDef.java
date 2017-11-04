package com.hgsoft.entity;

public class InOutSignDef implements java.io.Serializable {

	/**
	 * 出入口标志
	 */
	private static final long serialVersionUID = 1L;
	private Integer inGateNo;// 主键，入口大门编号
	private Integer outGateNo;// 主键，出口大门编号
	private Integer inOutSign;// 出入大门标志，0-表示同门，1-表示异门
	private String remark;// 备注

	public InOutSignDef() {
	}

	public InOutSignDef(Integer inGateNo, Integer outGateNo, Integer inOutSign,
			String remark) {
		this.inGateNo = inGateNo;
		this.outGateNo = outGateNo;
		this.inOutSign = inOutSign;
		this.remark = remark;
	}

	public Integer getInGateNo() {
		return this.inGateNo;
	}

	public void setInGateNo(Integer inGateNo) {
		this.inGateNo = inGateNo;
	}

	public Integer getOutGateNo() {
		return this.outGateNo;
	}

	public void setOutGateNo(Integer outGateNo) {
		this.outGateNo = outGateNo;
	}

	public Integer getInOutSign() {
		return this.inOutSign;
	}

	public void setInOutSign(Integer inOutSign) {
		this.inOutSign = inOutSign;
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
		if (!(other instanceof InOutSignDef))
			return false;
		InOutSignDef castOther = (InOutSignDef) other;

		return ((this.getInGateNo() == castOther.getInGateNo()) || (this
				.getInGateNo() != null && castOther.getInGateNo() != null && this
				.getInGateNo().equals(castOther.getInGateNo())))
				&& ((this.getOutGateNo() == castOther.getOutGateNo()) || (this
						.getOutGateNo() != null
						&& castOther.getOutGateNo() != null && this
						.getOutGateNo().equals(castOther.getOutGateNo())));
	}

	public int hashCode() {
		int result = 17;

		result = 37 * result
				+ (getInGateNo() == null ? 0 : this.getInGateNo().hashCode());
		result = 37 * result
				+ (getOutGateNo() == null ? 0 : this.getOutGateNo().hashCode());
		return result;
	}

}