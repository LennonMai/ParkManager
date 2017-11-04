package com.hgsoft.entity;


/**
 * 车道模块信息
 * @author qinzuohai
 */

public class LaneModule  implements java.io.Serializable {
  
     /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String moduleNo;//模块编码 PK
     private String moduleName;//模块名称
     private String remark;//备注

    public LaneModule() {
    }

    public LaneModule(String moduleNo, String moduleName, String remark) {
        this.moduleNo = moduleNo;
        this.moduleName = moduleName;
        this.remark = remark;
    }

    public String getModuleNo() {
        return this.moduleNo;
    }
    
    public void setModuleNo(String moduleNo) {
        this.moduleNo = moduleNo;
    }

    public String getModuleName() {
        return this.moduleName;
    }
    
    public void setModuleName(String moduleName) {
        this.moduleName = moduleName;
    }

    public String getRemark() {
        return this.remark;
    }
    
    public void setRemark(String remark) {
        this.remark = remark;
    }
   








}