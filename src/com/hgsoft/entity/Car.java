package com.hgsoft.entity;

import java.io.Serializable;

public class Car implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer sys_id;//�������(�Զ�������)
	private String vehPlate;//���ƺ�
	private Integer carType;//�������ͣ�����7.22_��Ӫ����ϵͳ���ݿ����_100722�¸�Ԩ.doc�б�ע��
	private String carColour;//������ɫ
	public Integer getSys_id() {
		return sys_id;
	}
	public void setSys_id(Integer sys_id) {
		this.sys_id = sys_id;
	}
	
	public String getVehPlate() {
		return vehPlate;
	}
	public void setVehPlate(String vehPlate) {
		this.vehPlate = vehPlate;
	}
	public Integer getCarType() {
		return carType;
	}
	public void setCarType(Integer carType) {
		this.carType = carType;
	}
	public String getCarColour() {
		return carColour;
	}
	public void setCarColour(String carColour) {
		this.carColour = carColour;
	}
	
	

}
