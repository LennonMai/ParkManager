package com.hgsoft.entity;

/**
 * ��������Ա��Ϣ
 * @author qinzuohai
 */

public class LaneOperator  implements java.io.Serializable {
   

     /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer operatorNo;//����Ա���� PK
     private Short areaNo;//�������
     private Short parkNo;//С������
     private String operatorName;//����Ա����
     private String opCardId;//��ݿ���
     private Integer opCardNo;//��ݿ��Ա��
     private String password;//��¼����
     private String status;//״̬

    public LaneOperator() {
    }

    public LaneOperator(Integer operatorNo, Short areaNo, Short parkNo, String operatorName, String opCardId, Integer opCardNo, String password, String status) {
        this.operatorNo = operatorNo;
        this.areaNo = areaNo;
        this.parkNo = parkNo;
        this.operatorName = operatorName;
        this.opCardId = opCardId;
        this.opCardNo = opCardNo;
        this.password = password;
        this.status = status;
    }
    public Integer getOperatorNo() {
        return this.operatorNo;
    }
    
    public void setOperatorNo(Integer operatorNo) {
        this.operatorNo = operatorNo;
    }

    public Short getAreaNo() {
        return this.areaNo;
    }
    
    public void setAreaNo(Short areaNo) {
        this.areaNo = areaNo;
    }

    public Short getParkNo() {
        return this.parkNo;
    }
    
    public void setParkNo(Short parkNo) {
        this.parkNo = parkNo;
    }

    public String getOperatorName() {
        return this.operatorName;
    }
    
    public void setOperatorName(String operatorName) {
        this.operatorName = operatorName;
    }

    public String getOpCardId() {
        return this.opCardId;
    }
    
    public void setOpCardId(String opCardId) {
        this.opCardId = opCardId;
    }

    public Integer getOpCardNo() {
        return this.opCardNo;
    }
    
    public void setOpCardNo(Integer opCardNo) {
        this.opCardNo = opCardNo;
    }

    public String getPassword() {
        return this.password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }

    public String getStatus() {
        return this.status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
   








}