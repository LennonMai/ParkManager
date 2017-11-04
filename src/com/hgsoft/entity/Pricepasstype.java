package com.hgsoft.entity;

/**
 * TbPricepasstype entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class Pricepasstype implements java.io.Serializable {

	// Fields
	private static final long serialVersionUID = 1L;
	private Short parkNo;//小区编号
	private Short inGateNo;//入口大门号
	private Short outGateNo;//出口大门号
	private Short feeType;//收费类型
	private Short verNo;//版本号
	
	// Constructors

	/** default constructor */
	public Pricepasstype() {
	}

	/** full constructor */
	public Pricepasstype(Short parkNo, Short inGateNo, Short outGateNo,
			Short feeType, Short verNo) {
		this.parkNo = parkNo;
		this.inGateNo = inGateNo;
		this.outGateNo = outGateNo;
		this.feeType = feeType;
		this.verNo = verNo;
	}
	
	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof Pricepasstype))
			return false;
		Pricepasstype castOther = (Pricepasstype) other;

		return ((this.getParkNo() == castOther.getParkNo()) || (this
				.getParkNo() != null
				&& castOther.getParkNo() != null && this.getParkNo().equals(
				castOther.getParkNo())))
				&& ((this.getInGateNo() == castOther.getInGateNo()) || (this
						.getInGateNo() != null
						&& castOther.getInGateNo() != null && this
						.getInGateNo().equals(castOther.getInGateNo())))
				&& ((this.getOutGateNo() == castOther.getOutGateNo()) || (this
						.getOutGateNo() != null
						&& castOther.getOutGateNo() != null && this
						.getOutGateNo().equals(castOther.getOutGateNo())))
				&& ((this.getFeeType() == castOther.getFeeType()) || (this
						.getFeeType() != null
						&& castOther.getFeeType() != null && this.getFeeType()
						.equals(castOther.getFeeType())))
				&& ((this.getVerNo() == castOther.getVerNo()) || (this
						.getVerNo() != null
						&& castOther.getVerNo() != null && this.getVerNo()
						.equals(castOther.getVerNo())));
	}

	public int hashCode() {
		int result = 17;

		result = 37 * result
				+ (getParkNo() == null ? 0 : this.getParkNo().hashCode());
		result = 37 * result
				+ (getInGateNo() == null ? 0 : this.getInGateNo().hashCode());
		result = 37 * result
				+ (getOutGateNo() == null ? 0 : this.getOutGateNo().hashCode());
		result = 37 * result
				+ (getFeeType() == null ? 0 : this.getFeeType().hashCode());
		result = 37 * result
				+ (getVerNo() == null ? 0 : this.getVerNo().hashCode());
		return result;
	}


	// Property accessors
	public Short getParkNo() {
		return this.parkNo;
	}

	public void setParkNo(Short parkNo) {
		this.parkNo = parkNo;
	}

	public Short getInGateNo() {
		return this.inGateNo;
	}

	public void setInGateNo(Short inGateNo) {
		this.inGateNo = inGateNo;
	}

	public Short getOutGateNo() {
		return this.outGateNo;
	}

	public void setOutGateNo(Short outGateNo) {
		this.outGateNo = outGateNo;
	}

	public Short getFeeType() {
		return this.feeType;
	}

	public void setFeeType(Short feeType) {
		this.feeType = feeType;
	}

	public Short getVerNo() {
		return this.verNo;
	}

	public void setVerNo(Short verNo) {
		this.verNo = verNo;
	}

}