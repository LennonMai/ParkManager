package com.hgsoft.entity;

/**
 * 车道收费员角色信息
 * 
 * @author qinzuohai
 */

public class LaneOperatorRole implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer operatorNo;// 操作员编码 PK
	private Short roleNo;// 角色编码 PK

	public LaneOperatorRole() {
	}

	public LaneOperatorRole(Integer operatorNo, Short roleNo) {
		this.operatorNo = operatorNo;
		this.roleNo = roleNo;
	}

	public Integer getOperatorNo() {
		return this.operatorNo;
	}

	public void setOperatorNo(Integer operatorNo) {
		this.operatorNo = operatorNo;
	}

	public Short getRoleNo() {
		return this.roleNo;
	}

	public void setRoleNo(Short roleNo) {
		this.roleNo = roleNo;
	}

	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof LaneOperatorRole))
			return false;
		LaneOperatorRole castOther = (LaneOperatorRole) other;

		return ((this.getOperatorNo() == castOther.getOperatorNo()) || (this
				.getOperatorNo() != null
				&& castOther.getOperatorNo() != null && this.getOperatorNo()
				.equals(castOther.getOperatorNo())))
				&& ((this.getRoleNo() == castOther.getRoleNo()) || (this
						.getRoleNo() != null
						&& castOther.getRoleNo() != null && this.getRoleNo()
						.equals(castOther.getRoleNo())));
	}

	public int hashCode() {
		int result = 17;

		result = 37
				* result
				+ (getOperatorNo() == null ? 0 : this.getOperatorNo()
						.hashCode());
		result = 37 * result
				+ (getRoleNo() == null ? 0 : this.getRoleNo().hashCode());
		return result;
	}
}