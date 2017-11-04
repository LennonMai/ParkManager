package com.hgsoft.entity;


public class DeviceCode  implements java.io.Serializable {


     /**
	 * 设备编码
	 */
	private static final long serialVersionUID = 1L;
	private Short deviceNo;//PK 设备编号
     private String deviceName;//设备名称


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