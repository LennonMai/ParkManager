package com.hgsoft.entity;

public class SpecialVeh implements java.io.Serializable {

	/**
	 * ���⳵������
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String vehPlate;// PK�����ƺ�
	private String cardNo;// PK������
	private Integer specialType;// �������ͣ���Ӧtb_specialtype��TypeCode�ֶ�
	private Short lanetype;// �������ͣ�1-��ڣ�2-���ڣ�3-�����
	private String info;// ������Ϣ

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