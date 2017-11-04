package com.hgsoft.thread;


import javax.annotation.Resource;




import com.hgsoft.entity.Sysparamconf;
import com.hgsoft.service.SynDataService;
import com.hgsoft.service.SysparamconfService;
public class SynDataTh extends Thread{
	private boolean flag = true;
	@Resource 
	private SysparamconfService sysparamconfService;
	@Resource 
	private SynDataService synDataService;
	private Sysparamconf synTime;
	private Sysparamconf synFlag;
	//@Resource 
	//private SmsService smsService;
	
	@Override
	public void run(){
	
		while(flag){

					synTime = sysparamconfService.queryOrSave("synTime", "3600", "系统同步白名单和操作人员名单的时间间隔,以秒为单位，默认为3600秒",
							"设置synTime参数时set（），get（）参数时的异常",null);
					synFlag = sysparamconfService.queryOrSave("synFlag", "0", "系统同步白名单和操作人员名单标志位，0为不开启，1为开启，默认为0",
							"设置synFlag参数时set（），get（）参数时的异常",null);
					if(synTime!=null&&synFlag!=null){
					//如果不需要同步则五分钟检查一次参数
					long sleepTime = 300l;//五分钟
					if("1".equals(synFlag.getPvalue())){
						try{
						synDataService.synOperator();
						synDataService.synWhiteList();
						}catch(Exception e){
							System.out.println("数据同步异常");
							e.printStackTrace();
							flag = false;
						}
						try{
							sleepTime = Long.valueOf(synTime.getPvalue());
						}catch( NumberFormatException e){
							System.out.println("synTime值转换异常，已使用默认值3600s");
							sleepTime = 3600l;
						}
					}
					try {
						//1分钟检查一次
						Thread.currentThread().sleep(sleepTime*1000);
					} catch (InterruptedException e) {
						// TODO Auto-generated catch block
						flag = false;
						System.out.println("sms线程中断,,,,,,");
						
					}
				}else{
					
					try {
						//1分钟检查一次
						Thread.currentThread().sleep(60000);
					} catch (InterruptedException e) {
						// TODO Auto-generated catch block
						flag = false;
						System.out.println("sms线程中断,,,,,,");
						
					}
				}
		}
	}

}
