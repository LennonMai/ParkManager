package com.hgsoft.entity;

import java.io.Serializable;
import java.util.Date;

public class InList implements Serializable {

	private static final long serialVersionUID = 1L;

	private String listNo;	//��ˮ����
	private Short recordNo;	//��¼��
	private Integer cityNo;	//���б���
	private Short areaNo;	//�������
	private Short parkNo;	//С������
	private Short gateNo;	//���ű���
	private String gateName;	//������
	private Short laneNo;	//��������
	private Short vehType;	//����
	private Short vehClass;	//����
	private Short vehCount;	//������
	private String vehPlate;	//����
	private String plateImg;	//���ƶ�ֵ��ͼƬ
	private Short squadNo;	//�����
	private Date squadDate;	//��������
	private Integer operatorNo;	//����Ա����
	private String operatorName;//����Ա����
	private String id;	//��ݿ���
	private String idno;	//��ݿ�������
	private Date opTime;	//����ʱ��
	private Integer cardBoxNo;	//���б���
	private Integer cardTrunkNo;//�������
	private Short ticketType;	//ͨ��ȯ����
	private Short userCardType;	//�û�������
	private String cardId;	//ͨ�п�����
	private String cardNo;	//ͨ�п��������
	private String obuid;	//OBUID
	private Integer spEvent;	//�����¼�
	private Short vehTypeAuto;	//�����Զ�ʶ��
	private String vehPlateAuto;//�����Զ�ʶ��
	private Short listName;	//��ˮ���ļ���
	private Integer backUp1;	//����1
	private Integer backUp2;	//����2
	private Integer backUp3;	//����3
	private Integer backUp4;	//����4
	private Integer verifyCode;	//У����
	private Date uploadTime;	//�ϴ�ʱ��
	
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
	
	//״̬�ַ���
	public String getVehClassString(){
		if (this.vehClass==1) return "������";
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
