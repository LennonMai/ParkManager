package com.hgsoft.entity;

/**
 *  @author qinzuohai
 */

public class LaneOperatorPrivilege  implements java.io.Serializable {

	 /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer operatorNo;//操作员编码 PK
     private String moduleNo;//模块编码PK
     private Short privilege;//权限值

    public LaneOperatorPrivilege() {
    }

    public LaneOperatorPrivilege(Integer operatorNo, String moduleNo, Short privilege) {
    	  this.operatorNo = operatorNo;
          this.moduleNo = moduleNo;
        this.privilege = privilege;
    }

   
    public Integer getOperatorNo() {
        return this.operatorNo;
    }
    
    public void setOperatorNo(Integer operatorNo) {
        this.operatorNo = operatorNo;
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
		 if ( !(other instanceof LaneOperatorPrivilege) ) return false;
		 LaneOperatorPrivilege castOther = ( LaneOperatorPrivilege ) other; 
        
		 return ( (this.getOperatorNo()==castOther.getOperatorNo()) || ( this.getOperatorNo()!=null && castOther.getOperatorNo()!=null && this.getOperatorNo().equals(castOther.getOperatorNo()) ) )
&& ( (this.getModuleNo()==castOther.getModuleNo()) || ( this.getModuleNo()!=null && castOther.getModuleNo()!=null && this.getModuleNo().equals(castOther.getModuleNo()) ) );
  }
  
  public int hashCode() {
        int result = 17;
        
        result = 37 * result + ( getOperatorNo() == null ? 0 : this.getOperatorNo().hashCode() );
        result = 37 * result + ( getModuleNo() == null ? 0 : this.getModuleNo().hashCode() );
        return result;
  }   
}