package com.hgsoft.entity;



public class VehClassCode  implements java.io.Serializable {


    /**
	 * ���ֱ���
	 */
	private static final long serialVersionUID = 1L;


     private Short vehClassNo;//PK ���ֱ���
     private String vehClassName;//��������
     private Integer backUp1;//����
     private Short keyCode;//������


    public VehClassCode() {
    }

    public VehClassCode(Short vehClassNo, String vehClassName, Integer backUp1, Short keyCode) {
        this.vehClassNo = vehClassNo;
        this.vehClassName = vehClassName;
        this.backUp1 = backUp1;
        this.keyCode = keyCode;
    }


    public Short getVehClassNo() {
        return this.vehClassNo;
    }
    
    public void setVehClassNo(Short vehClassNo) {
        this.vehClassNo = vehClassNo;
    }

    public String getVehClassName() {
        return this.vehClassName;
    }
    
    public void setVehClassName(String vehClassName) {
        this.vehClassName = vehClassName;
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