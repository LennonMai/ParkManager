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

					synTime = sysparamconfService.queryOrSave("synTime", "3600", "ϵͳͬ���������Ͳ�����Ա������ʱ����,����Ϊ��λ��Ĭ��Ϊ3600��",
							"����synTime����ʱset������get��������ʱ���쳣",null);
					synFlag = sysparamconfService.queryOrSave("synFlag", "0", "ϵͳͬ���������Ͳ�����Ա������־λ��0Ϊ��������1Ϊ������Ĭ��Ϊ0",
							"����synFlag����ʱset������get��������ʱ���쳣",null);
					if(synTime!=null&&synFlag!=null){
					//�������Ҫͬ��������Ӽ��һ�β���
					long sleepTime = 300l;//�����
					if("1".equals(synFlag.getPvalue())){
						try{
						synDataService.synOperator();
						synDataService.synWhiteList();
						}catch(Exception e){
							System.out.println("����ͬ���쳣");
							e.printStackTrace();
							flag = false;
						}
						try{
							sleepTime = Long.valueOf(synTime.getPvalue());
						}catch( NumberFormatException e){
							System.out.println("synTimeֵת���쳣����ʹ��Ĭ��ֵ3600s");
							sleepTime = 3600l;
						}
					}
					try {
						//1���Ӽ��һ��
						Thread.currentThread().sleep(sleepTime*1000);
					} catch (InterruptedException e) {
						// TODO Auto-generated catch block
						flag = false;
						System.out.println("sms�߳��ж�,,,,,,");
						
					}
				}else{
					
					try {
						//1���Ӽ��һ��
						Thread.currentThread().sleep(60000);
					} catch (InterruptedException e) {
						// TODO Auto-generated catch block
						flag = false;
						System.out.println("sms�߳��ж�,,,,,,");
						
					}
				}
		}
	}

}
