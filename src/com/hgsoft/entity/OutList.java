package com.hgsoft.entity;

import java.util.Date;

/**
 * OutList entity. @author MyEclipse Persistence Tools
 */

public class OutList implements java.io.Serializable {
	
     // Fields
	 private static final long serialVersionUID = 1L;
	 
	 private String listNo;		//������ˮ��
     private Short recordNo;	//���ڼ�¼��
     private String inListNo;	//�����ˮ��
     private Short inGateNo;	//����ű���
     private String inGateName;	//��ڴ�������
     private Short inLaneNo;	//��ڳ�����
     private Short inVehType;	//��ڳ���
     private Short inVehClass;	//��ڳ���
     private String inVehPlate;	//��ڳ���
     private String inPlateImg;	//��ڳ��ƶ�ֵ��ͼ
     private Integer inOperatorNo;	//��ڷ���Ա����
     private Date inOpTime;		//��ڷ���ʱ��
     private Short inVehTypeAuto;	//��ڳ����Զ�ʶ��
     private String inVehPlateAuto;	//��ڳ����Զ�ʶ��
     private Short cityNo;		//���б���
     private Short areaNo;		//�������
     private Short parkNo;		//С������
     private Short gateNo;		//���ű��
     private String gateName;	//��������
     private Short laneNo;		//������
     private Short vehType;		//����
     private Short vehClass;	//����
     private Short vehCount;	//������
     private String vehPlate;	//���ƺ�
     private String plateImg;	//���ƶ�ֵ��ͼƬ
     private Short squadNo;		//�����
     private Date squadDate;	//��������
     private Integer operatorNo;	//�շ�Ա����
     private String operatorName;	//�շ�Ա����
     private String id;			//��ݿ�ID��
     private String idno;		//��ݿ������
     private Date opTime;		//�շ�ʱ��
     private Integer cardBoxNo;	//���б���
     private Integer cardTrunkNo;	//�������
     private Short ticketType;	//ͨ��ȯ����
     private Short userCardType;	//�û�������
     private String cardId;		//ͨ�п�ID��
     private String cardNo;	//ͨ�п������
     private String obuId;		//OBUID
     private String payCardId;	//֧������
     private String payCardNo;	//֧���������
     private Short payCardType;	//֧��������	0��û�п� 5�Ǵ�ֵ����6�Ǽ��˿���10�����ͨ��16�ǽɷѿ�
     private Long payCardBalance;	//֧�������
     private Integer spEvent;	//�����¼�
     private Integer invoiceId;	//��Ʊ��
     private Short cashMoney;	//�շѳ����
     private Short freeMoney;	//��ѳ����
     private Short unpayMoney;	//δ�����
     private Short etcmoney;	//Etc���
     private Short vehTypeAuto;	//�����Զ�ʶ��
     private String vehPlateAuto;	//�����Զ�ʶ��
     private Short priceVerNo;	//���ʰ汾��
     private Short listName;	//��ˮ���ļ���
     private Short checkType;	//��֤����
     private String inParkListNo;	//԰��԰��ˮ��
     private Integer addCashMoney;	//����С԰���
     private Integer addEtcMoney;	//����С԰Etc���
     private Long etctradeNo;	//ETC����ϵ�к�
     private Long etctac;		//ETCtac��
     private Long etctermTradNo;	//ETC�ն˽����к�
     private Long etctermCode;	//ETC�ն˻�����
     private Integer backUp1;	//����1
     private Integer backUp2;	//����2
     private Integer backUp3;	//����3
     private Integer backUp4;	//����4
     private Integer verifyCode;	//У����
     private Date uploadTime;	//�ϴ�ʱ��

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
   
    //״̬�ַ���
	public String getVehClassString(){
		if(this.vehClass==1) return "������";
		else if(this.vehClass==2) return "��ѳ�";
		else if(this.vehClass==3) return "У�ڳ�";
		else if(this.vehClass==4) return "���ӳ�";
		else if(this.vehClass==5) return "δ����";
		//else if(this.vehClass==6) return "��ͨ����";
		else if(this.vehClass==6) return "�ɷѿ�";
		else if(this.vehClass==9) return "δ֪��";
		else return "";
	}
}