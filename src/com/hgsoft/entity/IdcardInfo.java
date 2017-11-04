package com.hgsoft.entity;

/**
 * TbIdcardInfo entity. @author MyEclipse Persistence Tools
 */

@SuppressWarnings("serial")
public class IdcardInfo implements java.io.Serializable {

	// Fields

	private String idcardNo;
	private String userName;
	private String department;
	private String job;
	private String plateList;
	private String photo;

	// Constructors

	/** default constructor */
	public IdcardInfo() {
	}

	/** minimal constructor */
	public IdcardInfo(String userName, String department, String job, String plateList) {
		this.userName = userName;
		this.department = department;
		this.job = job;
		this.plateList = plateList;
	}

	/** full constructor */
	public IdcardInfo(String userName, String department, String job, String plateList, String photo) {
		this.userName = userName;
		this.department = department;
		this.job = job;
		this.plateList = plateList;
		this.photo = photo;
	}

	// Property accessors

	public String getIdcardNo() {
		return this.idcardNo;
	}

	public void setIdcardNo(String idcardNo) {
		this.idcardNo = idcardNo;
	}

	public String getUserName() {
		return this.userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getDepartment() {
		return this.department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	public String getJob() {
		return this.job;
	}

	public void setJob(String job) {
		this.job = job;
	}

	public String getPlateList() {
		return this.plateList;
	}

	public void setPlateList(String plateList) {
		this.plateList = plateList;
	}

	public String getPhoto() {
		return this.photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

}