package com.hgsoft.entity;


/**
 * 角色模块信息
 *  @author qinzuohai
 */

public class LaneRoleModule  implements java.io.Serializable {

	 /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Short roleNo;//角色编码,PK
     private String moduleNo;//模块编码,PK
     private Short privilege;//权限值


    /** default constructor */
    public LaneRoleModule() {
    }

    /** full constructor */
    public LaneRoleModule(Short roleNo, String moduleNo, Short privilege) {
    	this.roleNo = roleNo;
        this.moduleNo = moduleNo;
        this.privilege = privilege;
    }

   

    public Short getRoleNo() {
        return this.roleNo;
    }
    
    public void setRoleNo(Short roleNo) {
        this.roleNo = roleNo;
    }

    public String getModuleNo() {
        return this.moduleNo;
    }
    
    public void setModuleNo(String moduleNo) {
        this.moduleNo = moduleNo;
    }
   

    public Short getPrivilege() {
        return this.privilege;
    }
    
    public void setPrivilege(Short privilege) {
        this.privilege = privilege;
    }
   
    public boolean equals(Object other) {
        if ( (this == other ) ) return true;
		 if ( (other == null ) ) return false;
		 if ( !(other instanceof LaneRoleModule) ) return false;
		 LaneRoleModule castOther = ( LaneRoleModule ) other; 
        
		 return ( (this.getRoleNo()==castOther.getRoleNo()) || ( this.getRoleNo()!=null && castOther.getRoleNo()!=null && this.getRoleNo().equals(castOther.getRoleNo()) ) )
&& ( (this.getModuleNo()==castOther.getModuleNo()) || ( this.getModuleNo()!=null && castOther.getModuleNo()!=null && this.getModuleNo().equals(castOther.getModuleNo()) ) );
  }
  
  public int hashCode() {
        int result = 17;
        
        result = 37 * result + ( getRoleNo() == null ? 0 : this.getRoleNo().hashCode() );
        result = 37 * result + ( getModuleNo() == null ? 0 : this.getModuleNo().hashCode() );
        return result;
  }   
}