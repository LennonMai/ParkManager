package com.hgsoft.entity;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;

public class ParkInformation implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	private Short areaNo;// ��Ӧ���ݿ��ֶ�AreaNo������룬PK����
	private Short parkNo;// С�����룬PK����
	private String parkLevel;// С������PK����

	private String parkName;// С������
	private String parkFullName;// С��ȫ��
	private String parkServerName;// ����������
	private String parkServerIp;// ������IP
	private String parkDomain;// ����
	private String parkDbname;// ���ݿ�����
	private String parkDbuserName;// ���ݿ��û���
	private String parkDbpassword;// ���ݿ�����
	private Short uplevelParkNo;// �ϼ�С������
	private Integer parkSpaceCnt;// ��λ����

	public ParkInformation() {
	}

	public ParkInformation(Short areaNo, Short parkNo, String parkLevel,
			String parkName, String parkFullName, String parkServerName,
			String parkServerIp, String parkDomain, String parkDbname,
			String parkDbuserName, String parkDbpassword, Short uplevelParkNo,
			Integer parkSpaceCnt) {
		this.areaNo = areaNo;
		this.parkNo = parkNo;
		this.parkLevel = parkLevel;
		this.parkName = parkName;
		this.parkFullName = parkFullName;
		this.parkServerName = parkServerName;
		this.parkServerIp = parkServerIp;
		this.parkDomain = parkDomain;
		this.parkDbname = parkDbname;
		this.parkDbuserName = parkDbuserName;
		this.parkDbpassword = parkDbpassword;
		this.uplevelParkNo = uplevelParkNo;
		this.parkSpaceCnt = parkSpaceCnt;
	}

	public Short getAreaNo() {
		return areaNo;
	}

	public void setAreaNo(Short areaNo) {
		this.areaNo = areaNo;
	}

	public Short getParkNo() {
		return parkNo;
	}

	public void setParkNo(Short parkNo) {
		this.parkNo = parkNo;
	}

	public String getParkLevel() {
		return parkLevel;
	}

	public void setParkLevel(String parkLevel) {
		this.parkLevel = parkLevel;
	}

	public String getParkName() {
		return parkName;
	}

	public void setParkName(String parkName) {
		this.parkName = parkName;
	}

	public String getParkFullName() {
		return parkFullName;
	}

	public void setParkFullName(String parkFullName) {
		this.parkFullName = parkFullName;
	}

	public String getParkServerName() {
		return parkServerName;
	}

	public void setParkServerName(String parkServerName) {
		this.parkServerName = parkServerName;
	}

	public String getParkServerIp() {
		return parkServerIp;
	}

	public void setParkServerIp(String parkServerIp) {
		this.parkServerIp = parkServerIp;
	}

	public String getParkDomain() {
		return parkDomain;
	}

	public void setParkDomain(String parkDomain) {
		this.parkDomain = parkDomain;
	}

	public String getParkDbname() {
		return parkDbname;
	}

	public void setParkDbname(String parkDbname) {
		this.parkDbname = parkDbname;
	}

	public String getParkDbuserName() {
		return parkDbuserName;
	}

	public void setParkDbuserName(String parkDbuserName) {
		this.parkDbuserName = parkDbuserName;
	}

	public String getParkDbpassword() {
		return parkDbpassword;
	}

	public void setParkDbpassword(String parkDbpassword) {
		this.parkDbpassword = parkDbpassword;
	}

	public Short getUplevelParkNo() {
		return uplevelParkNo;
	}

	public void setUplevelParkNo(Short uplevelParkNo) {
		this.uplevelParkNo = uplevelParkNo;
	}

	public Integer getParkSpaceCnt() {
		return parkSpaceCnt;
	}

	public void setParkSpaceCnt(Integer parkSpaceCnt) {
		this.parkSpaceCnt = parkSpaceCnt;
	}

	public boolean equals(Object obj) {
		if (obj == this) {
			return true;
		}

		if (!(obj instanceof ParkInformation)) {
			return false;
		}
		ParkInformation parkInformation = (ParkInformation) obj;

		return new EqualsBuilder()
				.append(this.areaNo, parkInformation.getAreaNo())
				.append(this.parkNo, parkInformation.getParkNo())
				.append(this.parkLevel, parkInformation.getParkLevel())
				.isEquals();

	}

	public int hashCode() {
		return new HashCodeBuilder().append(this.areaNo).append(this.parkNo)
				.append(this.parkLevel).toHashCode();
	}

	// public boolean equals(Object other) {
	// if ((this == other))
	// return true;
	// if ((other == null))
	// return false;
	// if (!(other instanceof ParkInformation))
	// return false;
	// ParkInformation castOther = (ParkInformation) other;
	//
	// return ((this.getAreaNo() == castOther.getAreaNo()) ||
	// (this
	// .getAreaNo() != null
	// && castOther.getAreaNo() != null && this
	// .getAreaNo().equals(castOther.getAreaNo())))
	// && ((this.getParkNo() == castOther.getParkNo()) || (this
	// .getParkNo() != null && castOther.getParkNo() != null && this
	// .getParkNo().equals(castOther.getParkNo())))
	// && ((this.getParkLevel() == castOther.getParkLevel()) || (this
	// .getParkLevel() != null
	// && castOther.getParkLevel() != null && this
	// .getParkLevel().equals(castOther.getParkLevel())));
	// }
	//
	// public int hashCode() {
	// int result = 17;
	//
	// result = 37
	// * result
	// + (getAreaNo() == null ? 0 : this.getAreaNo()
	// .hashCode());
	// result = 37 * result
	// + (getParkNo() == null ? 0 : this.getParkNo().hashCode());
	// result = 37 * result
	// + (getParkLevel() == null ? 0 : this.getParkLevel().hashCode());
	// return result;
	// }

}