package com.hgsoft.entity;

import java.util.Date;


public class OBUDate  implements java.io.Serializable {


     /**
	 * OBU有效启用日期
	 */
	private static final long serialVersionUID = 1L;
	private Date firTime;

    public OBUDate() {
    }

    public OBUDate(Date firTime) {
        this.firTime = firTime;
    }

    public Date getFirTime() {
        return this.firTime;
    }
    
    public void setFirTime(Date firTime) {
        this.firTime = firTime;
    }
   








}