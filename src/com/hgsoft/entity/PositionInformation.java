package com.hgsoft.entity;

@SuppressWarnings("serial")
public class PositionInformation implements java.io.Serializable {

	private Integer no;// 位置编码,PK主键
	private Short class_;// 类型,PK主键
	private String name;// 位置名称
	private Integer iid;// 唯一编号

	public PositionInformation() {
	}

	public PositionInformation(Integer no, Short class_, String name,
			Integer iid) {
		this.no = no;
		this.class_ = class_;
		this.name = name;
		this.iid = iid;
	}

	public Integer getNo() {
		return this.no;
	}

	public void setNo(Integer no) {
		this.no = no;
	}

	public Short getClass_() {
		return this.class_;
	}

	public void setClass_(Short class_) {
		this.class_ = class_;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getIid() {
		return this.iid;
	}

	public void setIid(Integer iid) {
		this.iid = iid;
	}

	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof PositionInformation))
			return false;
		PositionInformation castOther = (PositionInformation) other;

		return ((this.getNo() == castOther.getNo()) || (this.getNo() != null
				&& castOther.getNo() != null && this.getNo().equals(
				castOther.getNo())))
				&& ((this.getClass_() == castOther.getClass_()) || (this
						.getClass_() != null && castOther.getClass_() != null && this
						.getClass_().equals(castOther.getClass_())));
	}

	public int hashCode() {
		int result = 17;

		result = 37 * result + (getNo() == null ? 0 : this.getNo().hashCode());
		result = 37 * result
				+ (getClass_() == null ? 0 : this.getClass_().hashCode());
		return result;
	}
}