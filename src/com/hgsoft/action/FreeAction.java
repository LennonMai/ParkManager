package com.hgsoft.action;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hgsoft.entity.SystemLog;
import com.hgsoft.service.FreeService;
import com.hgsoft.service.SystemLogService;

@Controller
@Scope("prototype")
public class FreeAction extends BaseAction{
	@Resource private FreeService freeService;
	@Resource private SystemLogService systemLogService;
	private String cardNo;
	private Integer operateType;
	private Integer cardType;
	public String isSysCard(){
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html;charset=gbk");
		PrintWriter out = null;
		try {
			out = response.getWriter();
			//ͨ�п�
			System.out.println("cardType:"+cardType);
			if(cardType ==1){
				if(freeService.isSysCard(cardNo)){
					String type ="";
					if(operateType==11)type="�Է�";
					else if(operateType==12)type="����";
					else if(operateType==13)type="ס��";
					SystemLog sl = new SystemLog();
					sl.setLogData("ͨ�п�����:"+cardNo+"��������ͣ�"+type);
					sl.setLogType(3);
					sl.setLogTime(new Date());
					sl.setOperatorID(this.getCurrentOperator().getId());
					systemLogService.save(sl);
					out.print("TRUE,"+df.format(new Date()));
			}else out.print("FALSE");	
			}
			else if(cardType ==2){//��ͨ���ж��Ƿ����ڲ���������
				if(freeService.isWhiteListCard(cardNo)){
					String type ="";
					if(operateType==11)type="�Է�";
					else if(operateType==12)type="����";
					else if(operateType==13)type="ס��";
					SystemLog sl = new SystemLog();
					sl.setLogData("��ͨ������:"+cardNo+"��������ͣ�"+type);
					sl.setLogType(3);
					sl.setLogTime(new Date());
					sl.setOperatorID(this.getCurrentOperator().getId());
					systemLogService.save(sl);
					out.print("TRUE,"+df.format(new Date()));
				}else out.print("FALSE");
			}else {
				out.print("UNKNOWTYPE");	
			}
		}
		catch(Exception e){
			out.print("EXCEPTION");	
			e.printStackTrace();
		}
		return null;
	}
	
	public String index(){
		return "index";
	}
	public String getCardNo() {
		return cardNo;
	}
	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}
	public Integer getOperateType() {
		return operateType;
	}
	public void setOperateType(Integer operateType) {
		this.operateType = operateType;
	}

	public Integer getCardType() {
		return cardType;
	}

	public void setCardType(Integer cardType) {
		this.cardType = cardType;
	}
	
	
}
