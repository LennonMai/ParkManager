package com.hgsoft.entity;


public class DeviceCode  implements java.io.Serializable {


     /**
	 * �豸����
	 */
	private static final long serialVersionUID = 1L;
	private Short deviceNo;//PK �豸���
     private String deviceName;//�豸����


    public DeviceCode() {
    }

    public DeviceCode(Short deviceNo, String deviceName) {
        this.deviceNo = deviceNo;
        this.deviceName = deviceName;
    }


    public Short getDeviceNo() {
        return this.deviceNo;
    }
    
    public void setDeviceNo(Short deviceNo) {
        this.deviceNo = deviceNo;
    }

    public String getDeviceName() {
        return this.deviceName;
    }
    
    public void setDeviceName(String deviceName) {
        this.deviceName = deviceName;
    }
   

}