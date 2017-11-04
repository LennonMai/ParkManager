package com.hgsoft.entity;

import java.io.Serializable;
import java.util.Date;

public class StoreCardBlackList implements Serializable{
	/**
	 * 储值卡黑名单
	 */
	private static final long serialVersionUID = 1L;
	private String scCode;//主键，储值卡卡号
	private String genCau;//失效原因
	private Date genTime;//失效日期
	
	
	
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
