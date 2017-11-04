package com.hgsoft.action;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.export.JRHtmlExporter;
import net.sf.jasperreports.engine.export.JRHtmlExporterParameter;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hgsoft.entity.Account;
import com.hgsoft.entity.Admin;
import com.hgsoft.entity.Car;
import com.hgsoft.entity.Operator;
import com.hgsoft.entity.ParkInformation;
import com.hgsoft.entity.Sysparamconf;
import com.hgsoft.entity.SystemLog;
import com.hgsoft.entity.User;
import com.hgsoft.service.AdminService;
import com.hgsoft.service.LaneInformationService;
import com.hgsoft.service.OperatorService;
import com.hgsoft.service.ParkInformationService;
import com.hgsoft.service.ReportService;
import com.hgsoft.service.SquadInformationService;
import com.hgsoft.service.SysparamconfService;
import com.hgsoft.service.SystemLogService;

/**
 * @author caijunhua
 * @date October 26, 2010
 * @Description 通行费报表控制器
 */

@Controller
@Scope("prototype")
public class TollsReportAction extends BaseAction {
	@Resource
	private ReportService reportService;
	@Resource
	private SystemLogService systemLogService;
	@Resource
	private AdminService adminService;
	@Resource
	private SysparamconfService sysparamconfService;
	@Resource
	private OperatorService operatorService;
	@Resource
	private SquadInformationService squadInformationService;
	@Resource 
	private ParkInformationService parkInformationService;
	@Resource 
	private LaneInformationService laneInformationService;
	
	
	private SystemLog systemlog;
	private Admin admin;
	private User user;
	private Account account;
	private Car car;
	private Operator laneOperator;
	private Sysparamconf setAreaNo;
	private Sysparamconf setParkNo;
	
	private String startTime;
	private String endTime;	
	private String tradeType;
	private String pSquadNo;
	private String pOperatorNo;
	private String pLaneNo;
	private String jasper;
	private String jasperPDF;
	private String parkString;
	private Integer parkNo;
	
	private List<ParkInformation> parkList;
	@SuppressWarnings("unchecked")
	private List squadList;
	@SuppressWarnings("unchecked")
	public List getSquadList() {
		return squadList;
	}
	
	@SuppressWarnings("unchecked")
	private List laneList;
	@SuppressWarnings("unchecked")
	public List getLaneList() {
		return laneList;
	}
	
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setTradeType(String tradeType) {
		this.tradeType = tradeType;
	}
	public void setPSquadNo(String squadNo) {
		pSquadNo = squadNo;
	}
	public void setPOperatorNo(String operatorNo) {
		pOperatorNo = operatorNo;
	}
	public void setPLaneNo(String laneNo) {
		pLaneNo = laneNo;
	}
	public void setJasper(String jasper) {
		this.jasper = jasper;
	}
	public void setJasperPDF(String jasperPDF) {
		this.jasperPDF = jasperPDF;
	}
	
	/**
	 * 转向通行费日报表编辑页面
	 * @return
	 */
	public String tollsTradeDay(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		endTime=sdf.format(new Date());
		return "tollsTradeDay";
	}
	/**
	 * 转向通行费日收费员报表编辑页面
	 * @return
	 */
	public String tollsCollectorDay(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		endTime=sdf.format(new Date());
		return "tollsCollectorDay";
	}
	/**
	 * 转向通行费分人班分时段报表编辑页面
	 * @return
	 */
	public String tollsOperSquadDates(){
		list = operatorService.getAllOperator();
		squadList = squadInformationService.getAllSquadInformation();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		endTime=sdf.format(new Date());
		return "tollsOperSquadDates";
	}
	/**
	 * 转向通行费分车道分时段报表编辑页面
	 * @return
	 */
	public String tollsLane(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		endTime=sdf.format(new Date());
		
		parkString = "";
		String parkTemp = "";
		
		parkList = parkInformationService.getAllParkInformation();
		
		list = new ArrayList();
		
		if(parkList!=null && !parkList.equals("")) {
			for(ParkInformation park:parkList){
				List tempOp = laneInformationService.getLaneInformationByParkNo(Short.valueOf(park.getParkNo()));
				if(null == tempOp){
					tempOp = new ArrayList();
				}
				tempOp.add(0,park);
				list.add(tempOp);			
			
				parkTemp = park.getParkNo().toString() + ",";
				parkString = parkString + parkTemp;
			}
			parkString = parkString.substring(0, parkString.length()-1);
		}
		
		return "tollsLane";
	}	
	/**
	 * 转向通行费日统计报表编辑页面
	 * @return
	 */
	public String tollsDayStatistics(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		endTime=sdf.format(new Date());
		return "tollsDayStatistics";
	}
	/**
	 * 转向通行费分门分车道日报表编辑页面
	 * @return
	 */
	public String tollsGateLaneDay(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		endTime=sdf.format(new Date());
		return "tollsGateLaneDay";
	}
	/**
	 * 转向通行费月报表编辑页面
	 * @return
	 */
	public String tollsTradeMonth(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		endTime=sdf.format(new Date());
		return "tollsTradeMonth";
	}
	/**
	 * 转向缴费卡交易记录报表编辑页面
	 * @return
	 */
	public String payCardTrade(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		endTime=sdf.format(new Date());
		return "payCardTrade";
	}
	/**
	 * 打印账单报表编辑页面
	 * @return
	 */
	public String printBill(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		endTime=sdf.format(new Date());
		return "printBill";
	}
	/**
	 * 转向通行费应收现金分人班分时段报表编辑页面
	 * @return
	 */
	public String tollsCashMoneyOperSquadDates(){
		list = operatorService.getAllOperator();
		squadList = squadInformationService.getAllSquadInformation();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		endTime=sdf.format(new Date());
		return "tollsCashMoneyOperSquadDates";
	}
	
	//读取区域、小区参数
	public void getSysparamconf() {
		//读取区域、小区参数
		Sysparamconf areaNo = sysparamconfService.getSysparamconfByQname("AreaNo");
		Sysparamconf parkNo = sysparamconfService.getSysparamconfByQname("ParkNo");
		setAreaNo = new Sysparamconf();
		setParkNo = new Sysparamconf();
		if(areaNo == null) {
			setAreaNo.setPname("AreaNo");
			//浙大数值为3301
			setAreaNo.setPvalue("4430");
			setAreaNo.setPtype(0);
			setAreaNo.setRemark("区域编号");
			sysparamconfService.save(setAreaNo);
		}
		if(parkNo == null) {
			setParkNo.setPname("ParkNo");
			//浙大数值为1
			setParkNo.setPvalue("101");
			setParkNo.setPtype(0);
			setParkNo.setRemark("小区编号");
			sysparamconfService.save(setParkNo);
		}
	}
	
	/**
	 * HTML格式通行费日报表
	 * @return
	 */
	public String tollsTradeDayReport(){
		try {
			admin = this.getCurrentOperator();
			//读取区域、小区参数
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
	//		String jasper1 = ServletActionContext.getRequest().getRealPath(jasper);
			response.setContentType("text/html");
		    response.setCharacterEncoding("utf-8");
		    
		    //计算生成的报表记录条数
		    int count = reportService.countTollsTradeDay(startTime, endTime, areaNoValue, parkNoValue);
		    if(count > 10000) {
		    	message = "生成HTML格式通行费日报表数据量过大，已超过10000条，请重新选择较小的日期范围";
		    	return ERROR;
		    }
			JasperPrint print = this.reportService.tollsFillReport(jasper1, startTime, endTime,
					areaNoValue, parkNoValue, getCurrentOperator().getName());
			
			JRHtmlExporter exporter = new JRHtmlExporter();
			 
	        exporter.setParameter(JRExporterParameter.JASPER_PRINT, print);
	        exporter.setParameter(JRExporterParameter.OUTPUT_WRITER, response.getWriter());
	        exporter.setParameter(
	        	     JRHtmlExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,
	        	     new Boolean(false));// 是否去除行间的空白
	        exporter.setParameter(
	        	     JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
	        	     Boolean.FALSE);// 是否输出图片到行
	        exporter.setParameter(
	        	     JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
	        	     Boolean.FALSE);// 输出引擎是否用小图片矫正
	        exporter.setParameter(JRHtmlExporterParameter.IS_WRAP_BREAK_WORD,
	        	     Boolean.TRUE);// 输出引擎是否强制包装异常文字
	        
	        //exporter.setParameter(JRHtmlExporterParameter.SIZE_UNIT, "pt");//解决生成HTML报表缩小问题，但打印会变大
	        //pt 点数 (Typeface Point=1/72in) 打印的点数大小。 px 像数 (pixel) 在屏幕上显示的单位。
	        
	        //打印分页
	        String BETWEEN_PAGES_HTML = "<p style='page-break-after:always;'> </p>";
	        exporter.setParameter(JRHtmlExporterParameter.BETWEEN_PAGES_HTML,
	        		BETWEEN_PAGES_HTML);
	        
	        exporter.exportReport();
	        
	        //插入系统日志
			systemLogService.save(new Date(), 1, admin,
					"["+admin.getId()+"]"+admin.getUsername()+"用户生成日期从"+startTime+"至"+endTime+"的HTML格式通行费日报表",
					"报表管理--通行费报表--通行费日报表", "tb_OutListSum");
	        
		} catch (JRException e) {		
			systemLogService.save(new Date(), 2, admin, "HTML格式通行费日报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式通行费日报表IO异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式通行费日报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	
//	第二种方法：通过文件方式（有可能出现文件读取冲突问题）
//	@SuppressWarnings("deprecation")
//	public String tollsTradeDayReport(){
//		HttpServletRequest request = ServletActionContext.getRequest();
//		HttpServletResponse response = ServletActionContext.getResponse();
//		String jasper1 = request.getRealPath(jasper);
//		//String jasper1 = request.getRealPath("/WEB-INF/jsp/report/jasper/tollsTradeDayReport.jasper");
//		//String html="/"+System.currentTimeMillis()+".html";
//		try {
//			String destFile = this.reportService.pdfOrHtmlFormat(jasper1, startTime, endTime, operator.getName());
//			//this.reportService.pdfOrHtmlFormat(jasper1, request.getRealPath(html), startTime, endTime, operator.getName());
//			response..sendRedirect(destFile);
//		} catch (JRException e) {
//			e.printStackTrace();
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//		return null;
//	}
	/**
	 * PDF格式通行费日报表
	 * @return
	 */
	public String tollsTradeDayReportPDF(){
		try{
			admin = this.getCurrentOperator();
			//读取区域、小区参数
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//计算生成的报表记录条数
		    int count = reportService.countTollsTradeDay(startTime, endTime, areaNoValue, parkNoValue);
		    if(count > 20000) {
		    	message = "生成PDF格式通行费日报表数据量过大，已超过20000条，请重新选择较小的日期范围";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			
			//设置pdf文件名
			ServletActionContext.getResponse().setHeader("Content-Disposition",
					"attachment; filename=tollsReport_tollsTradeDayReportPDF.pdf");
			//ServletActionContext.getResponse().setHeader("Content-Disposition", "inline;filename=report_tollsTradeDayReportPDF.pdf");
			
			//按照以下设置IE浏览器一定可以下载到pdf文件
			/*response.setHeader("Cache-Control", "must-revalidate, post-check=0, pre-check=0");   
	        response.setHeader("Pragma", "public");     
	        response.setContentType("APPLICATION/OCTET-STREAM;charset=GBK");  
	        response.setContentType("application/x-msdownload");  
	        response.setCharacterEncoding("GBK"); */
			
//			//插入系统日志
//			systemLogService.save(new Date(), 1, admin,
//					admin.getUsername()+"用户生成日期从"+startTime+"至"+endTime+"的PDF格式通行费日报表",
//					"报表管理--通行费报表--通行费日报表", "tb_OutListSum");
			
			this.reportService.tollsPdfStream(inputStream, outputStream, startTime, endTime,
					areaNoValue, parkNoValue, getCurrentOperator().getName());
			ServletActionContext.getResponse().setContentType("application/pdf");
			
			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式通行费日报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式通行费日报表IO异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式通行费日报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * HTML格式通行费日收费员报表
	 * @return
	 */
	public String tollsCollectorDayReport(){
		try {
			admin = this.getCurrentOperator();
			//读取区域、小区参数
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			admin = adminService.get(getCurrentOperator().getId());
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
	//		String jasper1 = ServletActionContext.getRequest().getRealPath(jasper);
			response.setContentType("text/html");
		    response.setCharacterEncoding("utf-8");
		    
		    //计算生成的报表记录条数
		    int count = reportService.countTollsCollectorDay(startTime, endTime, areaNoValue, parkNoValue);
		    if(count > 10000) {
		    	message = "生成HTML格式通行费日报表数据量过大，已超过10000条，请重新选择较小的日期范围";
		    	return ERROR;
		    }
		
			JasperPrint print = this.reportService.tollsFillReport(jasper1, startTime, endTime, areaNoValue, parkNoValue, getCurrentOperator().getName());
			
			JRHtmlExporter exporter = new JRHtmlExporter();
			 
	        exporter.setParameter(JRExporterParameter.JASPER_PRINT, print);
	        exporter.setParameter(JRExporterParameter.OUTPUT_WRITER, response.getWriter());
	        exporter.setParameter(
	        	     JRHtmlExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,
	        	     new Boolean(false));// 是否去除行间的空白
	        exporter.setParameter(
	        	     JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
	        	     Boolean.FALSE);// 是否输出图片到行
	        exporter.setParameter(
	        	     JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
	        	     Boolean.FALSE);// 输出引擎是否用小图片矫正
	        exporter.setParameter(JRHtmlExporterParameter.IS_WRAP_BREAK_WORD,
	        	     Boolean.TRUE);// 输出引擎是否强制包装异常文字
	        
	        //exporter.setParameter(JRHtmlExporterParameter.SIZE_UNIT, "pt");//解决生成HTML报表缩小问题，但打印会变大
	        //pt 点数 (Typeface Point=1/72in) 打印的点数大小。 px 像数 (pixel) 在屏幕上显示的单位。
	        
	        //打印分页
	        String BETWEEN_PAGES_HTML = "<p style='page-break-after:always;'> </p>";
	        exporter.setParameter(JRHtmlExporterParameter.BETWEEN_PAGES_HTML,
	        		BETWEEN_PAGES_HTML);
	        
	        exporter.exportReport();
	        
	        //插入系统日志
			systemLogService.save(new Date(), 1, admin,
					"["+admin.getId()+"]"+admin.getUsername()+"用户生成日期从"+startTime+"至"+endTime+"的HTML格式通行费日收费员报表",
					"报表管理--通行费报表--通行费日收费员报表", "tb_OutListSum");
	        
		} catch (JRException e) {		
			systemLogService.save(new Date(), 2, admin, "HTML格式通行费日收费员报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式通行费日收费员报表IO异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式通行费日收费员报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * PDF格式通行费日收费员报表
	 * @return
	 */
	public String tollsCollectorDayReportPDF(){
		try{
			admin = this.getCurrentOperator();
			//读取区域、小区参数
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			admin = adminService.get(getCurrentOperator().getId());
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//OutputStream outputStream = null;
			
			//计算生成的报表记录条数
		    int count = reportService.countTollsCollectorDay(startTime, endTime, areaNoValue, parkNoValue);
		    if(count > 20000) {
		    	message = "生成PDF格式通行费日收费员报表数据量过大，已超过20000条，请重新选择较小的日期范围";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			
			//设置pdf文件名
			ServletActionContext.getResponse().setHeader("Content-Disposition",
					"attachment; filename=tollsReport_tollsCollectorDayReportPDF.pdf");
			//ServletActionContext.getResponse().setHeader("Content-Disposition", "inline;filename=report_tollsTradeDayReportPDF.pdf");
			
			this.reportService.tollsPdfStream(inputStream, outputStream, startTime, endTime,
					areaNoValue, parkNoValue, getCurrentOperator().getName());
			ServletActionContext.getResponse().setContentType("application/pdf");
			
//			//插入系统日志
//			systemLogService.save(new Date(), 1, admin,
//					admin.getUsername()+"用户生成日期从"+startTime+"至"+endTime+"的PDF格式通行费日收费员报表",
//					"报表管理--通行费报表--通行费日收费员报表", "tb_OutListSum");
			
			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式通行费日收费员报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式通行费日收费员报表IO异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式通行费日收费员报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * HTML格式通行费分人班分时段报表
	 * @return
	 */
	public String tollsOperSquadDatesReport(){
		try {
			admin = this.getCurrentOperator();
			//读取区域、小区参数
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8");
			
			//计算生成的报表记录条数
		    int count = reportService.countTollsOperSquadDates(startTime, endTime, areaNoValue, parkNoValue,
					pSquadNo, pOperatorNo);
		    if(count > 10000) {
		    	message = "生成HTML通行费分人班分时段报表数据量过大，已超过10000条，请重新选择较小的日期范围";
		    	return ERROR;
		    }
		    
			JasperPrint print = this.reportService.operSquadDatesFillReport(jasper1, startTime, endTime, 
					areaNoValue, parkNoValue, pSquadNo, pOperatorNo, getCurrentOperator().getName());
			
			JRHtmlExporter exporter = new JRHtmlExporter();
			
			exporter.setParameter(JRExporterParameter.JASPER_PRINT, print);
			exporter.setParameter(JRExporterParameter.OUTPUT_WRITER, response.getWriter());
			exporter.setParameter(
					JRHtmlExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,
					new Boolean(false));// 是否去除行间的空白
			exporter.setParameter(
					JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
					Boolean.FALSE);// 是否输出图片到行
			exporter.setParameter(
					JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
					Boolean.FALSE);// 输出引擎是否用小图片矫正
			exporter.setParameter(JRHtmlExporterParameter.IS_WRAP_BREAK_WORD,
					Boolean.TRUE);// 输出引擎是否强制包装异常文字
			
			//打印分页
			String BETWEEN_PAGES_HTML = "<p style='page-break-after:always;'> </p>";
	        exporter.setParameter(JRHtmlExporterParameter.BETWEEN_PAGES_HTML,
	        		BETWEEN_PAGES_HTML);
	        
	        //插入系统日志
			systemLogService.save(new Date(), 1, admin,
					"["+admin.getId()+"]"+admin.getUsername()+"用户生成日期从"+startTime+"至"+endTime+"的HTML格式通行费分人班分时段报表",
					"报表管理--通行费报表--通行费分人班分时段报表", "tb_OutListSum");

			exporter.exportReport();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式通行费分人班分时段报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式通行费分人班分时段报表IO异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式通行费分人班分时段报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * PDF格式通行费分人班分时段报表
	 * @return
	 */
	public String tollsOperSquadDatesReportPDF(){
		try{
			admin = this.getCurrentOperator();
			//读取区域、小区参数
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//计算生成的报表记录条数
		    int count = reportService.countTollsOperSquadDates(startTime, endTime, areaNoValue, parkNoValue,
					pSquadNo, pOperatorNo);
		    if(count > 20000) {
		    	message = "生成PDF通行费分人班分时段报表数据量过大，已超过20000条，请重新选择较小的日期范围";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			//设置pdf文件名
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename="+"tollsReport_tollsOperSquadDatesReportPDF.pdf");
			
			this.reportService.operSquadDatesPdfStream(inputStream, outputStream, startTime, endTime, areaNoValue, parkNoValue,
					pSquadNo, pOperatorNo, getCurrentOperator().getName());
			ServletActionContext.getResponse().setContentType("application/pdf");
			
//			//插入系统日志
//			systemLogService.save(new Date(), 1, admin,
//					admin.getUsername()+"用户生成日期从"+startTime+"至"+endTime+"的PDF格式通行费分人班分时段报表",
//					"报表管理--通行费报表--通行费分人班分时段报表", "tb_OutListSum");
			
			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式通行费分人班分时段报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式通行费分人班分时段报表IO异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式通行费分人班分时段报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		
		return null;
	}
	
	/**
	 * HTML格式通行费日统计报表
	 * @return
	 */
	public String tollsDayStatisticsReport(){
		try {
			admin = this.getCurrentOperator();
			//读取区域、小区参数
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
//			admin = adminService.get(getCurrentOperator().getId());
			
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8");
			
			//计算生成的报表记录条数
		    int count = reportService.countTollsDayStatistics(startTime, endTime, areaNoValue, parkNoValue);
		    if(count > 10000) {
		    	message = "生成HTML通行费日统计报表数据量过大，已超过10000条，请重新选择较小的日期范围";
		    	return ERROR;
		    }
		    
			JasperPrint print=this.reportService.tollsFillReport(jasper1, startTime, endTime, 
					areaNoValue, parkNoValue, getCurrentOperator().getName());
			
			JRHtmlExporter exporter = new JRHtmlExporter();
			
			exporter.setParameter(JRExporterParameter.JASPER_PRINT, print);
			exporter.setParameter(JRExporterParameter.OUTPUT_WRITER, response.getWriter());
			exporter.setParameter(
					JRHtmlExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,
					new Boolean(false));// 是否去除行间的空白
			exporter.setParameter(
					JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
					Boolean.FALSE);// 是否输出图片到行
			exporter.setParameter(
					JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
					Boolean.FALSE);// 输出引擎是否用小图片矫正
			exporter.setParameter(JRHtmlExporterParameter.IS_WRAP_BREAK_WORD,
					Boolean.TRUE);// 输出引擎是否强制包装异常文字
			
			//打印分页
			String BETWEEN_PAGES_HTML = "<p style='page-break-after:always;'> </p>";
	        exporter.setParameter(JRHtmlExporterParameter.BETWEEN_PAGES_HTML,
	        		BETWEEN_PAGES_HTML);

			exporter.exportReport();
			
			//插入系统日志
			systemLogService.save(new Date(), 1, admin,
					"["+admin.getId()+"]"+admin.getUsername()+"用户生成日期从"+startTime+"至"+endTime+"的HTML格式通行费日统计报表",
					"报表管理--通行费报表--通行费日统计报表", "tb_OutListSum");
			
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式通行费日统计报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式通行费日统计报表IO异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式通行费日统计报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * PDF格式通行费日统计报表
	 * @return
	 */
	public String tollsDayStatisticsReportPDF(){
		try{
			admin = this.getCurrentOperator();
			//读取区域、小区参数
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//计算生成的报表记录条数
		    int count = reportService.countTollsDayStatistics(startTime, endTime, areaNoValue, parkNoValue);
		    if(count > 20000) {
		    	message = "生成PDF格式通行费日统计报表数据量过大，已超过20000条，请重新选择较小的日期范围";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			
			//设置pdf文件名
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename=tollsReport_tollsDayStatisticsReportPDF.pdf");
			//ServletActionContext.getResponse().setHeader("Content-Disposition", "inline;filename=report_tollsTradeDayReportPDF.pdf");
			
			this.reportService.tollsPdfStream(inputStream, outputStream, startTime, endTime, 
					areaNoValue, parkNoValue, getCurrentOperator().getName());
			ServletActionContext.getResponse().setContentType("application/pdf");
			
//			//插入系统日志
//			systemLogService.save(new Date(), 1, admin,
//					admin.getUsername()+"用户生成日期从"+startTime+"至"+endTime+"的PDF格式通行费日统计报表",
//					"报表管理--通行费报表--通行费日统计报表", "tb_OutListSum");
			
			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式通行费日统计报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式通行费日统计报表IO异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式通行费日统计报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * HTML格式通行费分门分车道日报表
	 * @return
	 */
	public String tollsGateLaneDayReport(){
		try {
			admin = this.getCurrentOperator();
			//读取区域、小区参数
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8");
			
			//计算生成的报表记录条数
		    int count = reportService.countTollsGateLaneDay(startTime, endTime, areaNoValue, parkNoValue);
		    if(count > 10000) {
		    	message = "生成HTML通行费分门分车道日报表报表数据量过大，已超过10000条，请重新选择较小的日期范围";
		    	return ERROR;
		    }
		    
			JasperPrint print = this.reportService.tollsFillReport(jasper1, startTime, endTime, 
					areaNoValue, parkNoValue, getCurrentOperator().getName());
			
			JRHtmlExporter exporter = new JRHtmlExporter();
			
			exporter.setParameter(JRExporterParameter.JASPER_PRINT, print);
			exporter.setParameter(JRExporterParameter.OUTPUT_WRITER, response.getWriter());
			exporter.setParameter(
					JRHtmlExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,
					new Boolean(false));// 是否去除行间的空白
			exporter.setParameter(
					JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
					Boolean.FALSE);// 是否输出图片到行
			exporter.setParameter(
					JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
					Boolean.FALSE);// 输出引擎是否用小图片矫正
			exporter.setParameter(JRHtmlExporterParameter.IS_WRAP_BREAK_WORD,
					Boolean.TRUE);// 输出引擎是否强制包装异常文字
			
			//打印分页
			String BETWEEN_PAGES_HTML = "<p style='page-break-after:always;'> </p>";
	        exporter.setParameter(JRHtmlExporterParameter.BETWEEN_PAGES_HTML,
	        		BETWEEN_PAGES_HTML);

			exporter.exportReport();
			
			//插入系统日志
			systemLogService.save(new Date(), 1, admin,
					"["+admin.getId()+"]"+admin.getUsername()+"用户生成日期从"+startTime+"至"+endTime+"的HTML格式通行费分门分车道日报表",
					"报表管理--通行费报表--通行费分门分车道日报表", "tb_OutListSum");
			
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式通行费分门分车道日报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式通行费分门分车道日报表IO异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式通行费分门分车道日报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * PDF格式通行费分门分车道日报表
	 * @return
	 */
	public String tollsGateLaneDayReportPDF(){
		try{
			admin = this.getCurrentOperator();
			//读取区域、小区参数
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//计算生成的报表记录条数
		    int count = reportService.countTollsGateLaneDay(startTime, endTime, areaNoValue, parkNoValue);
		    if(count > 20000) {
		    	message = "生成PDF格式通行费分门分车道日报表数据量过大，已超过20000条，请重新选择较小的日期范围";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			
			//设置pdf文件名
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename=tollsReport_tollsGateLaneDayReportPDF.pdf");
			
			this.reportService.tollsPdfStream(inputStream, outputStream, startTime, endTime, 
					areaNoValue, parkNoValue, getCurrentOperator().getName());
			ServletActionContext.getResponse().setContentType("application/pdf");
			
//			//插入系统日志
//			systemLogService.save(new Date(), 1, admin,
//					admin.getUsername()+"用户生成日期从"+startTime+"至"+endTime+"的PDF格式通行费分门分车道日报表",
//					"报表管理--通行费报表--通行费分门分车道日报表", "tb_OutListSum");
			
			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式通行费分门分车道日报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式通行费分门分车道日报表IO异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式通行费分门分车道日报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	
	
	/**
	 * HTML格式通行费月报表
	 * @return
	 */
	public String tollsTradeMonthReport(){
		try {
			admin = this.getCurrentOperator();
			//读取区域、小区参数
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
		    response.setCharacterEncoding("utf-8");
		    
		    //计算生成的报表记录条数
		    int count = reportService.countTollsTradeMonth(startTime, endTime, areaNoValue, parkNoValue);
		    if(count > 10000) {
		    	message = "生成HTML格式通行费月报表数据量过大，已超过10000条，请重新选择较小的日期范围";
		    	return ERROR;
		    }
	    
			JasperPrint print=this.reportService.tollsFillReport(jasper1, startTime, endTime,
					areaNoValue, parkNoValue, getCurrentOperator().getName());
			
			JRHtmlExporter exporter = new JRHtmlExporter();
			 
	        exporter.setParameter(JRExporterParameter.JASPER_PRINT, print);
	        exporter.setParameter(JRExporterParameter.OUTPUT_WRITER, response.getWriter());
	        exporter.setParameter(
	        	     JRHtmlExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,
	        	     new Boolean(false));// 是否去除行间的空白
	        exporter.setParameter(
	        	     JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
	        	     Boolean.FALSE);// 是否输出图片到行
	        exporter.setParameter(
	        	     JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
	        	     Boolean.FALSE);// 输出引擎是否用小图片矫正
	        exporter.setParameter(JRHtmlExporterParameter.IS_WRAP_BREAK_WORD,
	        	     Boolean.TRUE);// 输出引擎是否强制包装异常文字
	        
	        //打印分页
	        String BETWEEN_PAGES_HTML = "<p style='page-break-after:always;'> </p>";
	        exporter.setParameter(JRHtmlExporterParameter.BETWEEN_PAGES_HTML,
	        		BETWEEN_PAGES_HTML);

	        exporter.exportReport();
	        
	        //插入系统日志
			systemLogService.save(new Date(), 1, admin,
					"["+admin.getId()+"]"+admin.getUsername()+"用户生成日期从"+startTime+"至"+endTime+"的HTML格式通行费月报表",
					"报表管理--通行费报表--通行费月报表", "tb_OutListSum");
	        
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式通行费月报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式通行费月报表IO异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式通行费月报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * PDF格式通行费月报表
	 * @return
	 */
	public String tollsTradeMonthReportPDF(){
		try{
			admin = this.getCurrentOperator();
			//读取区域、小区参数
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//计算生成的报表记录条数
		    int count = reportService.countTollsTradeMonth(startTime, endTime, areaNoValue, parkNoValue);
		    if(count > 20000) {
		    	message = "生成PDF格式通行费月报表数据量过大，已超过20000条，请重新选择较小的日期范围";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			//设置pdf文件名
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename="+"tollsReport_tollsTradeMonthReportPDF.pdf");
			
			this.reportService.tollsPdfStream(inputStream, outputStream, startTime, endTime, areaNoValue, parkNoValue, getCurrentOperator().getName());
			ServletActionContext.getResponse().setContentType("application/pdf");
			
//			//插入系统日志
//			systemLogService.save(new Date(), 1, admin,
//					admin.getUsername()+"用户生成日期从"+startTime+"至"+endTime+"的PDF格式通行费月报表",
//					"报表管理--通行费报表--通行费月报表", "tb_OutListSum");

			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式通行费月报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式通行费月报表IOException异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式通行费月报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * HTML格式缴费卡交易报表
	 * @return
	 */
	public String payCardTradeReport(){
		try {
			admin = this.getCurrentOperator();
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8");
			
			//取出如0,1,2,3,4的各值
			String[] ids = tradeType.split(",");
			String tradeType0 = ids[0];
			String tradeType1 = ids[1];
			String tradeType2 = ids[2];
			String tradeType3 = ids[3];
			String tradeType4 = ids[4];
			
			//计算生成的报表记录条数
		    int count = reportService.countPayCardTrade(startTime, endTime + " 23:59:59", tradeType0, tradeType1,
					tradeType2, tradeType3, tradeType4, account.getSys_id(), user.getUserName(), 
					car.getVehPlate(), account.getCardNo(), user.getCredentialsNo(), account.getStatus());
		    if(count > 10000) {
		    	message = "生成HTML格式缴费卡交易报表数据量过大，已超过10000条，请重新选择较小的日期范围";
		    	return ERROR;
		    }
		
			JasperPrint print = this.reportService.fillReport(jasper1, startTime, endTime + " 23:59:59",
					tradeType0, tradeType1, tradeType2, tradeType3, tradeType4,
					getCurrentOperator().getName(), account.getSys_id(), user.getUserName(), 
					car.getVehPlate(), account.getCardNo(), user.getCredentialsNo(), account.getStatus());
			
			JRHtmlExporter exporter = new JRHtmlExporter();
			
			exporter.setParameter(JRExporterParameter.JASPER_PRINT, print);
			exporter.setParameter(JRExporterParameter.OUTPUT_WRITER, response.getWriter());
			exporter.setParameter(
					JRHtmlExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,
					new Boolean(false));// 是否去除行间的空白
			exporter.setParameter(
					JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
					Boolean.FALSE);// 是否输出图片到行
			exporter.setParameter(
					JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
					Boolean.FALSE);// 输出引擎是否用小图片矫正
			exporter.setParameter(JRHtmlExporterParameter.IS_WRAP_BREAK_WORD,
					Boolean.TRUE);// 输出引擎是否强制包装异常文字
					
			//打印分页
			String BETWEEN_PAGES_HTML = "<p style='page-break-after:always;'> </p>";
			exporter.setParameter(JRHtmlExporterParameter.BETWEEN_PAGES_HTML,
			        		BETWEEN_PAGES_HTML);
					
			exporter.exportReport();
			
			//插入系统日志
			systemLogService.save(new Date(), 1, admin,
					"["+admin.getId()+"]"+admin.getUsername()+"用户生成日期从"+startTime+"至"+endTime+"的HTML格式缴费卡交易报表",
					"报表管理--通行费报表--缴费卡交易报表", "v_AccountTrade");
			
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式缴费卡交易报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式缴费卡交易报表IO异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式缴费卡交易报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * PDF格式缴费卡交易报表
	 * @return
	 */
	public String payCardTradeReportPDF(){
		try{
			admin = this.getCurrentOperator();
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);	
			//取出如0,1,2,3,4的各值
			String[] ids = tradeType.split(",");
			String tradeType0 = ids[0];
			String tradeType1 = ids[1];
			String tradeType2 = ids[2];
			String tradeType3 = ids[3];
			String tradeType4 = ids[4];
			
			//计算生成的报表记录条数
		    int count = reportService.countPayCardTrade(startTime, endTime + " 23:59:59", tradeType0, tradeType1,
					tradeType2, tradeType3, tradeType4, account.getSys_id(), user.getUserName(), 
					car.getVehPlate(), account.getCardNo(), user.getCredentialsNo(), account.getStatus());
		    if(count > 20000) {
		    	message = "生成PDF格式缴费卡交易报表数据量过大，已超过20000条，请重新选择较小的日期范围";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			//设置pdf文件名
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename="+"tollsReport_payCardTradeReportPDF.pdf");
			
			this.reportService.pdfStreamFormate(inputStream, outputStream, startTime, endTime + " 23:59:59", tradeType0, tradeType1,
					tradeType2, tradeType3, tradeType4, getCurrentOperator().getName(), account.getSys_id(), user.getUserName(), 
					car.getVehPlate(), account.getCardNo(), user.getCredentialsNo(), account.getStatus());
			ServletActionContext.getResponse().setContentType("application/pdf");
			
//			//插入系统日志
//			systemLogService.save(new Date(), 1, admin,
//					admin.getUsername()+"用户生成日期从"+startTime+"至"+endTime+"的PDF格式缴费卡交易报表",
//					"报表管理--通行费报表--缴费卡交易报表", "v_AccountTrade");
			
			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式缴费卡交易报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式缴费卡交易报表IO异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式缴费卡交易报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * HTML格式打印账单报表
	 * @return
	 */
	public String printBillReport(){
		try {
			admin = this.getCurrentOperator();
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8");
			
			//取出如0,1,2,3,4的各值
			String[] ids = tradeType.split(",");
			String tradeType0 = ids[0];
			String tradeType1 = ids[1];
			
			//计算生成的报表记录条数
		    int count = reportService.countPrintBill(startTime, endTime + " 23:59:59", tradeType0, tradeType1);
		    if(count > 10000) {
		    	message = "生成HTML打印账单报表数据量过大，已超过10000条，请重新选择较小的日期范围";
		    	return ERROR;
		    }
		
			JasperPrint print = this.reportService.fillReport(jasper1, startTime, endTime + " 23:59:59",
					tradeType0, tradeType1, getCurrentOperator().getName());
			
			JRHtmlExporter exporter = new JRHtmlExporter();
			
			exporter.setParameter(JRExporterParameter.JASPER_PRINT, print);
			exporter.setParameter(JRExporterParameter.OUTPUT_WRITER, response.getWriter());
			exporter.setParameter(
					JRHtmlExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,
					new Boolean(false));// 是否去除行间的空白
			exporter.setParameter(
					JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
					Boolean.FALSE);// 是否输出图片到行
			exporter.setParameter(
					JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
					Boolean.FALSE);// 输出引擎是否用小图片矫正
			exporter.setParameter(JRHtmlExporterParameter.IS_WRAP_BREAK_WORD,
					Boolean.TRUE);// 输出引擎是否强制包装异常文字
			
			//打印分页
			String BETWEEN_PAGES_HTML = "<p style='page-break-after:always;'> </p>";
	        exporter.setParameter(JRHtmlExporterParameter.BETWEEN_PAGES_HTML,
	        		BETWEEN_PAGES_HTML);

			exporter.exportReport();
			
			//插入系统日志
			systemLogService.save(new Date(), 1, admin,
					"["+admin.getId()+"]"+admin.getUsername()+"用户生成日期从"+startTime+"至"+endTime+"的HTML格式打印账单报表",
					"报表管理--通行费报表--打印账单报表", "v_AccountTrade");
			
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式打印账单报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式打印账单报表IO异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式打印账单报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * PDF格式打印账单报表
	 * @return
	 */
	public String printBillReportPDF(){
		try{
			admin = this.getCurrentOperator();
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			//取出如0,1,2,3,4的各值
			String[] ids = tradeType.split(",");
			String tradeType0 = ids[0];
			String tradeType1 = ids[1];
			
			//计算生成的报表记录条数
		    int count = reportService.countPrintBill(startTime, endTime + " 23:59:59", tradeType0, tradeType1);
		    if(count > 20000) {
		    	message = "生成PDF打印账单报表数据量过大，已超过20000条，请重新选择较小的日期范围";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			//设置pdf文件名
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename="+"tollsReport_printBillReportPDF.pdf");
			
			this.reportService.pdfStreamFormate(inputStream, outputStream, startTime, endTime + " 23:59:59",
					tradeType0, tradeType1, getCurrentOperator().getName());
			ServletActionContext.getResponse().setContentType("application/pdf");
			
//			//插入系统日志
//			systemLogService.save(new Date(), 1, admin,
//					admin.getUsername()+"用户生成日期从"+startTime+"至"+endTime+"的PDF格式打印账单报表",
//					"报表管理--通行费报表--打印账单报表", "v_AccountTrade");
			
			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式打印账单报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式打印账单报表IO异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式打印账单报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}/*finally {
			if(outputStream == null) {
				try {
					outputStream.flush();
					outputStream.close();
				} catch (IOException e) {
//					String simplename = e.getClass().getSimpleName();
//					if(!"ClientAbortException".equals(simplename)){
						e.printStackTrace();
//					}
				}
			}
		}*/
		return null;
	}
	
	/**
	 * HTML格式通行费分车道分时段报表
	 * @return
	 */
	public String tollsLaneReport() {
		try {
			admin = this.getCurrentOperator();
			//读取区域、小区参数
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			//int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8");
			
			//计算生成的报表记录条数
			int count = reportService.countTollsLane(startTime, endTime, areaNoValue, parkNo,pLaneNo);
			if (count > 10000) {
				message ="生成HTML通行费分车道分时段报表数据量过大，已超过10000条，请重新选择较小的日期范围";
				return ERROR;
			}
			JasperPrint print = this.reportService.laneFillReport(jasper1, startTime, endTime, areaNoValue, parkNo, pLaneNo, getCurrentOperator().getName());

			JRHtmlExporter exporter = new JRHtmlExporter();
			
			exporter.setParameter(JRExporterParameter.JASPER_PRINT, print);
			exporter.setParameter(JRExporterParameter.OUTPUT_WRITER, response.getWriter());
			exporter.setParameter(
					JRHtmlExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,
					new Boolean(false));// 是否去除行间的空白
			exporter.setParameter(
					JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
					Boolean.FALSE);// 是否输出图片到行
			exporter.setParameter(
					JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
					Boolean.FALSE);// 输出引擎是否用小图片矫正
			exporter.setParameter(JRHtmlExporterParameter.IS_WRAP_BREAK_WORD,
					Boolean.TRUE);// 输出引擎是否强制包装异常文字
			
			//打印分页
			String BETWEEN_PAGES_HTML = "<p style='page-break-after:always;'> </p>";
	        exporter.setParameter(JRHtmlExporterParameter.BETWEEN_PAGES_HTML,
	        		BETWEEN_PAGES_HTML);
			
	        //插入系统日志
			systemLogService.save(new Date(), 1, admin,
					"["+admin.getId()+"]"+admin.getUsername()+"用户生成日期从"+startTime+"至"+endTime+"的HTML格式通行费分车道分时段报表",
					"报表管理--通行费报表--通行费分车道分时段报表", "tb_OutListSum");
			
			exporter.exportReport();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式通行费分车道分时段报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式通行费分车道分时段报表IO异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式通行费分车道分时段报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;	
	}
	
	/**
	 * PDF格式通行费分车道分时段报表
	 * @return
	 */
	public String tollsLaneReportPDF() {

			try{
				admin = this.getCurrentOperator();
				//读取区域、小区参数
				getSysparamconf();
				
				int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
				
				InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
				
				//计算生成的报表记录条数
			    int count = reportService.countTollsLane(startTime, endTime, areaNoValue, parkNo, pLaneNo);
			    if(count > 20000) {
			    	message = "生成PDF通行费分车道分时段报表数据量过大，已超过20000条，请重新选择较小的日期范围";
			    	return ERROR;
			    }
			
				OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
				//设置pdf文件名
				ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename="+"tollsReport_tollsLaneReportPDF.pdf");
				
				this.reportService.lanePdfStream(inputStream, outputStream, startTime, endTime, areaNoValue, parkNo, pLaneNo, getCurrentOperator().getName());
				ServletActionContext.getResponse().setContentType("application/pdf");
				
//				//插入系统日志
//				systemLogService.save(new Date(), 1, admin,
//						admin.getUsername()+"用户生成日期从"+startTime+"至"+endTime+"的PDF格式通行费分车道分时段报表",
//						"报表管理--通行费报表--通行费分车道分时段报表", "tb_OutListSum");
				
				outputStream.flush();
				outputStream.close();
			} catch (JRException e) {
				systemLogService.save(new Date(), 2, admin, "PDF格式通行费分车道分时段报表JRException异常", e.getMessage(), "JRException");
				e.printStackTrace();
			} catch (IOException e) {
				systemLogService.save(new Date(), 2, admin, "PDF格式通行费分车道分时段报表IO异常", e.getMessage(), "IOException");
				e.printStackTrace();
			} catch (Exception e) {
				systemLogService.save(new Date(), 2, admin, "PDF格式通行费分车道分时段报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
				e.printStackTrace();
			}
			
			return null;
		}
	
	/**
	 * HTML格式通行费应收现金分人班分时段报表
	 * @return
	 */
	public String tollsCashMoneyOperSquadDatesReport(){
		try {
			admin = this.getCurrentOperator();
			//读取区域、小区参数
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8");
			
			//计算生成的报表记录条数
		    int count = reportService.countTollsCashMoneyOperSquadDates(startTime, endTime, areaNoValue, parkNoValue,
					pSquadNo, pOperatorNo);
		    if(count > 10000) {
		    	message = "生成HTML通行费应收现金分人班分时段报表数据量过大，已超过10000条，请重新选择较小的日期范围";
		    	return ERROR;
		    }
		    
			JasperPrint print = this.reportService.cashMoneyOperSquadDatesFillReport(jasper1, startTime, endTime, 
					areaNoValue, parkNoValue, pSquadNo, pOperatorNo, getCurrentOperator().getName());
			
			JRHtmlExporter exporter = new JRHtmlExporter();
			
			exporter.setParameter(JRExporterParameter.JASPER_PRINT, print);
			exporter.setParameter(JRExporterParameter.OUTPUT_WRITER, response.getWriter());
			exporter.setParameter(
					JRHtmlExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,
					new Boolean(false));// 是否去除行间的空白
			exporter.setParameter(
					JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
					Boolean.FALSE);// 是否输出图片到行
			exporter.setParameter(
					JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
					Boolean.FALSE);// 输出引擎是否用小图片矫正
			exporter.setParameter(JRHtmlExporterParameter.IS_WRAP_BREAK_WORD,
					Boolean.TRUE);// 输出引擎是否强制包装异常文字
			
			//打印分页
			String BETWEEN_PAGES_HTML = "<p style='page-break-after:always;'> </p>";
	        exporter.setParameter(JRHtmlExporterParameter.BETWEEN_PAGES_HTML,
	        		BETWEEN_PAGES_HTML);
	        
	        //插入系统日志
			systemLogService.save(new Date(), 1, admin,
					"["+admin.getId()+"]"+admin.getUsername()+"用户生成日期从"+startTime+"至"+endTime+"的HTML格式通行费应收现金分人班分时段报表",
					"报表管理--通行费报表--通行费应收现金分人班分时段报表", "tb_OutListSum");

			exporter.exportReport();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式通行费应收现金分人班分时段报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式通行费应收现金分人班分时段报表IO异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML格式通行费应收现金分人班分时段报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * PDF格式通行费应收现金分人班分时段报表
	 * @return
	 */
	public String tollsCashMoneyOperSquadDatesReportPDF(){
		try{
			admin = this.getCurrentOperator();
			//读取区域、小区参数
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//计算生成的报表记录条数
		    int count = reportService.countTollsCashMoneyOperSquadDates(startTime, endTime, areaNoValue, parkNoValue,
					pSquadNo, pOperatorNo);
		    if(count > 20000) {
		    	message = "生成PDF通行费应收现金分人班分时段报表数据量过大，已超过20000条，请重新选择较小的日期范围";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			//设置pdf文件名
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename="+"tollsReport_tollsOperSquadDatesReportPDF.pdf");
			
			this.reportService.cashMoneyOperSquadDatesPdfStream(inputStream, outputStream, startTime, endTime, areaNoValue, parkNoValue,
					pSquadNo, pOperatorNo, getCurrentOperator().getName());
			ServletActionContext.getResponse().setContentType("application/pdf");
			
//			//插入系统日志
//			systemLogService.save(new Date(), 1, admin,
//					admin.getUsername()+"用户生成日期从"+startTime+"至"+endTime+"的PDF格式通行费应收现金分人班分时段报表",
//					"报表管理--通行费报表--通行费应收现金分人班分时段报表", "tb_OutListSum");
			
			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式通行费应收现金分人班分时段报表JRException异常", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式通行费应收现金分人班分时段报表IO异常", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF格式通行费应收现金分人班分时段报表Runtime Exception异常", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		
		return null;
	}
	
	// Getters/Setters方法
	public SystemLog getSystemlog() {
		return systemlog;
	}
	public void setSystemlog(SystemLog systemlog) {
		this.systemlog = systemlog;
	}
	public Admin getAdmin() {
		return admin;
	}
	public void setAdmin(Admin admin) {
		this.admin = admin;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Account getAccount() {
		return account;
	}
	public void setAccount(Account account) {
		this.account = account;
	}
	public Car getCar() {
		return car;
	}
	public void setCar(Car car) {
		this.car = car;
	}
	public Operator getLaneOperator() {
		return laneOperator;
	}
	public void setLaneOperator(Operator laneOperator) {
		this.laneOperator = laneOperator;
	}
	
	public List<ParkInformation> getParkList() {
		return parkList;
	}

	public void setParkList(List<ParkInformation> parkList) {
		this.parkList = parkList;
	}
	
	public String getParkString() {
		return parkString;
	}

	public Integer getParkNo() {
		return parkNo;
	}

	public void setParkNo(Integer parkNo) {
		this.parkNo = parkNo;
	}

	
}
