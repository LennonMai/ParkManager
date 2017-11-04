package com.hgsoft.entity;
import java.util.Date;

public class TollyCardDate  implements java.io.Serializable {

    /**
	 * 记帐卡有效启用日期
	 */
	private static final long serialVersionUID = 1L;

     private Date firTime;//记帐卡有效启用日期

    public TollyCardDate() {
    }

    public TollyCardDate(Date firTime) {
        this.firTime = firTime;
    }

    public Date getFirTime() {
        return this.firTime;
    }
    
    public void setFirTime(Date firTime) {
        this.firTime = firTime;
    }
   








}