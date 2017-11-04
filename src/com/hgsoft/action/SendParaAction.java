/**
 * 
 */
package com.hgsoft.action;

import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.Writer;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hgsoft.entity.GatewayInformation;
import com.hgsoft.entity.LaneUse;
import com.hgsoft.entity.ParkInformation;
import com.hgsoft.entity.SendPara;
import com.hgsoft.service.GatewayInformationService;
import com.hgsoft.service.LaneUseService;
import com.hgsoft.service.ParkInformationService;
import com.hgsoft.service.SendParaService;
import com.hgsoft.service.SystemLogService;

/**
 * @author qinzuohai
 *
 */
@Controller
@Scope("prototype")
public class SendParaAction extends BaseAction{
	@Resource
	private SystemLogService systemLogService; 
	private SendPara sendPara;

	private Integer typeOneCount;
	private Integer typeTwoCount;
	private List<LaneUse> laneList;
	
	private String Ips;
	private String TableNames;
	private Object[] laneIP;
	private Object[] itemValue;
	private String[] laneNo_ip;
	@Resource
	private SendParaService sendParaService;
	@Resource
	private LaneUseService laneUseService;
	@Resource
	private ParkInformationService parkInformationService;
	@Resource
	private GatewayInformationService gatewayInformationService ;

	private List<ParkInformation> parkList; 
    private List<GatewayInformation> gateList; 
	
	/**
	 * 下发失败列表
	 * @return
	 */
	public String failSendPara(){
		sendPara=new SendPara();
		sendPara.setSendType(Short.valueOf("2"));
		list=sendParaService.findFailSendParaByTypeTwo(pager);
		if(sendParaService.findTypeOnePara()!=null){
			typeOneCount=sendParaService.findTypeOnePara().size();
		}else typeOneCount=0;
		if(sendParaService.findTypeTwoPara()!=null){
			typeTwoCount=sendParaService.findTypeTwoPara().size();
		}else typeTwoCount=0;
		
		return "failSendPara";
	}
	/**
	 * 条件查询
	 * @return
	 */
	public String queryFailSendList(){
		if (!sendPara.getFieldName().equals("")
				|| !sendPara.getFieldValue().equals("")
				|| sendPara.getSendType()!=null
				|| sendPara.getLaneNo()!=null
				|| !sendPara.getLaneComputerIp().equals("")
				|| !sendPara.getTableName().equals("")) {
			
			list=sendParaService.findFailSendParaByCondition(pager, sendPara.getFieldName(), sendPara.getSendType(), sendPara.getFieldValue(), sendPara.getLaneNo(), sendPara.getLaneComputerIp(), sendPara.getTableName());
			if(sendParaService.findTypeOnePara()!=null){
				typeOneCount=sendParaService.findTypeOnePara().size();
			}else typeOneCount=0;
			if(sendParaService.findTypeTwoPara()!=null){
				typeTwoCount=sendParaService.findTypeTwoPara().size();
			}else typeTwoCount=0;
			
		}else {
			return failSendPara();
		}
		
		return "failSendPara";
	}
	
	/**
	 * 条件删除
	 * @return
	 */
	public String deleteFailSendPara(){
		sendParaService.deleteFailSendParaByCondition(sendPara.getFieldName(), sendPara.getSendType(), sendPara.getFieldValue(), sendPara.getLaneNo(), sendPara.getLaneComputerIp(), sendPara.getTableName());
		message="deleteBCSuccess";
		if(sendPara.getSendType()==1){
			list=sendParaService.findFailSendParaByTypeOne(pager);
		}
		if(sendPara.getSendType()==2){
			list=sendParaService.findFailSendParaByTypeTwo(pager);
		}
		if(sendParaService.findTypeOnePara()!=null){
			typeOneCount=sendParaService.findTypeOnePara().size();
		}else typeOneCount=0;
		if(sendParaService.findTypeTwoPara()!=null){
			typeTwoCount=sendParaService.findTypeTwoPara().size();
		}else typeTwoCount=0;
		
		sendPara.setSendType(sendPara.getSendType());
		sendPara.setFieldName("");
		sendPara.setFieldValue("");
		sendPara.setFileName("");
		sendPara.setLaneComputerIp("");
		sendPara.setLaneNo(null);
		sendPara.setTableName("");
		
		return "failSendPara";
	}
	
	/**
	 * 下发参数模块列表
	 * @return
	 */
	public String list(){
		list=sendParaService.findSystemPara();
		laneList=laneUseService.findLaneUseByIsUse();
		parkList=parkInformationService.findParkInformation();
		gateList=gatewayInformationService.findGatewayInformation();
		return "sendPara_list";
	}
	
	/**
	 * 单条删除
	 * @return
	 */
	public String delete(){
		systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户删除下发失败参数["+this.sendPara.getTableName()+"]成功", "删除下发失败参数", "tb_SendPara");
		sendParaService.delete(this.sendPara.getFieldValue(), this.sendPara.getLaneNo(), this.sendPara.getLaneComputerIp(), this.sendPara.getTableName());
		if(this.sendPara.getSendType()==0){
			list=sendParaService.findByPager(pager);
		}else if(this.sendPara.getSendType()==1){
			list=sendParaService.findFailSendParaByTypeOne(pager);
		}else if(this.sendPara.getSendType()==2){
			list=sendParaService.findFailSendParaByTypeTwo(pager);
		}
		message=SUCCESS;
		if(sendParaService.findTypeOnePara()!=null){
			typeOneCount=sendParaService.findTypeOnePara().size();
		}else typeOneCount=0;
		if(sendParaService.findTypeTwoPara()!=null){
			typeTwoCount=sendParaService.findTypeTwoPara().size();
		}else typeTwoCount=0;
		sendPara=null;
		return "failSendPara";
	}
	
	/**
	 * 异步设置下发任务
	 */
	@SuppressWarnings("unchecked")
	public void send(){
		//将传入参数虑空
		laneIP = this.trimArray(this.Ips.split(","));
		itemValue=this.trimArray(this.TableNames.split(","));
		
        HttpServletResponse reponse=ServletActionContext.getResponse();
		if(!this.Ips.toString().equals("")&&!this.TableNames.toString().equals("")){
			SendPara temp=new SendPara();
			short laneNo;
			String laneIP;
			String sendmes="成功设置下发任务信息:\n";
			String line="====================\n";
			StringBuffer sendText=new StringBuffer("");
			
			for(int i=0;i<this.laneIP.length;i++){
				for(int j=0;j<this.itemValue.length;j++){
					
					//将车道号和车道IP的字符串分开
					laneNo_ip=this.laneIP[i].toString().split("_");
					laneNo=Short.valueOf(laneNo_ip[0].trim());
					laneIP=laneNo_ip[1].trim();
					//System.out.println("-"+laneNo+"----"+laneIP+"-");
					
					if(sendParaService.ishasSendMission(laneNo, laneIP, this.itemValue[j].toString())==null){
						temp.setFieldName("0");
						temp.setFieldValue("0");
						temp.setLaneNo(laneNo);
						temp.setLaneComputerIp(laneIP);
						temp.setSendType((short)1);
						temp.setTableName(this.itemValue[j].toString());
						temp.setFileName(this.itemValue[j].toString());
						sendParaService.save(temp);
						sendText.append("车道："+temp.getLaneNo()+"\n"+"车道IP:"+temp.getLaneComputerIp().trim()+"\n"+"参数名:"+sendParaService.findItemByItemValue(temp.getTableName()).trim()+"\n"+"参数值："+temp.getTableName().trim()+"\n \n");
			
					}else{
						//System.out.println("======= 下发任务 删除前 ========"+sendParaService.ishasSendMission(laneNo, laneIP, this.itemValue[j].toString()));
						sendParaService.deletehasSendMission(laneNo, laneIP, this.itemValue[j].toString());
						//System.out.println("======= 下发任务 删除后 ========"+sendParaService.ishasSendMission(laneNo, laneIP, this.itemValue[j].toString()));
						temp.setFieldName("0");
						temp.setFieldValue("0");
						temp.setLaneNo(laneNo);
						temp.setLaneComputerIp(laneIP);
						temp.setSendType((short)1);
						temp.setTableName(this.itemValue[j].toString());
						temp.setFileName(this.itemValue[j].toString());
						sendParaService.save(temp);
						sendText.append("车道："+temp.getLaneNo()+"\n"+"车道IP:"+temp.getLaneComputerIp().trim()+"\n"+"参数名:"+sendParaService.findItemByItemValue(temp.getTableName()).trim()+"\n"+"参数值："+temp.getTableName().trim()+"\n \n");
					} 
				}
			}
			message=line+sendmes+line+sendText.toString();
			systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户下发参数成功", "下发参数", "tb_SendPara");
			
		}else{
			message="没有设置任何下发任务！";
			systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户没有设置任何下发任务", "下发参数", "tb_SendPara");
			
		}
		@SuppressWarnings("rawtypes")
		Map sendMegMap =new HashMap();
		sendMegMap.put("sendMeg", message);
		reponse.setCharacterEncoding("UTF-8");
		this.writerJSON(sendMegMap, reponse);
	}
	

	// @SuppressWarnings("unchecked")
	// public void send(){
	// //将传入参数虑空
	// laneIP = this.trimArray(this.Ips.split(","));
	// itemValue=this.trimArray(this.TableNames.split(","));
	//
	// HttpServletResponse reponse=ServletActionContext.getResponse();
	// if(!this.Ips.toString().equals("")&&!this.TableNames.toString().equals("")){
	// SendPara temp=new SendPara();
	// short laneNo;
	// String laneIP;
	// String sendmes="成功设置下发任务信息:\n";
	// String line1="--------------------\n",line2="====================\n";
	// StringBuffer sendText=new StringBuffer("");
	// String mes=line1+"已存在的下发任务：\n"+line1;
	// StringBuffer hasMission=new StringBuffer("");
	//
	// for(int i=0;i<this.laneIP.length;i++){
	// for(int j=0;j<this.itemValue.length;j++){
	//
	// //将车道号和车道IP的字符串分开
	// laneNo_ip=this.laneIP[i].toString().split("_");
	// laneNo=Short.valueOf(laneNo_ip[0].trim());
	// laneIP=laneNo_ip[1].trim();
	// //System.out.println("-"+laneNo+"----"+laneIP+"-");
	//
	// if(sendParaService.ishasSendMission(laneNo, laneIP,
	// this.itemValue[j].toString())==null){
	// temp.setFieldName("0");
	// temp.setFieldValue("0");
	// temp.setLaneNo(laneNo);
	// temp.setLaneComputerIp(laneIP);
	// temp.setSendType((short)1);
	// temp.setTableName(this.itemValue[j].toString());
	// sendParaService.save(temp);
	// sendText.append("车道："+temp.getLaneNo()+"\n"+"车道IP:"+temp.getLaneComputerIp().trim()+"\n"+"参数名:"+sendParaService.findItemByItemValue(temp.getTableName()).trim()+"\n"+"参数值："+temp.getTableName().trim()+"\n \n");
	//
	// }else{
	// hasMission.append("车道："+laneNo+"\n"+"车道IP:"+laneIP+"\n"+"参数名:"+sendParaService.findItemByItemValue(this.itemValue[j].toString()).trim()+"\n"+"参数值："+this.itemValue[j].toString()+"\n\n");
	// continue;
	// }
	// }
	// }
	// if(hasMission.toString().equals("")){
	// message=line2+sendmes+line2+sendText.toString();
	// }
	// else {
	// if(sendText.toString().equals(""))message=mes+hasMission.toString();
	// else
	// message=mes+hasMission.toString()+"\n"+line2+sendmes+line2+sendText.toString();}
	//
	// }else{
	// message="没有设置任何下发任务！";
	// }
	// @SuppressWarnings("rawtypes")
	// Map sendMegMap =new HashMap();
	// sendMegMap.put("sendMeg", message);
	// reponse.setCharacterEncoding("UTF-8");
	// this.writerJSON(sendMegMap, reponse);
	// }
    /**
     * message写入JSON
     * @param object
     * @param reponse
     * 依赖包jakarta commons-lang 2.4 
	 * jakarta commons-beanutils 1.7.0 
	 * jakarta commons-collections 3.2 
	 * jakarta commons-logging 1.1.1 
	 * ezmorph 1.0.6 
     */
	public void writerJSON(Object object, HttpServletResponse reponse) {
		try {
			reponse=ServletActionContext.getResponse();
			//此方法使用于键值数据类型 ,如Map
			JSONObject jsonObject = JSONObject.fromObject(object); 
			Writer writer = reponse.getWriter();
			//System.out.println("Json Data :" + jsonObject.toString());
			writer.write(jsonObject.toString());
			writer.flush();
			writer.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 将参数导出到TXT文件
	 * @throws ServletException
	 * @throws IOException
	 */
	public void paraToTXT() throws ServletException, IOException{
		itemValue=this.trimArray(this.TableNames.split(","));
		String[] tableNames;
		String[] checkTB_;
		
		HttpServletResponse _response =ServletActionContext.getResponse();   
		_response.setContentType("application/txt");   
		
		for(int j=0;j<itemValue.length;j++){
			
			tableNames=itemValue[j].toString().split(" ");
			checkTB_=tableNames[0].split("_");
			
			//判断是否是正确的表面头
			if(checkTB_[0].equals("tb")||checkTB_[0].equals("TB")||checkTB_[0].equals("Tb")||checkTB_[0].equals("tB")||checkTB_[0].equals("V")||checkTB_[0].equals("v")){
				_response.setHeader("Content-disposition", "attachment;filename="+tableNames[0]+".txt");   
				BufferedOutputStream out = null;    
				try { 
				  //System.out.println("-- 要导出的表："+tableNames[0]);	
					
				  out = new BufferedOutputStream(_response.getOutputStream());
				  if(sendParaService.findTXTdata(tableNames[0])!=null)
					  //System.out.println("=====================:"+sendParaService.findTXTdata(tableNames[0]));
				  out.write(sendParaService.findTXTdata(tableNames[0]).getBytes("GBK")); 
				  systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户将参数["+tableNames[0]+"]导出到TXT文本文件成功", "下发参数", "tb_SendPara");
				  out.flush(); 
				} catch (Exception e) {
					systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户将下发参数导出到TXT文本文件抛出IOException", "下发参数", "IOException");
					e.printStackTrace();   
				} finally {   
				   if (out != null){   
				     out.close();   
				   }   
				}     
			} 
		}	
	}
	
	public void paraToTXTToLane() throws ServletException, IOException{
		itemValue=this.trimArray("V_WHITELIST".split(","));
		String[] tableNames;
		String[] checkTB_;
		
		HttpServletResponse _response =ServletActionContext.getResponse();   
		_response.setContentType("application/txt;charset=gbk");   
		//_response.setCharacterEncoding("gbk");
		for(int j=0;j<itemValue.length;j++){
			
			tableNames=itemValue[j].toString().split(" ");
			checkTB_=tableNames[0].split("_");
			
			//判断是否是正确的表面头
			if(checkTB_[0].equals("tb")||checkTB_[0].equals("TB")||checkTB_[0].equals("Tb")||checkTB_[0].equals("tB")||checkTB_[0].equals("V")||checkTB_[0].equals("v")){
				_response.setHeader("Content-disposition", "attachment;filename=v_WhiteList_recv.txt");   
				BufferedOutputStream out = null;    
				try { 
				  //System.out.println("-- 要导出的表："+tableNames[0]);	
					
				  out = new BufferedOutputStream(_response.getOutputStream());
				  if(sendParaService.findTXTdataToLane(tableNames[0])!=null)
					  //System.out.println("=====================:"+sendParaService.findTXTdata(tableNames[0]));
				  out.write(sendParaService.findTXTdataToLane(tableNames[0]).getBytes("gbk")); 
				  systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户将参数["+tableNames[0]+"]导出到TXT文本文件成功", "下发参数", "tb_SendPara");
				  out.flush(); 
				} catch (Exception e) {
					systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户将下发参数导出到TXT文本文件抛出IOException", "下发参数", "IOException");
					e.printStackTrace();   
				} finally {   
				   if (out != null){   
				     out.close();   
				   }   
				}     
			} 
		}	
	}
	
	
	public void whiteListNoTestWL(){
		try {
			paraToTXTToLane("V_WHITELISTNOTESTWL");
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void paraToTXTToLane(String para) throws ServletException, IOException{
		if(para!=null){
		itemValue=this.trimArray(para.split(","));
		String[] tableNames;
		String[] checkTB_;
		
		HttpServletResponse _response =ServletActionContext.getResponse();   
		_response.setContentType("application/txt;charset=gbk");   
		//_response.setCharacterEncoding("gbk");
		for(int j=0;j<itemValue.length;j++){
			
			tableNames=itemValue[j].toString().split(" ");
			checkTB_=tableNames[0].split("_");
			
			//判断是否是正确的表面头
			if(checkTB_[0].equals("tb")||checkTB_[0].equals("TB")||checkTB_[0].equals("Tb")||checkTB_[0].equals("tB")||checkTB_[0].equals("V")||checkTB_[0].equals("v")){
				_response.setHeader("Content-disposition", "attachment;filename=v_WhiteList_recv.txt");   
				BufferedOutputStream out = null;    
				try { 
				  //System.out.println("-- 要导出的表："+tableNames[0]);	
					
				  out = new BufferedOutputStream(_response.getOutputStream());
				  if(sendParaService.findTXTdataToLane(tableNames[0])!=null)
					  //System.out.println("=====================:"+sendParaService.findTXTdata(tableNames[0]));
				  out.write(sendParaService.findTXTdataToLane(tableNames[0]).getBytes("gbk")); 
				  systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户将参数["+tableNames[0]+"]导出到TXT文本文件成功", "下发参数", "tb_SendPara");
				  out.flush(); 
				} catch (Exception e) {
					systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户将下发参数导出到TXT文本文件抛出IOException", "下发参数", "IOException");
					e.printStackTrace();   
				} finally {   
				   if (out != null){   
				     out.close();   
				   }   
				}     
			} 
		}	
		}
	}
	
	/**
	 * 过滤数组中为空的元素
	 * @param arg
	 * @return
	 */
	public Object[] trimArray(Object[] arg){	
		List<Object> list=Arrays.asList(arg);
		List<Object> li=new ArrayList<Object>();
		String str;
		for(int i=0;i<list.size();i++){
			str=list.get(i).toString().trim();
			if(!str.equals("")){
				li.add(str);
			}
		}
		return li.toArray();
	}
	
	//Getter/Setter
	public void setSendPara(SendPara sendPara) {
		this.sendPara = sendPara;
	}
	public SendPara getSendPara() {
		return sendPara;
	}
	public List<LaneUse> getLaneList() {
		return laneList;
	}
	public void setLaneList(List<LaneUse> laneList) {
		this.laneList = laneList;
	}
	public String getIps() {
		return Ips;
	}
	public void setIps(String ips) {
		Ips = ips;
	}
	public String getTableNames() {
		return TableNames;
	}
	public void setTableNames(String tableNames) {
		TableNames = tableNames;
	}
	public Integer getTypeOneCount() {
		return typeOneCount;
	}
	public void setTypeOneCount(Integer typeOneCount) {
		this.typeOneCount = typeOneCount;
	}
	public Integer getTypeTwoCount() {
		return typeTwoCount;
	}
	public void setTypeTwoCount(Integer typeTwoCount) {
		this.typeTwoCount = typeTwoCount;
	}
	public List<ParkInformation> getParkList() {
		return parkList;
	}
	public void setParkList(List<ParkInformation> parkList) {
		this.parkList = parkList;
	}
	 
	public List<GatewayInformation> getGateList() {
		return gateList;
	}
	public void setGateList(List<GatewayInformation> gateList) {
		this.gateList = gateList;
	}
}
