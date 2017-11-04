package com.hgsoft.entity;

/**
 * ���������
 */
public class CarClassCode implements java.io.Serializable {

	private static final long serialVersionUID = 1L;

	private Integer classNo;//PK ������
	private String className;//��������

	public CarClassCode() {
	}

	public CarClassCode(Integer classNo, String className) {
		this.classNo = classNo;
		this.className = className;
	}

	public Integer getClassNo() {
		return this.classNo;
	}

	public void setClassNo(Integer classNo) {
		this.classNo = classNo;
	}

	public String getClassName() {
		return this.className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

}