package com.hgsoft.entity;
import java.util.Date;

public class TollyCardDate  implements java.io.Serializable {

    /**
	 * ���ʿ���Ч��������
	 */
	private static final long serialVersionUID = 1L;

     private Date firTime;//���ʿ���Ч��������

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