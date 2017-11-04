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
	 * �·�ʧ���б�
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
	 * ������ѯ
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
	 * ����ɾ��
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
	 * �·�����ģ���б�
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
	 * ����ɾ��
	 * @return
	 */
	public String delete(){
		systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û�ɾ���·�ʧ�ܲ���["+this.sendPara.getTableName()+"]�ɹ�", "ɾ���·�ʧ�ܲ���", "tb_SendPara");
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
	 * �첽�����·�����
	 */
	@SuppressWarnings("unchecked")
	public void send(){
		//����������ǿ�
		laneIP = this.trimArray(this.Ips.split(","));
		itemValue=this.trimArray(this.TableNames.split(","));
		
        HttpServletResponse reponse=ServletActionContext.getResponse();
		if(!this.Ips.toString().equals("")&&!this.TableNames.toString().equals("")){
			SendPara temp=new SendPara();
			short laneNo;
			String laneIP;
			String sendmes="�ɹ������·�������Ϣ:\n";
			String line="====================\n";
			StringBuffer sendText=new StringBuffer("");
			
			for(int i=0;i<this.laneIP.length;i++){
				for(int j=0;j<this.itemValue.length;j++){
					
					//�������źͳ���IP���ַ����ֿ�
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
						sendText.append("������"+temp.getLaneNo()+"\n"+"����IP:"+temp.getLaneComputerIp().trim()+"\n"+"������:"+sendParaService.findItemByItemValue(temp.getTableName()).trim()+"\n"+"����ֵ��"+temp.getTableName().trim()+"\n \n");
			
					}else{
						//System.out.println("======= �·����� ɾ��ǰ ========"+sendParaService.ishasSendMission(laneNo, laneIP, this.itemValue[j].toString()));
						sendParaService.deletehasSendMission(laneNo, laneIP, this.itemValue[j].toString());
						//System.out.println("======= �·����� ɾ���� ========"+sendParaService.ishasSendMission(laneNo, laneIP, this.itemValue[j].toString()));
						temp.setFieldName("0");
						temp.setFieldValue("0");
						temp.setLaneNo(laneNo);
						temp.setLaneComputerIp(laneIP);
						temp.setSendType((short)1);
						temp.setTableName(this.itemValue[j].toString());
						temp.setFileName(this.itemValue[j].toString());
						sendParaService.save(temp);
						sendText.append("������"+temp.getLaneNo()+"\n"+"����IP:"+temp.getLaneComputerIp().trim()+"\n"+"������:"+sendParaService.findItemByItemValue(temp.getTableName()).trim()+"\n"+"����ֵ��"+temp.getTableName().trim()+"\n \n");
					} 
				}
			}
			message=line+sendmes+line+sendText.toString();
			systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û��·������ɹ�", "�·�����", "tb_SendPara");
			
		}else{
			message="û�������κ��·�����";
			systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û�û�������κ��·�����", "�·�����", "tb_SendPara");
			
		}
		@SuppressWarnings("rawtypes")
		Map sendMegMap =new HashMap();
		sendMegMap.put("sendMeg", message);
		reponse.setCharacterEncoding("UTF-8");
		this.writerJSON(sendMegMap, reponse);
	}
	

	// @SuppressWarnings("unchecked")
	// public void send(){
	// //����������ǿ�
	// laneIP = this.trimArray(this.Ips.split(","));
	// itemValue=this.trimArray(this.TableNames.split(","));
	//
	// HttpServletResponse reponse=ServletActionContext.getResponse();
	// if(!this.Ips.toString().equals("")&&!this.TableNames.toString().equals("")){
	// SendPara temp=new SendPara();
	// short laneNo;
	// String laneIP;
	// String sendmes="�ɹ������·�������Ϣ:\n";
	// String line1="--------------------\n",line2="====================\n";
	// StringBuffer sendText=new StringBuffer("");
	// String mes=line1+"�Ѵ��ڵ��·�����\n"+line1;
	// StringBuffer hasMission=new StringBuffer("");
	//
	// for(int i=0;i<this.laneIP.length;i++){
	// for(int j=0;j<this.itemValue.length;j++){
	//
	// //�������źͳ���IP���ַ����ֿ�
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
	// sendText.append("������"+temp.getLaneNo()+"\n"+"����IP:"+temp.getLaneComputerIp().trim()+"\n"+"������:"+sendParaService.findItemByItemValue(temp.getTableName()).trim()+"\n"+"����ֵ��"+temp.getTableName().trim()+"\n \n");
	//
	// }else{
	// hasMission.append("������"+laneNo+"\n"+"����IP:"+laneIP+"\n"+"������:"+sendParaService.findItemByItemValue(this.itemValue[j].toString()).trim()+"\n"+"����ֵ��"+this.itemValue[j].toString()+"\n\n");
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
	// message="û�������κ��·�����";
	// }
	// @SuppressWarnings("rawtypes")
	// Map sendMegMap =new HashMap();
	// sendMegMap.put("sendMeg", message);
	// reponse.setCharacterEncoding("UTF-8");
	// this.writerJSON(sendMegMap, reponse);
	// }
    /**
     * messageд��JSON
     * @param object
     * @param reponse
     * ������jakarta commons-lang 2.4 
	 * jakarta commons-beanutils 1.7.0 
	 * jakarta commons-collections 3.2 
	 * jakarta commons-logging 1.1.1 
	 * ezmorph 1.0.6 
     */
	public void writerJSON(Object object, HttpServletResponse reponse) {
		try {
			reponse=ServletActionContext.getResponse();
			//�˷���ʹ���ڼ�ֵ�������� ,��Map
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
	 * ������������TXT�ļ�
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
			
			//�ж��Ƿ�����ȷ�ı���ͷ
			if(checkTB_[0].equals("tb")||checkTB_[0].equals("TB")||checkTB_[0].equals("Tb")||checkTB_[0].equals("tB")||checkTB_[0].equals("V")||checkTB_[0].equals("v")){
				_response.setHeader("Content-disposition", "attachment;filename="+tableNames[0]+".txt");   
				BufferedOutputStream out = null;    
				try { 
				  //System.out.println("-- Ҫ�����ı�"+tableNames[0]);	
					
				  out = new BufferedOutputStream(_response.getOutputStream());
				  if(sendParaService.findTXTdata(tableNames[0])!=null)
					  //System.out.println("=====================:"+sendParaService.findTXTdata(tableNames[0]));
				  out.write(sendParaService.findTXTdata(tableNames[0]).getBytes("GBK")); 
				  systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û�������["+tableNames[0]+"]������TXT�ı��ļ��ɹ�", "�·�����", "tb_SendPara");
				  out.flush(); 
				} catch (Exception e) {
					systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û����·�����������TXT�ı��ļ��׳�IOException", "�·�����", "IOException");
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
			
			//�ж��Ƿ�����ȷ�ı���ͷ
			if(checkTB_[0].equals("tb")||checkTB_[0].equals("TB")||checkTB_[0].equals("Tb")||checkTB_[0].equals("tB")||checkTB_[0].equals("V")||checkTB_[0].equals("v")){
				_response.setHeader("Content-disposition", "attachment;filename=v_WhiteList_recv.txt");   
				BufferedOutputStream out = null;    
				try { 
				  //System.out.println("-- Ҫ�����ı�"+tableNames[0]);	
					
				  out = new BufferedOutputStream(_response.getOutputStream());
				  if(sendParaService.findTXTdataToLane(tableNames[0])!=null)
					  //System.out.println("=====================:"+sendParaService.findTXTdata(tableNames[0]));
				  out.write(sendParaService.findTXTdataToLane(tableNames[0]).getBytes("gbk")); 
				  systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û�������["+tableNames[0]+"]������TXT�ı��ļ��ɹ�", "�·�����", "tb_SendPara");
				  out.flush(); 
				} catch (Exception e) {
					systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û����·�����������TXT�ı��ļ��׳�IOException", "�·�����", "IOException");
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
			
			//�ж��Ƿ�����ȷ�ı���ͷ
			if(checkTB_[0].equals("tb")||checkTB_[0].equals("TB")||checkTB_[0].equals("Tb")||checkTB_[0].equals("tB")||checkTB_[0].equals("V")||checkTB_[0].equals("v")){
				_response.setHeader("Content-disposition", "attachment;filename=v_WhiteList_recv.txt");   
				BufferedOutputStream out = null;    
				try { 
				  //System.out.println("-- Ҫ�����ı�"+tableNames[0]);	
					
				  out = new BufferedOutputStream(_response.getOutputStream());
				  if(sendParaService.findTXTdataToLane(tableNames[0])!=null)
					  //System.out.println("=====================:"+sendParaService.findTXTdata(tableNames[0]));
				  out.write(sendParaService.findTXTdataToLane(tableNames[0]).getBytes("gbk")); 
				  systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û�������["+tableNames[0]+"]������TXT�ı��ļ��ɹ�", "�·�����", "tb_SendPara");
				  out.flush(); 
				} catch (Exception e) {
					systemLogService.save(new Date(), 1, getCurrentOperator(), "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"�û����·�����������TXT�ı��ļ��׳�IOException", "�·�����", "IOException");
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
	 * ����������Ϊ�յ�Ԫ��
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
