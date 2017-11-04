package com.hgsoft.entity;

import java.io.Serializable;
import java.util.Date;

public class InList implements Serializable {

	private static final long serialVersionUID = 1L;

	private String listNo;	//流水编码
	private Short recordNo;	//记录号
	private Integer cityNo;	//城市编码
	private Short areaNo;	//区域编码
	private Short parkNo;	//小区编码
	private Short gateNo;	//大门编码
	private String gateName;	//大门名
	private Short laneNo;	//车道编码
	private Short vehType;	//车型
	private Short vehClass;	//车种
	private Short vehCount;	//车辆数
	private String vehPlate;	//车牌
	private String plateImg;	//车牌二值化图片
	private Short squadNo;	//工班号
	private Date squadDate;	//工班日期
	private Integer operatorNo;	//操作员编码
	private String operatorName;//操作员姓名
	private String id;	//身份卡号
	private String idno;	//身份卡表面编号
	private Date opTime;	//操作时间
	private Integer cardBoxNo;	//卡盒编码
	private Integer cardTrunkNo;//卡箱编码
	private Short ticketType;	//通行券类型
	private Short userCardType;	//用户卡类型
	private String cardId;	//通行卡卡号
	private String cardNo;	//通行卡表面编码
	private String obuid;	//OBUID
	private Integer spEvent;	//特殊事件
	private Short vehTypeAuto;	//车型自动识别
	private String vehPlateAuto;//车牌自动识别
	private Short listName;	//流水表文件名
	private Integer backUp1;	//备用1
	private Integer backUp2;	//备用2
	private Integer backUp3;	//备用3
	private Integer backUp4;	//备用4
	private Integer verifyCode;	//校验码
	private Date uploadTime;	//上传时间
	
	public String getListNo() {
		return listNo;
	}
	public void setListNo(String listNo) {
		this.listNo = listNo;
	}
	public Short getRecordNo() {
		return recordNo;
	}
	public void setRecordNo(Short recordNo) {
		this.recordNo = recordNo;
	}
	public Integer getCityNo() {
		return cityNo;
	}
	public void setCityNo(Integer cityNo) {
		this.cityNo = cityNo;
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
	public Short getGateNo() {
		return gateNo;
	}
	public void setGateNo(Short gateNo) {
		this.gateNo = gateNo;
	}
	public String getGateName() {
		return gateName;
	}
	public void setGateName(String gateName) {
		this.gateName = gateName;
	}
	public Short getLaneNo() {
		return laneNo;
	}
	public void setLaneNo(Short laneNo) {
		this.laneNo = laneNo;
	}
	public Short getVehType() {
		return vehType;
	}
	public void setVehType(Short vehType) {
		this.vehType = vehType;
	}
	public Short getVehClass() {
		return vehClass;
	}
	public void setVehClass(Short vehClass) {
		this.vehClass = vehClass;
	}
	public Short getVehCount() {
		return vehCount;
	}
	public void setVehCount(Short vehCount) {
		this.vehCount = vehCount;
	}
	public String getVehPlate() {
		return vehPlate;
	}
	public void setVehPlate(String vehPlate) {
		this.vehPlate = vehPlate;
	}
	public String getPlateImg() {
		return plateImg;
	}
	public void setPlateImg(String plateImg) {
		this.plateImg = plateImg;
	}
	public Short getSquadNo() {
		return squadNo;
	}
	public void setSquadNo(Short squadNo) {
		this.squadNo = squadNo;
	}
	public Date getSquadDate() {
		return squadDate;
	}
	public void setSquadDate(Date squadDate) {
		this.squadDate = squadDate;
	}
	public Integer getOperatorNo() {
		return operatorNo;
	}
	public void setOperatorNo(Integer operatorNo) {
		this.operatorNo = operatorNo;
	}
	public String getOperatorName() {
		return operatorName;
	}
	public void setOperatorName(String operatorName) {
		this.operatorName = operatorName;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getIdno() {
		return idno;
	}
	public void setIdno(String idno) {
		this.idno = idno;
	}
	public Date getOpTime() {
		return opTime;
	}
	public void setOpTime(Date opTime) {
		this.opTime = opTime;
	}
	public Integer getCardBoxNo() {
		return cardBoxNo;
	}
	public void setCardBoxNo(Integer cardBoxNo) {
		this.cardBoxNo = cardBoxNo;
	}
	public Integer getCardTrunkNo() {
		return cardTrunkNo;
	}
	public void setCardTrunkNo(Integer cardTrunkNo) {
		this.cardTrunkNo = cardTrunkNo;
	}
	public Short getTicketType() {
		return ticketType;
	}
	public void setTicketType(Short ticketType) {
		this.ticketType = ticketType;
	}
	public Short getUserCardType() {
		return userCardType;
	}
	public void setUserCardType(Short userCardType) {
		this.userCardType = userCardType;
	}
	public String getCardId() {
		return cardId;
	}
	public void setCardId(String cardId) {
		this.cardId = cardId;
	}
	public String getCardNo() {
		return cardNo;
	}
	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}
	public String getObuid() {
		return obuid;
	}
	public void setObuid(String obuid) {
		this.obuid = obuid;
	}
	public Integer getSpEvent() {
		return spEvent;
	}
	public void setSpEvent(Integer spEvent) {
		this.spEvent = spEvent;
	}
	public Short getVehTypeAuto() {
		return vehTypeAuto;
	}
	public void setVehTypeAuto(Short vehTypeAuto) {
		this.vehTypeAuto = vehTypeAuto;
	}
	public String getVehPlateAuto() {
		return vehPlateAuto;
	}
	public void setVehPlateAuto(String vehPlateAuto) {
		this.vehPlateAuto = vehPlateAuto;
	}
	public Short getListName() {
		return listName;
	}
	public void setListName(Short listName) {
		this.listName = listName;
	}
	public Integer getBackUp1() {
		return backUp1;
	}
	public void setBackUp1(Integer backUp1) {
		this.backUp1 = backUp1;
	}
	public Integer getBackUp2() {
		return backUp2;
	}
	public void setBackUp2(Integer backUp2) {
		this.backUp2 = backUp2;
	}
	public Integer getBackUp3() {
		return backUp3;
	}
	public void setBackUp3(Integer backUp3) {
		this.backUp3 = backUp3;
	}
	public Integer getBackUp4() {
		return backUp4;
	}
	public void setBackUp4(Integer backUp4) {
		this.backUp4 = backUp4;
	}
	public Integer getVerifyCode() {
		return verifyCode;
	}
	public void setVerifyCode(Integer verifyCode) {
		this.verifyCode = verifyCode;
	}
	public Date getUploadTime() {
		return uploadTime;
	}
	public void setUploadTime(Date uploadTime) {
		this.uploadTime = uploadTime;
	}
	
	//状态字符串
	public String getVehClassString(){
		if (this.vehClass==1) return "正常车";
		else if(this.vehClass==2) return "免费车";
		else if(this.vehClass==3) return "校内车";
		else if(this.vehClass==4) return "车队车";
		else if(this.vehClass==5) return "未付车";
		//else if(this.vehClass==6) return "粤通卡车";
		else if(this.vehClass==6) return "缴费卡";
		else if(this.vehClass==9) return "未知车";
		else return "";
	}
}
