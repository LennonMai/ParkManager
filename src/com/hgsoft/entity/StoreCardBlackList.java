package com.hgsoft.entity;

import java.io.Serializable;
import java.util.Date;

public class StoreCardBlackList implements Serializable{
	/**
	 * ��ֵ��������
	 */
	private static final long serialVersionUID = 1L;
	private String scCode;//��������ֵ������
	private String genCau;//ʧЧԭ��
	private Date genTime;//ʧЧ����
	
	
	
	public Date getGenTime() {
		return genTime;
	}
	public void setGenTime(Date genTime) {
		this.genTime = genTime;
	}
	public String getGenCau() {
		return genCau;
	}
	public void setGenCau(String genCau) {
		this.genCau = genCau;
	}
	public String getScCode() {
		return scCode;
	}
	public void setScCode(String scCode) {
		this.scCode = scCode;
	}

	


}
