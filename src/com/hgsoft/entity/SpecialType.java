package com.hgsoft.entity;

public class SpecialType implements java.io.Serializable {

	/**
	 * 特殊类型信息
	 */
	private static final long serialVersionUID = 1L;
	private Integer typeCode;// PK，特殊类型编码
	private String typeName;// PK,特殊类型名称

	public SpecialType() {
	}

	public SpecialType(Integer typeCode, String typeName) {
		this.typeCode = typeCode;
		this.typeName = typeName;
	}

	public Integer getTypeCode() {
		return this.typeCode;
	}

	public void setTypeCode(Integer typeCode) {
		this.typeCode = typeCode;
	}

	public String getTypeName() {
		return this.typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof SpecialType))
			return false;
		SpecialType castOther = (SpecialType) other;

		return ((this.getTypeCode() == castOther.getTypeCode()) || (this
				.getTypeCode() != null
				&& castOther.getTypeCode() != null && this.getTypeCode()
				.equals(castOther.getTypeCode())))
				&& ((this.getTypeName() == castOther.getTypeName()) || (this
						.getTypeName() != null
						&& castOther.getTypeName() != null && this
						.getTypeName().equals(castOther.getTypeName())));
	}

	public int hashCode() {
		int result = 17;

		result = 37 * result
				+ (getTypeCode() == null ? 0 : this.getTypeCode().hashCode());
		result = 37 * result
				+ (getTypeName() == null ? 0 : this.getTypeName().hashCode());
		return result;
	}

}