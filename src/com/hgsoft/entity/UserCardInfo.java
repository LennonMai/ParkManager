
package com.hgsoft.entity;

import java.sql.Blob;
import java.sql.Timestamp;

/**
 * TbUserCardInfo entity. @author MyEclipse Persistence Tools
 */

@SuppressWarnings("serial")
public class UserCardInfo implements java.io.Serializable {

	// Fields

	private Integer recNO;		//用户编号
	private String owner;//用户姓名	
	private String idcard;//身份证号码
	private String vehPlate;//车牌号
	private Blob vehPlateImage;	//车牌图片(保存进数据库的是一个数据流)
	private String vehPlateImagePath;//
	private String vehBrand;//车辆品牌
	private String parkingSpace;	//停车位
	private String staffNo;//教工号	
	private String roomNo;//用户房号
	private String address;//联系地址
	private String linkMan;//联系人
	private String telePhone;//固定电话
	private String mobileNumber;//移动电话
	private Integer deposit;//押金
	private String cardNo;//卡表面号
	private String obu;//OBU号
	private Short userCardType;//用户卡类型
	private Short feeRuleType;//收费类型
	private Timestamp registerTime;//注册时间
	private Short status;//卡状态
	private Timestamp payEndTime;//最后缴费时间
	private String remark;//备注
	private Integer feeCardType; //月租卡类型     0为业主月租卡  1为非业主月租卡
	private Integer carType;//车辆类型
	private Integer ownerIdentity;//车辆类型
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
