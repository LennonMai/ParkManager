package com.hgsoft.entity;

import java.util.Date;

public class AccountAgentExportLogTemp
{
	private Date squadDate;	//PK,��������
	private String packNo;	//PK,���ݰ����
	private Date opTime;	//PK,����ʱ��
	private String fileName;	//�ļ���
	private Integer recCount;	//���ݼ�¼��
	private Integer totalMoney;	//�շѽ������
	public Date getSquadDate() {
		return squadDate;
	}
	public void setSquadDate(Date squadDate) {
		this.squadDate = squadDate;
	}
	public String getPackNo() {
		return packNo;
	}
	public void setPackNo(String packNo) {
		this.packNo = packNo;
	}
	public Date getOpTime() {
		return opTime;
	}
	public void setOpTime(Date opTime) {
		this.opTime = opTime;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public Integer getRecCount() {
		return recCount;
	}
	public void setRecCount(Integer recCount) {
		this.recCount = recCount;
	}
	public Integer getTotalMoney() {
		return totalMoney;
	}
	public void setTotalMoney(Integer totalMoney) {
		this.totalMoney = totalMoney;
	}
}
