package com.hgsoft.entity;

public class VehTypeCode  implements java.io.Serializable {
  
     /**
	 * ���ͱ���
	 */
	private static final long serialVersionUID = 1L;
	private Short vehTypeNo;//PK ���ͱ���
     private String vehTypeName;//��������
     private Integer backUp1;//����
     private Short keyCode;//������

    public VehTypeCode() {
    }

    public VehTypeCode(Short vehTypeNo, String vehTypeName, Integer backUp1, Short keyCode) {
        this.vehTypeNo = vehTypeNo;
        this.vehTypeName = vehTypeName;
        this.backUp1 = backUp1;
        this.keyCode = keyCode;
    }


    public Short getVehTypeNo() {
        return this.vehTypeNo;
    }
    
    public void setVehTypeNo(Short vehTypeNo) {
        this.vehTypeNo = vehTypeNo;
    }

    public String getVehTypeName() {
        return this.vehTypeName;
    }
    
    public void setVehTypeName(String vehTypeName) {
        this.vehTypeName = vehTypeName;
    }

    public Integer getBackUp1() {
        return this.backUp1;
    }
    
    public void setBackUp1(Integer backUp1) {
        this.backUp1 = backUp1;
    }

    public Short getKeyCode() {
        return this.keyCode;
    }
    
    public void setKeyCode(Short keyCode) {
        this.keyCode = keyCode;
    }
   



}