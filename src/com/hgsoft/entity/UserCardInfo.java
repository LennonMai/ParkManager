
package com.hgsoft.entity;

import java.sql.Blob;
import java.sql.Timestamp;

/**
 * TbUserCardInfo entity. @author MyEclipse Persistence Tools
 */

@SuppressWarnings("serial")
public class UserCardInfo implements java.io.Serializable {

	// Fields

	private Integer recNO;		//�û����
	private String owner;//�û�����	
	private String idcard;//���֤����
	private String vehPlate;//���ƺ�
	private Blob vehPlateImage;	//����ͼƬ(��������ݿ����һ��������)
	private String vehPlateImagePath;//
	private String vehBrand;//����Ʒ��
	private String parkingSpace;	//ͣ��λ
	private String staffNo;//�̹���	
	private String roomNo;//�û�����
	private String address;//��ϵ��ַ
	private String linkMan;//��ϵ��
	private String telePhone;//�̶��绰
	private String mobileNumber;//�ƶ��绰
	private Integer deposit;//Ѻ��
	private String cardNo;//�������
	private String obu;//OBU��
	private Short userCardType;//�û�������
	private Short feeRuleType;//�շ�����
	private Timestamp registerTime;//ע��ʱ��
	private Short status;//��״̬
	private Timestamp payEndTime;//���ɷ�ʱ��
	private String remark;//��ע
	private Integer feeCardType; //���⿨����     0Ϊҵ�����⿨  1Ϊ��ҵ�����⿨
	private Integer carType;//��������
	private Integer ownerIdentity;//��������
	private String parkingSpaceNo;
	// Constructors

	

	/** default constructor */
	public UserCardInfo() {
	}

	/** minimal constructor */
	public Integer getRecNO() {
		return recNO;
	}

	public void setRecNO(Integer recNO) {
		this.recNO = recNO;
	}

	public String getOwner() {
		return owner;
	}

	public void setOwner(String owner) {
		this.owner = owner;
	}

	public String getIdcard() {
		return idcard;
	}

	public void setIdcard(String idcard) {
		this.idcard = idcard;
	}

	public String getVehPlate() {
		return vehPlate;
	}

	public void setVehPlate(String vehPlate) {
		this.vehPlate = vehPlate;
	}

	public Blob getVehPlateImage() {
		return vehPlateImage;
	}

	public void setVehPlateImage(Blob vehPlateImage) {
		this.vehPlateImage = vehPlateImage;
	}

	public String getVehPlateImagePath() {
		return vehPlateImagePath;
	}

	public void setVehPlateImagePath(String vehPlateImagePath) {
		this.vehPlateImagePath = vehPlateImagePath;
	}

	public String getVehBrand() {
		return vehBrand;
	}

	public void setVehBrand(String vehBrand) {
		this.vehBrand = vehBrand;
	}

	public String getParkingSpace() {
		return parkingSpace;
	}

	public void setParkingSpace(String parkingSpace) {
		this.parkingSpace = parkingSpace;
	}

	public String getStaffNo() {
		return staffNo;
	}

	public void setStaffNo(String staffNo) {
		this.staffNo = staffNo;
	}

	public String getRoomNo() {
		return roomNo;
	}

	public void setRoomNo(String roomNo) {
		this.roomNo = roomNo;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getLinkMan() {
		return linkMan;
	}

	public void setLinkMan(String linkMan) {
		this.linkMan = linkMan;
	}

	public String getTelePhone() {
		return telePhone;
	}

	public void setTelePhone(String telePhone) {
		this.telePhone = telePhone;
	}

	public String getMobileNumber() {
		return mobileNumber;
	}

	public void setMobileNumber(String mobileNumber) {
		this.mobileNumber = mobileNumber;
	}

	public Integer getDeposit() {
		return deposit;
	}

	public void setDeposit(Integer deposit) {
		this.deposit = deposit;
	}

	public String getCardNo() {
		return cardNo;
	}

	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}

	public String getObu() {
		return obu;
	}

	public void setObu(String obu) {
		this.obu = obu;
	}

	public Short getUserCardType() {
		return userCardType;
	}

	public void setUserCardType(Short userCardType) {
		this.userCardType = userCardType;
	}

	public Short getFeeRuleType() {
		return feeRuleType;
	}

	public void setFeeRuleType(Short feeRuleType) {
		this.feeRuleType = feeRuleType;
	}

	public Timestamp getRegisterTime() {
		return registerTime;
	}

	public void setRegisterTime(Timestamp registerTime) {
		this.registerTime = registerTime;
	}

	public Short getStatus() {
		return status;
	}

	public void setStatus(Short status) {
		this.status = status;
	}

	public Timestamp getPayEndTime() {
		return payEndTime;
	}

	public void setPayEndTime(Timestamp payEndTime) {
		this.payEndTime = payEndTime;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Integer getFeeCardType() {
		return feeCardType;
	}

	public void setFeeCardType(Integer feeCardType) {
		this.feeCardType = feeCardType;
	}

	public Integer getCarType() {
		return carType;
	}

	public void setCarType(Integer carType) {
		this.carType = carType;
	}

	public Integer getOwnerIdentity() {
		return ownerIdentity;
	}

	public void setOwnerIdentity(Integer ownerIdentity) {
		this.ownerIdentity = ownerIdentity;
	}

	public String getParkingSpaceNo() {
		return parkingSpaceNo;
	}

	public void setParkingSpaceNo(String parkingSpaceNo) {
		this.parkingSpaceNo = parkingSpaceNo;
	}
	
	
}
