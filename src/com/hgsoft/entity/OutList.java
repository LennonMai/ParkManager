package com.hgsoft.entity;

import java.util.Date;

/**
 * OutList entity. @author MyEclipse Persistence Tools
 */

public class OutList implements java.io.Serializable {
	
     // Fields
	 private static final long serialVersionUID = 1L;
	 
	 private String listNo;		//出口流水号
     private Short recordNo;	//出口记录号
     private String inListNo;	//入口流水号
     private Short inGateNo;	//入口门编码
     private String inGateName;	//入口大门名称
     private Short inLaneNo;	//入口车道号
     private Short inVehType;	//入口车型
     private Short inVehClass;	//入口车种
     private String inVehPlate;	//入口车牌
     private String inPlateImg;	//入口车牌二值化图
     private Integer inOperatorNo;	//入口发卡员工号
     private Date inOpTime;		//入口发卡时间
     private Short inVehTypeAuto;	//入口车型自动识别
     private String inVehPlateAuto;	//入口车牌自动识别
     private Short cityNo;		//城市编码
     private Short areaNo;		//区域编码
     private Short parkNo;		//小区编码
     private Short gateNo;		//大门编号
     private String gateName;	//大门名称
     private Short laneNo;		//车道号
     private Short vehType;		//车型
     private Short vehClass;	//车种
     private Short vehCount;	//车辆数
     private String vehPlate;	//车牌号
     private String plateImg;	//车牌二值化图片
     private Short squadNo;		//工班号
     private Date squadDate;	//工班日期
     private Integer operatorNo;	//收费员工号
     private String operatorName;	//收费员姓名
     private String id;			//身份卡ID号
     private String idno;		//身份卡表面号
     private Date opTime;		//收费时间
     private Integer cardBoxNo;	//卡盒编码
     private Integer cardTrunkNo;	//卡箱编码
     private Short ticketType;	//通行券类型
     private Short userCardType;	//用户卡类型
     private String cardId;		//通行卡ID号
     private String cardNo;	//通行卡表面号
     private String obuId;		//OBUID
     private String payCardId;	//支付卡号
     private String payCardNo;	//支付卡表面号
     private Short payCardType;	//支付卡类型	0是没有卡 5是储值卡，6是记账卡，10是羊城通，16是缴费卡
     private Long payCardBalance;	//支付卡余额
     private Integer spEvent;	//特殊事件
     private Integer invoiceId;	//发票号
     private Short cashMoney;	//收费车金额
     private Short freeMoney;	//免费车金额
     private Short unpayMoney;	//未付金额
     private Short etcmoney;	//Etc金额
     private Short vehTypeAuto;	//车型自动识别
     private String vehPlateAuto;	//车牌自动识别
     private Short priceVerNo;	//费率版本号
     private Short listName;	//流水表文件名
     private Short checkType;	//验证类型
     private String inParkListNo;	//园中园流水号
     private Integer addCashMoney;	//代收小园金额
     private Integer addEtcMoney;	//代收小园Etc金额
     private Long etctradeNo;	//ETC交易系列号
     private Long etctac;		//ETCtac码
     private Long etctermTradNo;	//ETC终端交易列号
     private Long etctermCode;	//ETC终端机编码
     private Integer backUp1;	//备用1
     private Integer backUp2;	//备用2
     private Integer backUp3;	//备用3
     private Integer backUp4;	//备用4
     private Integer verifyCode;	//校验码
     private Date uploadTime;	//上传时间

    // Constructors

    /** default constructor */
    public OutList() {
    }
    
    /** full constructor */
    public OutList(Short recordNo, String inListNo, Short inGateNo, String inGateName, Short inLaneNo, Short inVehType, Short inVehClass, String inVehPlate, String inPlateImg, Integer inOperatorNo, Date inOpTime, Short inVehTypeAuto, String inVehPlateAuto, Short cityNo, Short areaNo, Short parkNo, Short gateNo, String gateName, Short laneNo, Short vehType, Short vehClass, Short vehCount, String vehPlate, String plateImg, Short squadNo, Date squadDate, Integer operatorNo, String operatorName, String id, String idno, Date opTime, Integer cardBoxNo, Integer cardTrunkNo, Short ticketType, Short userCardType, String cardId, String cardNo, String obuId, String payCardId, String payCardNo, Short payCardType, Long payCardBalance, Integer spEvent, Integer invoiceId, Short cashMoney, Short freeMoney, Short unpayMoney, Short etcmoney, Short vehTypeAuto, String vehPlateAuto, Short priceVerNo, Short listName, Short checkType, String inParkListNo, Integer addCashMoney, Integer addEtcMoney, Long etctradeNo, Long etctac, Long etctermTradNo, Long etctermCode, Integer backUp1, Integer backUp2, Integer backUp3, Integer backUp4, Integer verifyCode, Date uploadTime) {
        this.recordNo = recordNo;
        this.inListNo = inListNo;
        this.inGateNo = inGateNo;
        this.inGateName = inGateName;
        this.inLaneNo = inLaneNo;
        this.inVehType = inVehType;
        this.inVehClass = inVehClass;
        this.inVehPlate = inVehPlate;
        this.inPlateImg = inPlateImg;
        this.inOperatorNo = inOperatorNo;
        this.inOpTime = inOpTime;
        this.inVehTypeAuto = inVehTypeAuto;
        this.inVehPlateAuto = inVehPlateAuto;
        this.cityNo = cityNo;
        this.areaNo = areaNo;
        this.parkNo = parkNo;
        this.gateNo = gateNo;
        this.gateName = gateName;
        this.laneNo = laneNo;
        this.vehType = vehType;
        this.vehClass = vehClass;
        this.vehCount = vehCount;
        this.vehPlate = vehPlate;
        this.plateImg = plateImg;
        this.squadNo = squadNo;
        this.squadDate = squadDate;
        this.operatorNo = operatorNo;
        this.operatorName = operatorName;
        this.id = id;
        this.idno = idno;
        this.opTime = opTime;
        this.cardBoxNo = cardBoxNo;
        this.cardTrunkNo = cardTrunkNo;
        this.ticketType = ticketType;
        this.userCardType = userCardType;
        this.cardId = cardId;
        this.cardNo = cardNo;
        this.obuId = obuId;
        this.payCardId = payCardId;
        this.payCardNo = payCardNo;
        this.payCardType = payCardType;
        this.payCardBalance = payCardBalance;
        this.spEvent = spEvent;
        this.invoiceId = invoiceId;
        this.cashMoney = cashMoney;
        this.freeMoney = freeMoney;
        this.unpayMoney = unpayMoney;
        this.etcmoney = etcmoney;
        this.vehTypeAuto = vehTypeAuto;
        this.vehPlateAuto = vehPlateAuto;
        this.priceVerNo = priceVerNo;
        this.listName = listName;
        this.checkType = checkType;
        this.inParkListNo = inParkListNo;
        this.addCashMoney = addCashMoney;
        this.addEtcMoney = addEtcMoney;
        this.etctradeNo = etctradeNo;
        this.etctac = etctac;
        this.etctermTradNo = etctermTradNo;
        this.etctermCode = etctermCode;
        this.backUp1 = backUp1;
        this.backUp2 = backUp2;
        this.backUp3 = backUp3;
        this.backUp4 = backUp4;
        this.verifyCode = verifyCode;
        this.uploadTime = uploadTime;
    }
   
    // Property accessors

    public String getListNo() {
        return this.listNo;
    }
    
    public void setListNo(String listNo) {
        this.listNo = listNo;
    }

    public Short getRecordNo() {
        return this.recordNo;
    }
    
    public void setRecordNo(Short recordNo) {
        this.recordNo = recordNo;
    }

    public String getInListNo() {
        return this.inListNo;
    }
    
    public void setInListNo(String inListNo) {
        this.inListNo = inListNo;
    }

    public Short getInGateNo() {
        return this.inGateNo;
    }
    
    public void setInGateNo(Short inGateNo) {
        this.inGateNo = inGateNo;
    }

    public String getInGateName() {
        return this.inGateName;
    }
    
    public void setInGateName(String inGateName) {
        this.inGateName = inGateName;
    }

    public Short getInLaneNo() {
        return this.inLaneNo;
    }
    
    public void setInLaneNo(Short inLaneNo) {
        this.inLaneNo = inLaneNo;
    }

    public Short getInVehType() {
        return this.inVehType;
    }
    
    public void setInVehType(Short inVehType) {
        this.inVehType = inVehType;
    }

    public Short getInVehClass() {
        return this.inVehClass;
    }
    
    public void setInVehClass(Short inVehClass) {
        this.inVehClass = inVehClass;
    }

    public String getInVehPlate() {
        return this.inVehPlate;
    }
    
    public void setInVehPlate(String inVehPlate) {
        this.inVehPlate = inVehPlate;
    }

    public String getInPlateImg() {
        return this.inPlateImg;
    }
    
    public void setInPlateImg(String inPlateImg) {
        this.inPlateImg = inPlateImg;
    }

    public Integer getInOperatorNo() {
        return this.inOperatorNo;
    }
    
    public void setInOperatorNo(Integer inOperatorNo) {
        this.inOperatorNo = inOperatorNo;
    }

    public Date getInOpTime() {
        return this.inOpTime;
    }
    
    public void setInOpTime(Date inOpTime) {
        this.inOpTime = inOpTime;
    }

    public Short getInVehTypeAuto() {
        return this.inVehTypeAuto;
    }
    
    public void setInVehTypeAuto(Short inVehTypeAuto) {
        this.inVehTypeAuto = inVehTypeAuto;
    }

    public String getInVehPlateAuto() {
        return this.inVehPlateAuto;
    }
    
    public void setInVehPlateAuto(String inVehPlateAuto) {
        this.inVehPlateAuto = inVehPlateAuto;
    }

    public Short getCityNo() {
        return this.cityNo;
    }
    
    public void setCityNo(Short cityNo) {
        this.cityNo = cityNo;
    }

    public Short getAreaNo() {
        return this.areaNo;
    }
    
    public void setAreaNo(Short areaNo) {
        this.areaNo = areaNo;
    }

    public Short getParkNo() {
        return this.parkNo;
    }
    
    public void setParkNo(Short parkNo) {
        this.parkNo = parkNo;
    }

    public Short getGateNo() {
        return this.gateNo;
    }
    
    public void setGateNo(Short gateNo) {
        this.gateNo = gateNo;
    }

    public String getGateName() {
        return this.gateName;
    }
    
    public void setGateName(String gateName) {
        this.gateName = gateName;
    }

    public Short getLaneNo() {
        return this.laneNo;
    }
    
    public void setLaneNo(Short laneNo) {
        this.laneNo = laneNo;
    }

    public Short getVehType() {
        return this.vehType;
    }
    
    public void setVehType(Short vehType) {
        this.vehType = vehType;
    }

    public Short getVehClass() {
        return this.vehClass;
    }
    
    public void setVehClass(Short vehClass) {
        this.vehClass = vehClass;
    }

    public Short getVehCount() {
        return this.vehCount;
    }
    
    public void setVehCount(Short vehCount) {
        this.vehCount = vehCount;
    }

    public String getVehPlate() {
        return this.vehPlate;
    }
    
    public void setVehPlate(String vehPlate) {
        this.vehPlate = vehPlate;
    }

    public String getPlateImg() {
        return this.plateImg;
    }
    
    public void setPlateImg(String plateImg) {
        this.plateImg = plateImg;
    }

    public Short getSquadNo() {
        return this.squadNo;
    }
    
    public void setSquadNo(Short squadNo) {
        this.squadNo = squadNo;
    }

    public Date getSquadDate() {
        return this.squadDate;
    }
    
    public void setSquadDate(Date squadDate) {
        this.squadDate = squadDate;
    }

    public Integer getOperatorNo() {
        return this.operatorNo;
    }
    
    public void setOperatorNo(Integer operatorNo) {
        this.operatorNo = operatorNo;
    }

    public String getOperatorName() {
        return this.operatorName;
    }
    
    public void setOperatorName(String operatorName) {
        this.operatorName = operatorName;
    }

    public String getId() {
        return this.id;
    }
    
    public void setId(String id) {
        this.id = id;
    }

    public String getIdno() {
        return this.idno;
    }
    
    public void setIdno(String idno) {
        this.idno = idno;
    }

    public Date getOpTime() {
        return this.opTime;
    }
    
    public void setOpTime(Date opTime) {
        this.opTime = opTime;
    }

    public Integer getCardBoxNo() {
        return this.cardBoxNo;
    }
    
    public void setCardBoxNo(Integer cardBoxNo) {
        this.cardBoxNo = cardBoxNo;
    }

    public Integer getCardTrunkNo() {
        return this.cardTrunkNo;
    }
    
    public void setCardTrunkNo(Integer cardTrunkNo) {
        this.cardTrunkNo = cardTrunkNo;
    }

    public Short getTicketType() {
        return this.ticketType;
    }
    
    public void setTicketType(Short ticketType) {
        this.ticketType = ticketType;
    }

    public Short getUserCardType() {
        return this.userCardType;
    }
    
    public void setUserCardType(Short userCardType) {
        this.userCardType = userCardType;
    }

    public String getCardId() {
        return this.cardId;
    }
    
    public void setCardId(String cardId) {
        this.cardId = cardId;
    }

    public String getCardNo() {
        return this.cardNo;
    }
    
    public void setCardNo(String cardNo) {
        this.cardNo = cardNo;
    }

    public String getObuId() {
        return this.obuId;
    }
    
    public void setObuId(String obuId) {
        this.obuId = obuId;
    }

    public String getPayCardId() {
        return this.payCardId;
    }
    
    public void setPayCardId(String payCardId) {
        this.payCardId = payCardId;
    }

    public String getPayCardNo() {
        return this.payCardNo;
    }
    
    public void setPayCardNo(String payCardNo) {
        this.payCardNo = payCardNo;
    }

    public Short getPayCardType() {
        return this.payCardType;
    }
    
    public void setPayCardType(Short payCardType) {
        this.payCardType = payCardType;
    }

    public Long getPayCardBalance() {
        return this.payCardBalance;
    }
    
    public void setPayCardBalance(Long payCardBalance) {
        this.payCardBalance = payCardBalance;
    }

    public Integer getSpEvent() {
        return this.spEvent;
    }
    
    public void setSpEvent(Integer spEvent) {
        this.spEvent = spEvent;
    }

    public Integer getInvoiceId() {
        return this.invoiceId;
    }
    
    public void setInvoiceId(Integer invoiceId) {
        this.invoiceId = invoiceId;
    }

    public Short getCashMoney() {
        return this.cashMoney;
    }
    
    public void setCashMoney(Short cashMoney) {
        this.cashMoney = cashMoney;
    }

    public Short getFreeMoney() {
        return this.freeMoney;
    }
    
    public void setFreeMoney(Short freeMoney) {
        this.freeMoney = freeMoney;
    }

    public Short getUnpayMoney() {
        return this.unpayMoney;
    }
    
    public void setUnpayMoney(Short unpayMoney) {
        this.unpayMoney = unpayMoney;
    }

    public Short getEtcmoney() {
        return this.etcmoney;
    }
    
    public void setEtcmoney(Short etcmoney) {
        this.etcmoney = etcmoney;
    }

    public Short getVehTypeAuto() {
        return this.vehTypeAuto;
    }
    
    public void setVehTypeAuto(Short vehTypeAuto) {
        this.vehTypeAuto = vehTypeAuto;
    }

    public String getVehPlateAuto() {
        return this.vehPlateAuto;
    }
    
    public void setVehPlateAuto(String vehPlateAuto) {
        this.vehPlateAuto = vehPlateAuto;
    }

    public Short getPriceVerNo() {
        return this.priceVerNo;
    }
    
    public void setPriceVerNo(Short priceVerNo) {
        this.priceVerNo = priceVerNo;
    }

    public Short getListName() {
        return this.listName;
    }
    
    public void setListName(Short listName) {
        this.listName = listName;
    }

    public Short getCheckType() {
        return this.checkType;
    }
    
    public void setCheckType(Short checkType) {
        this.checkType = checkType;
    }

    public String getInParkListNo() {
        return this.inParkListNo;
    }
    
    public void setInParkListNo(String inParkListNo) {
        this.inParkListNo = inParkListNo;
    }

    public Integer getAddCashMoney() {
        return this.addCashMoney;
    }
    
    public void setAddCashMoney(Integer addCashMoney) {
        this.addCashMoney = addCashMoney;
    }

    public Integer getAddEtcMoney() {
        return this.addEtcMoney;
    }
    
    public void setAddEtcMoney(Integer addEtcMoney) {
        this.addEtcMoney = addEtcMoney;
    }

    public Long getEtctradeNo() {
        return this.etctradeNo;
    }
    
    public void setEtctradeNo(Long etctradeNo) {
        this.etctradeNo = etctradeNo;
    }

    public Long getEtctac() {
        return this.etctac;
    }
    
    public void setEtctac(Long etctac) {
        this.etctac = etctac;
    }

    public Long getEtctermTradNo() {
        return this.etctermTradNo;
    }
    
    public void setEtctermTradNo(Long etctermTradNo) {
        this.etctermTradNo = etctermTradNo;
    }

    public Long getEtctermCode() {
        return this.etctermCode;
    }
    
    public void setEtctermCode(Long etctermCode) {
        this.etctermCode = etctermCode;
    }

    public Integer getBackUp1() {
        return this.backUp1;
    }
    
    public void setBackUp1(Integer backUp1) {
        this.backUp1 = backUp1;
    }

    public Integer getBackUp2() {
        return this.backUp2;
    }
    
    public void setBackUp2(Integer backUp2) {
        this.backUp2 = backUp2;
    }

    public Integer getBackUp3() {
        return this.backUp3;
    }
    
    public void setBackUp3(Integer backUp3) {
        this.backUp3 = backUp3;
    }

    public Integer getBackUp4() {
        return this.backUp4;
    }
    
    public void setBackUp4(Integer backUp4) {
        this.backUp4 = backUp4;
    }

    public Integer getVerifyCode() {
        return this.verifyCode;
    }
    
    public void setVerifyCode(Integer verifyCode) {
        this.verifyCode = verifyCode;
    }

    public Date getUploadTime() {
        return this.uploadTime;
    }
    
    public void setUploadTime(Date uploadTime) {
        this.uploadTime = uploadTime;
    }
   
    //状态字符串
	public String getVehClassString(){
		if(this.vehClass==1) return "正常车";
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