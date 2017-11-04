package com.hgsoft.entity;

/**
 * ������ɫ��Ϣ 
 * @author qinzuohai
 */

public class LaneRole  implements java.io.Serializable {

     /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Short roleNo;//��ɫ���� PK
     private String roleName;//��ɫ����
     private String remark;//��ע

    public LaneRole() {
    }

    public LaneRole(Short roleNo, String roleName, String remark) {
        this.roleNo = roleNo;
        this.roleName = roleName;
        this.remark = remark;
    }

    public Short getRoleNo() {
        return this.roleNo;
    }
    
    public void setRoleNo(Short roleNo) {
        this.roleNo = roleNo;
    }

    public String getRoleName() {
        return this.roleName;
    }
    
    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public String getRemark() {
        return this.remark;
    }
    
    public void setRemark(String remark) {
        this.remark = remark;
    }
   








}