package com.hgsoft.entity;

public class SpecialVeh implements java.io.Serializable {

	/**
	 * 特殊车辆管理
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String vehPlate;// PK，车牌号
	private String cardNo;// PK，卡号
	private Integer specialType;// 特殊类型，对应tb_specialtype的TypeCode字段
	private Short lanetype;// 车道类型，1-入口，2-出口，3-出入口
	private String info;// 拦截信息

	public SpecialVeh() {
	}

	/** full constructor */
	public SpecialVeh(String vehPlate, String cardNo, Integer specialType,
			Short lanetype, String info) {
		this.vehPlate = vehPlate;
		this.cardNo = cardNo;
		this.specialType = specialType;
		this.lanetype = lanetype;
		this.info = info;
	}

	public String getVehPlate() {
		return this.vehPlate;
	}

	public void setVehPlate(String vehPlate) {
		this.vehPlate = vehPlate;
	}

	public String getCardNo() {
		return this.cardNo;
	}

	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}

	public Integer getSpecialType() {
		return this.specialType;
	}

	public void setSpecialType(Integer specialType) {
		this.specialType = specialType;
	}

	public Short getLanetype() {
		return this.lanetype;
	}

	public void setLanetype(Short lanetype) {
		this.lanetype = lanetype;
	}

	public String getInfo() {
		return this.info;
	}

	public void setInfo(String info) {
		this.info = info;
	}

	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof SpecialVeh))
			return false;
		SpecialVeh castOther = (SpecialVeh) other;

		return ((this.getVehPlate() == castOther.getVehPlate()) || (this
				.getVehPlate() != null
				&& castOther.getVehPlate() != null && this.getVehPlate()
				.equals(castOther.getVehPlate())))
				&& ((this.getCardNo() == castOther.getCardNo()) || (this
						.getCardNo() != null
						&& castOther.getCardNo() != null && this.getCardNo()
						.equals(castOther.getCardNo())));
	}

	public int hashCode() {
		int result = 17;

		result = 37 * result
				+ (getVehPlate() == null ? 0 : this.getVehPlate().hashCode());
		result = 37 * result
				+ (getCardNo() == null ? 0 : this.getCardNo().hashCode());
		return result;
	}

}