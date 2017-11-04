package com.hgsoft.entity;

public class CarTypeTrans implements java.io.Serializable {

	/**
	 * 车型转换编码
	 */
	private static final long serialVersionUID = 1L;

	private String startDate;//PK　起始日期
	private String class_;//PK　类别
	private Integer length;//PK 长度
	private Integer height;//PK高度
	private Integer width;//PK宽度
	private Integer wheelNumber;//PK轮数
	private Short axleNumber;//PK轴数
	private Integer weight;//PK重量
	private String vehType;//类型

	public CarTypeTrans() {
	}

	public CarTypeTrans(String vehType, String startDate, String class_,
			Integer length, Integer height, Integer width, Integer wheelNumber,
			Short axleNumber, Integer weight) {
		this.startDate = startDate;
		this.class_ = class_;
		this.length = length;
		this.height = height;
		this.width = width;
		this.wheelNumber = wheelNumber;
		this.axleNumber = axleNumber;
		this.weight = weight;
		this.vehType = vehType;
	}

	public String getVehType() {
		return this.vehType;
	}

	public void setVehType(String vehType) {
		this.vehType = vehType;
	}

	public String getStartDate() {
		return this.startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getClass_() {
		return this.class_;
	}

	public void setClass_(String class_) {
		this.class_ = class_;
	}

	public Integer getLength() {
		return this.length;
	}

	public void setLength(Integer length) {
		this.length = length;
	}

	public Integer getHeight() {
		return this.height;
	}

	public void setHeight(Integer height) {
		this.height = height;
	}

	public Integer getWidth() {
		return this.width;
	}

	public void setWidth(Integer width) {
		this.width = width;
	}

	public Integer getWheelNumber() {
		return this.wheelNumber;
	}

	public void setWheelNumber(Integer wheelNumber) {
		this.wheelNumber = wheelNumber;
	}

	public Short getAxleNumber() {
		return this.axleNumber;
	}

	public void setAxleNumber(Short axleNumber) {
		this.axleNumber = axleNumber;
	}

	public Integer getWeight() {
		return this.weight;
	}

	public void setWeight(Integer weight) {
		this.weight = weight;
	}

	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof CarTypeTrans))
			return false;
		CarTypeTrans castOther = (CarTypeTrans) other;

		return ((this.getStartDate() == castOther.getStartDate()) || (this
				.getStartDate() != null && castOther.getStartDate() != null && this
				.getStartDate().equals(castOther.getStartDate())))
				&& ((this.getClass_() == castOther.getClass_()) || (this
						.getClass_() != null && castOther.getClass_() != null && this
						.getClass_().equals(castOther.getClass_())))
				&& ((this.getLength() == castOther.getLength()) || (this
						.getLength() != null && castOther.getLength() != null && this
						.getLength().equals(castOther.getLength())))
				&& ((this.getHeight() == castOther.getHeight()) || (this
						.getHeight() != null && castOther.getHeight() != null && this
						.getHeight().equals(castOther.getHeight())))
				&& ((this.getWidth() == castOther.getWidth()) || (this
						.getWidth() != null && castOther.getWidth() != null && this
						.getWidth().equals(castOther.getWidth())))
				&& ((this.getWheelNumber() == castOther.getWheelNumber()) || (this
						.getWheelNumber() != null
						&& castOther.getWheelNumber() != null && this
						.getWheelNumber().equals(castOther.getWheelNumber())))
				&& ((this.getAxleNumber() == castOther.getAxleNumber()) || (this
						.getAxleNumber() != null
						&& castOther.getAxleNumber() != null && this
						.getAxleNumber().equals(castOther.getAxleNumber())))
				&& ((this.getWeight() == castOther.getWeight()) || (this
						.getWeight() != null && castOther.getWeight() != null && this
						.getWeight().equals(castOther.getWeight())));
	}

	public int hashCode() {
		int result = 17;

		result = 37 * result
				+ (getStartDate() == null ? 0 : this.getStartDate().hashCode());
		result = 37 * result
				+ (getClass_() == null ? 0 : this.getClass_().hashCode());
		result = 37 * result
				+ (getLength() == null ? 0 : this.getLength().hashCode());
		result = 37 * result
				+ (getHeight() == null ? 0 : this.getHeight().hashCode());
		result = 37 * result
				+ (getWidth() == null ? 0 : this.getWidth().hashCode());
		result = 37
				* result
				+ (getWheelNumber() == null ? 0 : this.getWheelNumber()
						.hashCode());
		result = 37
				* result
				+ (getAxleNumber() == null ? 0 : this.getAxleNumber()
						.hashCode());
		result = 37 * result
				+ (getWeight() == null ? 0 : this.getWeight().hashCode());
		return result;
	}

}