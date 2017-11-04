package com.hgsoft.entity;


public class FunctionKey  implements java.io.Serializable {

     /**
	 * 功能键编码
	 */
	private static final long serialVersionUID = 1L;
	private Short functionNo;//PK 功能键编号
    private String functionName;//功能键名称
    private Integer backUp1;//备用
    private Short keyCode;//键值

    public FunctionKey() {
    }

    public FunctionKey(Short functionNo, String functionName, Integer backUp1, Short keyCode) {
        this.functionNo = functionNo;
        this.functionName = functionName;
        this.backUp1 = backUp1;
        this.keyCode = keyCode;
    }


    public Short getFunctionNo() {
        return this.functionNo;
    }
    
    public void setFunctionNo(Short functionNo) {
        this.functionNo = functionNo;
    }

    public String getFunctionName() {
        return this.functionName;
    }
    
    public void setFunctionName(String functionName) {
        this.functionName = functionName;
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