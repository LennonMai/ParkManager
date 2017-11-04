package com.hgsoft.entity;

public class CarBrandCode implements java.io.Serializable {

	/**
	 * 车品牌编码
	 */
	private static final long serialVersionUID = 1L;
	private Integer brandNo;//PK 分类编号
	private String brandName;//分类名称

	public CarBrandCode() {
	}

	public CarBrandCode(Integer brandNo, String brandName) {
		this.brandNo = brandNo;
		this.brandName = brandName;
	}

	public Integer getBrandNo() {
		return this.brandNo;
	}

	public void setBrandNo(Integer brandNo) {
		this.brandNo = brandNo;
	}

	public String getBrandName() {
		return this.brandName;
	}

	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}

}