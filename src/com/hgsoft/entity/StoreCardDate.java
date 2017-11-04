package com.hgsoft.entity;

import java.util.Date;


public class StoreCardDate  implements java.io.Serializable {


    /**
	 * 储值卡有效启用日期
	 */
	private static final long serialVersionUID = 1L;
     private Date firTime;//储值卡有效启用日期

    public StoreCardDate() {
    }
    public StoreCardDate(Date firTime) {
        this.firTime = firTime;
    }


    public Date getFirTime() {
        return this.firTime;
    }
    
    public void setFirTime(Date firTime) {
        this.firTime = firTime;
    }
   
	public boolean equals(Object obj) {
		
		return true;

	}

	public int hashCode() {
		return 1;
	}







}