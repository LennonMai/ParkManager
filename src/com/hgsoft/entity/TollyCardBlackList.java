package com.hgsoft.entity;

import java.util.Date;

public class TollyCardBlackList  implements java.io.Serializable {

     /**
	 * ���ʿ�������
	 */
	private static final long serialVersionUID = 1L;
	private String accode;//���������ʿ�����
     private String genCau;//ʧЧԭ��
     private Date genTime;//ʧЧ����

    public TollyCardBlackList() {
    }

    public TollyCardBlackList(String accode, String genCau, Date genTime) {
        this.accode = accode;
        this.genCau = genCau;
        this.genTime = genTime;
    }

    public String getAccode() {
        return this.accode;
    }
    
    public void setAccode(String accode) {
        this.accode = accode;
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