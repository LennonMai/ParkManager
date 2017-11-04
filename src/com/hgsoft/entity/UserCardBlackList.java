package com.hgsoft.entity;

import java.util.Date;


public class UserCardBlackList  implements java.io.Serializable { 

     /**
	 * 用户卡黑名单
	 */
	private static final long serialVersionUID = 1L;
	private String uccode;//PK 用户卡编码
     private String genCau;//生成原因
     private Date genTime;//生成日期

    public UserCardBlackList() {
    }

    public UserCardBlackList(String uccode, String genCau, Date genTime) {
        this.uccode = uccode;
        this.genCau = genCau;
        this.genTime = genTime;
    }

  
    public String getUccode() {
        return this.uccode;
    }
    
    public void setUccode(String uccode) {
        this.uccode = uccode;
    }

    public String getGenCau() {
        return this.genCau;
    }
    
    public void setGenCau(String genCau) {
        this.genCau = genCau;
    }

    public Date getGenTime() {
        return this.genTime;
    }
    
    public void setGenTime(Date genTime) {
        this.genTime = genTime;
    }
   








}