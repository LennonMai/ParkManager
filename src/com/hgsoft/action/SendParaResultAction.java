package com.hgsoft.action;

import java.util.Date;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hgsoft.entity.SendParaResult;
import com.hgsoft.service.SendParaResultService;

@Controller
@Scope("prototype")
public class SendParaResultAction extends BaseAction{

	private SendParaResult sendParaResult;
	private String startTime;
	private String endTime;
	@Resource
	private SendParaResultService sendParaResultService;
	
	public String list(){
		list=sendParaResultService.findByPager(pager);
		return "list";
	}
	public String query(){
		
		/*if (!sendParaResult.getFieldName().equals("")
				|| !sendParaResult.getFieldValue().equals("")
				|| sendParaResult.getSendType()!=null
				|| sendParaResult.getLaneNo()!=null
				|| !sendParaResult.getLaneComputerIp().equals("")
				|| !sendParaResult.getTableName().equals("")
				|| !sendParaResult.getFileName().equals("")) */
	   if(!"".equals(sendParaResult.getFieldName()) || !"".equals(sendParaResult.getFieldValue()) || null != sendParaResult.getSendType() || null != sendParaResult.getLaneNo() 
			   || !"".equals(sendParaResult.getLaneComputerIp())  || !"".equals(sendParaResult.getTableName())  || !"".equals(sendParaResult.getFileName()) || null != sendParaResult.getSendResult()|| !"".equals(startTime)|| !"".equals(endTime))
		{			
			list=sendParaResultService.findByCondition(pager, sendParaResult.getFieldName(), sendParaResult.getSendType(), sendParaResult.getFieldValue(), sendParaResult.getLaneNo(), sendParaResult.getLaneComputerIp(), sendParaResult.getTableName(),sendParaResult.getFileName(),sendParaResult.getSendResult(),startTime,endTime);
			return "list";
		}else {
			return list();
		}
	}
	
	public String delete(){
		sendParaResultService.delete(sendParaResult.getFieldValue(), sendParaResult.getLaneNo(), sendParaResult.getLaneComputerIp(), sendParaResult.getTableName());
		message="deleteSuccess";
		sendParaResult=null;
		return list();
	}
	
	public String deleteByCondition(){
		System.out.println();
		sendParaResultService.deleteByCondition(sendParaResult.getFieldName(), sendParaResult.getSendType(), sendParaResult.getFieldValue(), sendParaResult.getLaneNo(), sendParaResult.getLaneComputerIp(), sendParaResult.getTableName(),sendParaResult.getFileName(),sendParaResult.getSendResult(),startTime,endTime);
		message="deleteBCSuccess";
		sendParaResult=null;
		startTime =null;
		endTime = null;
		return list();
	}
	
	
	public SendParaResult getSendParaResult() {
		return sendParaResult;
	}
	public void setSendParaResult(SendParaResult sendParaResult) {
		this.sendParaResult = sendParaResult;
	}
	
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	

}
