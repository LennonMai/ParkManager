package com.hgsoft.entity;

import java.util.Date;


public class StoreCardDate  implements java.io.Serializable {


    /**
	 * ��ֵ����Ч��������
	 */
	private static final long serialVersionUID = 1L;
     private Date firTime;//��ֵ����Ч��������

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