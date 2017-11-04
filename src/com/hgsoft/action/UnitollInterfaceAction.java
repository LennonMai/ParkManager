package com.hgsoft.action;

import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hgsoft.entity.AccountAgentExportLog;
import com.hgsoft.entity.AccountAgentExportLogTemp;
import com.hgsoft.entity.AccountAgentImportLog;
import com.hgsoft.entity.OwnerIncomeSum;
import com.hgsoft.entity.UnitollIntfUpload;
import com.hgsoft.service.AccountAgentExportLogService;
import com.hgsoft.service.AccountAgentImportLogService;
import com.hgsoft.service.OwnerIncomeSumService;
import com.hgsoft.service.SystemLogService;
import com.hgsoft.service.UnitollIntfUploadService;
import com.hgsoft.util.ExcelUtil;

/**
 * @author caijunhua
 * @date June 21, 2011
 * @Description 粤通卡接口
 */

@Controller
@Scope("prototype")
public class UnitollInterfaceAction extends BaseAction {
	
	@Resource private OwnerIncomeSumService ownerIncomeSumService;
	@Resource private AccountAgentExportLogService accountAgentExportLogService;
	@Resource private AccountAgentImportLogService accountAgentImportLogService;
	@Resource private UnitollIntfUploadService unitollIntfUploadService;	
	@Resource
	private SystemLogService systemLogService;
	
	private OwnerIncomeSum OwnerIncomeSum;
	private AccountAgentExportLog accountAgentExportLog;
	private AccountAgentImportLog accountAgentImportLog;
	
	@SuppressWarnings("unchecked")public List ownerIncomeSumList;
	@SuppressWarnings("unchecked")public List<AccountAgentExportLog> accountAgentExportLogList;
	@SuppressWarnings("unchecked")public List accountAgentImportLogList;
	@SuppressWarnings("unchecked")public List  packNoList;
	private List<UnitollIntfUpload> unitollIntfUploadList;
	
	private UnitollIntfUpload unitollIntfUpload;	
	
	private String startTime;
	private String endTime;
	private String PackNo;
	
	public String getPackNo() {
		return PackNo;
	}
	public void setPackNo(String packNo) {
		PackNo = packNo;
	}
	//业主收支金额汇总查询
	public String listOwnerIncomeSum() {
		ownerIncomeSumList = ownerIncomeSumService.findOwnerIncomeSumByHql(pager, startTime, endTime);
		return "listOwnerIncomeSum";
	}
	//粤通卡接口数据导出日志查询
	public String listAccountAgentExportLog() {
		
		
		packNoList=accountAgentExportLogService.getPackNo();
		accountAgentExportLogList = accountAgentExportLogService.findAccountAgentExportLogByHql(pager, startTime, endTime,PackNo);
		return "listAccountAgentExportLog";
	}
	//粤通卡接口数据导入日志查询
	public String listAccountAgentImportLog() {
		accountAgentImportLogList = accountAgentImportLogService.findAccountAgentImportLogByHql(pager, startTime, endTime);
		return "listAccountAgentImportLog";
	}
	//导出Excel
	@SuppressWarnings("unchecked")
	public void ExportExecl() throws IOException
	{
		packNoList=accountAgentExportLogService.getPackNo();
		accountAgentExportLogList = accountAgentExportLogService.findAccountAgentExportLogByHql(null, startTime, endTime,PackNo);
		List<AccountAgentExportLogTemp> AccountAgentExportLogList=new ArrayList<AccountAgentExportLogTemp>();
		int size=accountAgentExportLogList.size();
		for(int i=0;i<size;i++)
		{
			AccountAgentExportLogTemp accountAgentExportLogTemp=new AccountAgentExportLogTemp();
			accountAgentExportLogTemp.setFileName(accountAgentExportLogList.get(i).getFileName());
			accountAgentExportLogTemp.setOpTime(accountAgentExportLogList.get(i).getOpTime());
			accountAgentExportLogTemp.setPackNo(accountAgentExportLogList.get(i).getPackNo());
			accountAgentExportLogTemp.setRecCount(accountAgentExportLogList.get(i).getRecCount());
			accountAgentExportLogTemp.setSquadDate(accountAgentExportLogList.get(i).getSquadDate());
			accountAgentExportLogTemp.setTotalMoney(accountAgentExportLogList.get(i).getTotalMoney());
			AccountAgentExportLogList.add(accountAgentExportLogTemp);
		}
		
		ExcelUtil<AccountAgentExportLogTemp> _excelUtil = new ExcelUtil<AccountAgentExportLogTemp>();
		HttpServletResponse response=ServletActionContext.getResponse();
		response.addHeader("Content-Disposition", "attachment;filename=Log.xls");
		response.addHeader("Pragma","no-cache");
    	response.addHeader("Cache-Control","no-cache");	
    	String[] headers = {"工班日期","数据包编号","操作时间","文件名","数据记录数","收费金额数"};
    	OutputStream out = response.getOutputStream();
    	_excelUtil.exportExcel(headers,AccountAgentExportLogList, out);
    	out.close();
		
	}
	public String listUnitollIntfUpload(){
		unitollIntfUploadList = unitollIntfUploadService.findUnitollIntfUploadByHql(pager, startTime, endTime,unitollIntfUpload);
		return "listUnitollIntfUpload";
	}
	public String deleteUnitollIntfUpload(){
		unitollIntfUploadService.deleteById(unitollIntfUpload.getSquadDate());
	return this.listUnitollIntfUpload();
}	
	
	/*
	 * 导出上传记录到excel
	 * caikaiyi
	 * 2014-8-29
	 */
	@SuppressWarnings("unchecked")
	public String exportUnitollIntfUpload(){
		String filed = "squadDate,isUpload,recCount,totalMoney,opTime";
		String[] headers = new String[]{"工班日期","是否上传","流水总数","总金额","操作时间"};

		Map map = new HashMap();//将查询条件放到map中，方便传参
		map.put("startTime", startTime);
		map.put("endTime", endTime);
		map.put("isUpload", unitollIntfUpload.getIsUpload());
		list = unitollIntfUploadService.export(filed, map);
		int size = list.size();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		for(int i=0; i<size; i++){
			Map m = (Map)list.get(i);
			Integer isUpload = (Integer)m.get("isUpload");
			if(isUpload!=null){
				if("0".equals(isUpload.toString())){
					m.put("isUpload", "否");
				}else if("1".equals(isUpload.toString())){
					m.put("isUpload", "是");
				}
			}
			Date squadDate = (Date)m.get("squadDate");
			m.put("squadDate", sdf.format(squadDate));
			
			Date opTime = (Date)m.get("opTime");
			m.put("opTime", sdf2.format(opTime));		
			
		}
		try{
			HttpServletResponse response = ServletActionContext.getResponse();
	  	  	response.setContentType("octets/stream");//简单可以设置为信息流
	  	  	SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
	  	  	String title = "UnitollIntfUpload"+format.format(new Date())+".xls";
		    response.addHeader("Content-Disposition", "attachment;filename="+title);	      
		    //客户端不缓存
		    response.addHeader("Pragma","no-cache");
		    response.addHeader("Cache-Control","no-cache");
		    ExcelUtil<Object[]> _excelUtil = new ExcelUtil<Object[]>();
	        OutputStream out = response.getOutputStream();
	        _excelUtil.expExcel("粤通卡上传记录", headers, list, out, 5000, null, null);
	        systemLogService.save(new Date(), 1,this.getCurrentOperator() , "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户导出粤通卡上传记录成功", "粤通卡上传记录-导出", "UnitollIntfUpload"+format.format(new Date())+".xls");
	        out.close();
		}catch (IOException e) {
	    	  systemLogService.save(new Date(), 2, getCurrentOperator(),  "["+this.getCurrentOperator().getId()+"]"+this.getCurrentOperator().getUsername()+"用户将粤通卡上传记录导出到Excel时抛出的IO异常", "粤通卡上传记录-导出", "IOException");
			  e.printStackTrace();
	      }
		return null;
	}
		
	
	// Getter/Setter方法
	public OwnerIncomeSum getOwnerIncomeSum() {
		return OwnerIncomeSum;
	}
	public void setOwnerIncomeSum(OwnerIncomeSum ownerIncomeSum) {
		OwnerIncomeSum = ownerIncomeSum;
	}
	public AccountAgentExportLog getAccountAgentExportLog() {
		return accountAgentExportLog;
	}
	public void setAccountAgentExportLog(AccountAgentExportLog accountAgentExportLog) {
		this.accountAgentExportLog = accountAgentExportLog;
	}
	public AccountAgentImportLog getAccountAgentImportLog() {
		return accountAgentImportLog;
	}
	public void setAccountAgentImportLog(AccountAgentImportLog accountAgentImportLog) {
		this.accountAgentImportLog = accountAgentImportLog;
	}
	@SuppressWarnings("unchecked")
	public List getOwnerIncomeSumList() {
		return ownerIncomeSumList;
	}
	@SuppressWarnings("unchecked")
	public void setOwnerIncomeSumList(List ownerIncomeSumList) {
		this.ownerIncomeSumList = ownerIncomeSumList;
	}
	@SuppressWarnings("unchecked")
	public List getAccountAgentExportLogList() {
		return accountAgentExportLogList;
	}
	@SuppressWarnings("unchecked")
	public void setAccountAgentExportLogList(List accountAgentExportLogList) {
		this.accountAgentExportLogList = accountAgentExportLogList;
	}
	@SuppressWarnings("unchecked")
	public List getAccountAgentImportLogList() {
		return accountAgentImportLogList;
	}
	@SuppressWarnings("unchecked")
	public void setAccountAgentImportLogList(List accountAgentImportLogList) {
		this.accountAgentImportLogList = accountAgentImportLogList;
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
	public List<UnitollIntfUpload> getUnitollIntfUploadList() {
		return unitollIntfUploadList;
	}
	public UnitollIntfUpload getUnitollIntfUpload() {
		return unitollIntfUpload;
	}
	public void setUnitollIntfUpload(UnitollIntfUpload unitollIntfUpload) {
		this.unitollIntfUpload = unitollIntfUpload;
	}	
}
