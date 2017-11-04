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
 * @Description ͨ�зѱ��������
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
	 * ת��ͨ�з��ձ���༭ҳ��
	 * @return
	 */
	public String tollsTradeDay(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		endTime=sdf.format(new Date());
		return "tollsTradeDay";
	}
	/**
	 * ת��ͨ�з����շ�Ա����༭ҳ��
	 * @return
	 */
	public String tollsCollectorDay(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		endTime=sdf.format(new Date());
		return "tollsCollectorDay";
	}
	/**
	 * ת��ͨ�зѷ��˰��ʱ�α���༭ҳ��
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
	 * ת��ͨ�зѷֳ�����ʱ�α���༭ҳ��
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
	 * ת��ͨ�з���ͳ�Ʊ���༭ҳ��
	 * @return
	 */
	public String tollsDayStatistics(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		endTime=sdf.format(new Date());
		return "tollsDayStatistics";
	}
	/**
	 * ת��ͨ�зѷ��ŷֳ����ձ���༭ҳ��
	 * @return
	 */
	public String tollsGateLaneDay(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		endTime=sdf.format(new Date());
		return "tollsGateLaneDay";
	}
	/**
	 * ת��ͨ�з��±���༭ҳ��
	 * @return
	 */
	public String tollsTradeMonth(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		endTime=sdf.format(new Date());
		return "tollsTradeMonth";
	}
	/**
	 * ת��ɷѿ����׼�¼����༭ҳ��
	 * @return
	 */
	public String payCardTrade(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		endTime=sdf.format(new Date());
		return "payCardTrade";
	}
	/**
	 * ��ӡ�˵�����༭ҳ��
	 * @return
	 */
	public String printBill(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		endTime=sdf.format(new Date());
		return "printBill";
	}
	/**
	 * ת��ͨ�з�Ӧ���ֽ���˰��ʱ�α���༭ҳ��
	 * @return
	 */
	public String tollsCashMoneyOperSquadDates(){
		list = operatorService.getAllOperator();
		squadList = squadInformationService.getAllSquadInformation();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		endTime=sdf.format(new Date());
		return "tollsCashMoneyOperSquadDates";
	}
	
	//��ȡ����С������
	public void getSysparamconf() {
		//��ȡ����С������
		Sysparamconf areaNo = sysparamconfService.getSysparamconfByQname("AreaNo");
		Sysparamconf parkNo = sysparamconfService.getSysparamconfByQname("ParkNo");
		setAreaNo = new Sysparamconf();
		setParkNo = new Sysparamconf();
		if(areaNo == null) {
			setAreaNo.setPname("AreaNo");
			//�����ֵΪ3301
			setAreaNo.setPvalue("4430");
			setAreaNo.setPtype(0);
			setAreaNo.setRemark("������");
			sysparamconfService.save(setAreaNo);
		}
		if(parkNo == null) {
			setParkNo.setPname("ParkNo");
			//�����ֵΪ1
			setParkNo.setPvalue("101");
			setParkNo.setPtype(0);
			setParkNo.setRemark("С�����");
			sysparamconfService.save(setParkNo);
		}
	}
	
	/**
	 * HTML��ʽͨ�з��ձ���
	 * @return
	 */
	public String tollsTradeDayReport(){
		try {
			admin = this.getCurrentOperator();
			//��ȡ����С������
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
	//		String jasper1 = ServletActionContext.getRequest().getRealPath(jasper);
			response.setContentType("text/html");
		    response.setCharacterEncoding("utf-8");
		    
		    //�������ɵı����¼����
		    int count = reportService.countTollsTradeDay(startTime, endTime, areaNoValue, parkNoValue);
		    if(count > 10000) {
		    	message = "����HTML��ʽͨ�з��ձ��������������ѳ���10000����������ѡ���С�����ڷ�Χ";
		    	return ERROR;
		    }
			JasperPrint print = this.reportService.tollsFillReport(jasper1, startTime, endTime,
					areaNoValue, parkNoValue, getCurrentOperator().getName());
			
			JRHtmlExporter exporter = new JRHtmlExporter();
			 
	        exporter.setParameter(JRExporterParameter.JASPER_PRINT, print);
	        exporter.setParameter(JRExporterParameter.OUTPUT_WRITER, response.getWriter());
	        exporter.setParameter(
	        	     JRHtmlExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,
	        	     new Boolean(false));// �Ƿ�ȥ���м�Ŀհ�
	        exporter.setParameter(
	        	     JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
	        	     Boolean.FALSE);// �Ƿ����ͼƬ����
	        exporter.setParameter(
	        	     JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
	        	     Boolean.FALSE);// ��������Ƿ���СͼƬ����
	        exporter.setParameter(JRHtmlExporterParameter.IS_WRAP_BREAK_WORD,
	        	     Boolean.TRUE);// ��������Ƿ�ǿ�ư�װ�쳣����
	        
	        //exporter.setParameter(JRHtmlExporterParameter.SIZE_UNIT, "pt");//�������HTML������С���⣬����ӡ����
	        //pt ���� (Typeface Point=1/72in) ��ӡ�ĵ�����С�� px ���� (pixel) ����Ļ����ʾ�ĵ�λ��
	        
	        //��ӡ��ҳ
	        String BETWEEN_PAGES_HTML = "<p style='page-break-after:always;'> </p>";
	        exporter.setParameter(JRHtmlExporterParameter.BETWEEN_PAGES_HTML,
	        		BETWEEN_PAGES_HTML);
	        
	        exporter.exportReport();
	        
	        //����ϵͳ��־
			systemLogService.save(new Date(), 1, admin,
					"["+admin.getId()+"]"+admin.getUsername()+"�û��������ڴ�"+startTime+"��"+endTime+"��HTML��ʽͨ�з��ձ���",
					"�������--ͨ�зѱ���--ͨ�з��ձ���", "tb_OutListSum");
	        
		} catch (JRException e) {		
			systemLogService.save(new Date(), 2, admin, "HTML��ʽͨ�з��ձ���JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽͨ�з��ձ���IO�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽͨ�з��ձ���Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	
//	�ڶ��ַ�����ͨ���ļ���ʽ���п��ܳ����ļ���ȡ��ͻ���⣩
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
	 * PDF��ʽͨ�з��ձ���
	 * @return
	 */
	public String tollsTradeDayReportPDF(){
		try{
			admin = this.getCurrentOperator();
			//��ȡ����С������
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//�������ɵı����¼����
		    int count = reportService.countTollsTradeDay(startTime, endTime, areaNoValue, parkNoValue);
		    if(count > 20000) {
		    	message = "����PDF��ʽͨ�з��ձ��������������ѳ���20000����������ѡ���С�����ڷ�Χ";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			
			//����pdf�ļ���
			ServletActionContext.getResponse().setHeader("Content-Disposition",
					"attachment; filename=tollsReport_tollsTradeDayReportPDF.pdf");
			//ServletActionContext.getResponse().setHeader("Content-Disposition", "inline;filename=report_tollsTradeDayReportPDF.pdf");
			
			//������������IE�����һ���������ص�pdf�ļ�
			/*response.setHeader("Cache-Control", "must-revalidate, post-check=0, pre-check=0");   
	        response.setHeader("Pragma", "public");     
	        response.setContentType("APPLICATION/OCTET-STREAM;charset=GBK");  
	        response.setContentType("application/x-msdownload");  
	        response.setCharacterEncoding("GBK"); */
			
//			//����ϵͳ��־
//			systemLogService.save(new Date(), 1, admin,
//					admin.getUsername()+"�û��������ڴ�"+startTime+"��"+endTime+"��PDF��ʽͨ�з��ձ���",
//					"�������--ͨ�зѱ���--ͨ�з��ձ���", "tb_OutListSum");
			
			this.reportService.tollsPdfStream(inputStream, outputStream, startTime, endTime,
					areaNoValue, parkNoValue, getCurrentOperator().getName());
			ServletActionContext.getResponse().setContentType("application/pdf");
			
			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽͨ�з��ձ���JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽͨ�з��ձ���IO�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽͨ�з��ձ���Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * HTML��ʽͨ�з����շ�Ա����
	 * @return
	 */
	public String tollsCollectorDayReport(){
		try {
			admin = this.getCurrentOperator();
			//��ȡ����С������
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			admin = adminService.get(getCurrentOperator().getId());
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
	//		String jasper1 = ServletActionContext.getRequest().getRealPath(jasper);
			response.setContentType("text/html");
		    response.setCharacterEncoding("utf-8");
		    
		    //�������ɵı����¼����
		    int count = reportService.countTollsCollectorDay(startTime, endTime, areaNoValue, parkNoValue);
		    if(count > 10000) {
		    	message = "����HTML��ʽͨ�з��ձ��������������ѳ���10000����������ѡ���С�����ڷ�Χ";
		    	return ERROR;
		    }
		
			JasperPrint print = this.reportService.tollsFillReport(jasper1, startTime, endTime, areaNoValue, parkNoValue, getCurrentOperator().getName());
			
			JRHtmlExporter exporter = new JRHtmlExporter();
			 
	        exporter.setParameter(JRExporterParameter.JASPER_PRINT, print);
	        exporter.setParameter(JRExporterParameter.OUTPUT_WRITER, response.getWriter());
	        exporter.setParameter(
	        	     JRHtmlExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,
	        	     new Boolean(false));// �Ƿ�ȥ���м�Ŀհ�
	        exporter.setParameter(
	        	     JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
	        	     Boolean.FALSE);// �Ƿ����ͼƬ����
	        exporter.setParameter(
	        	     JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
	        	     Boolean.FALSE);// ��������Ƿ���СͼƬ����
	        exporter.setParameter(JRHtmlExporterParameter.IS_WRAP_BREAK_WORD,
	        	     Boolean.TRUE);// ��������Ƿ�ǿ�ư�װ�쳣����
	        
	        //exporter.setParameter(JRHtmlExporterParameter.SIZE_UNIT, "pt");//�������HTML������С���⣬����ӡ����
	        //pt ���� (Typeface Point=1/72in) ��ӡ�ĵ�����С�� px ���� (pixel) ����Ļ����ʾ�ĵ�λ��
	        
	        //��ӡ��ҳ
	        String BETWEEN_PAGES_HTML = "<p style='page-break-after:always;'> </p>";
	        exporter.setParameter(JRHtmlExporterParameter.BETWEEN_PAGES_HTML,
	        		BETWEEN_PAGES_HTML);
	        
	        exporter.exportReport();
	        
	        //����ϵͳ��־
			systemLogService.save(new Date(), 1, admin,
					"["+admin.getId()+"]"+admin.getUsername()+"�û��������ڴ�"+startTime+"��"+endTime+"��HTML��ʽͨ�з����շ�Ա����",
					"�������--ͨ�зѱ���--ͨ�з����շ�Ա����", "tb_OutListSum");
	        
		} catch (JRException e) {		
			systemLogService.save(new Date(), 2, admin, "HTML��ʽͨ�з����շ�Ա����JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽͨ�з����շ�Ա����IO�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽͨ�з����շ�Ա����Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * PDF��ʽͨ�з����շ�Ա����
	 * @return
	 */
	public String tollsCollectorDayReportPDF(){
		try{
			admin = this.getCurrentOperator();
			//��ȡ����С������
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			admin = adminService.get(getCurrentOperator().getId());
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//OutputStream outputStream = null;
			
			//�������ɵı����¼����
		    int count = reportService.countTollsCollectorDay(startTime, endTime, areaNoValue, parkNoValue);
		    if(count > 20000) {
		    	message = "����PDF��ʽͨ�з����շ�Ա���������������ѳ���20000����������ѡ���С�����ڷ�Χ";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			
			//����pdf�ļ���
			ServletActionContext.getResponse().setHeader("Content-Disposition",
					"attachment; filename=tollsReport_tollsCollectorDayReportPDF.pdf");
			//ServletActionContext.getResponse().setHeader("Content-Disposition", "inline;filename=report_tollsTradeDayReportPDF.pdf");
			
			this.reportService.tollsPdfStream(inputStream, outputStream, startTime, endTime,
					areaNoValue, parkNoValue, getCurrentOperator().getName());
			ServletActionContext.getResponse().setContentType("application/pdf");
			
//			//����ϵͳ��־
//			systemLogService.save(new Date(), 1, admin,
//					admin.getUsername()+"�û��������ڴ�"+startTime+"��"+endTime+"��PDF��ʽͨ�з����շ�Ա����",
//					"�������--ͨ�зѱ���--ͨ�з����շ�Ա����", "tb_OutListSum");
			
			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽͨ�з����շ�Ա����JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽͨ�з����շ�Ա����IO�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽͨ�з����շ�Ա����Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * HTML��ʽͨ�зѷ��˰��ʱ�α���
	 * @return
	 */
	public String tollsOperSquadDatesReport(){
		try {
			admin = this.getCurrentOperator();
			//��ȡ����С������
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8");
			
			//�������ɵı����¼����
		    int count = reportService.countTollsOperSquadDates(startTime, endTime, areaNoValue, parkNoValue,
					pSquadNo, pOperatorNo);
		    if(count > 10000) {
		    	message = "����HTMLͨ�зѷ��˰��ʱ�α��������������ѳ���10000����������ѡ���С�����ڷ�Χ";
		    	return ERROR;
		    }
		    
			JasperPrint print = this.reportService.operSquadDatesFillReport(jasper1, startTime, endTime, 
					areaNoValue, parkNoValue, pSquadNo, pOperatorNo, getCurrentOperator().getName());
			
			JRHtmlExporter exporter = new JRHtmlExporter();
			
			exporter.setParameter(JRExporterParameter.JASPER_PRINT, print);
			exporter.setParameter(JRExporterParameter.OUTPUT_WRITER, response.getWriter());
			exporter.setParameter(
					JRHtmlExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,
					new Boolean(false));// �Ƿ�ȥ���м�Ŀհ�
			exporter.setParameter(
					JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
					Boolean.FALSE);// �Ƿ����ͼƬ����
			exporter.setParameter(
					JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
					Boolean.FALSE);// ��������Ƿ���СͼƬ����
			exporter.setParameter(JRHtmlExporterParameter.IS_WRAP_BREAK_WORD,
					Boolean.TRUE);// ��������Ƿ�ǿ�ư�װ�쳣����
			
			//��ӡ��ҳ
			String BETWEEN_PAGES_HTML = "<p style='page-break-after:always;'> </p>";
	        exporter.setParameter(JRHtmlExporterParameter.BETWEEN_PAGES_HTML,
	        		BETWEEN_PAGES_HTML);
	        
	        //����ϵͳ��־
			systemLogService.save(new Date(), 1, admin,
					"["+admin.getId()+"]"+admin.getUsername()+"�û��������ڴ�"+startTime+"��"+endTime+"��HTML��ʽͨ�зѷ��˰��ʱ�α���",
					"�������--ͨ�зѱ���--ͨ�зѷ��˰��ʱ�α���", "tb_OutListSum");

			exporter.exportReport();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽͨ�зѷ��˰��ʱ�α���JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽͨ�зѷ��˰��ʱ�α���IO�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽͨ�зѷ��˰��ʱ�α���Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * PDF��ʽͨ�зѷ��˰��ʱ�α���
	 * @return
	 */
	public String tollsOperSquadDatesReportPDF(){
		try{
			admin = this.getCurrentOperator();
			//��ȡ����С������
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//�������ɵı����¼����
		    int count = reportService.countTollsOperSquadDates(startTime, endTime, areaNoValue, parkNoValue,
					pSquadNo, pOperatorNo);
		    if(count > 20000) {
		    	message = "����PDFͨ�зѷ��˰��ʱ�α��������������ѳ���20000����������ѡ���С�����ڷ�Χ";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			//����pdf�ļ���
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename="+"tollsReport_tollsOperSquadDatesReportPDF.pdf");
			
			this.reportService.operSquadDatesPdfStream(inputStream, outputStream, startTime, endTime, areaNoValue, parkNoValue,
					pSquadNo, pOperatorNo, getCurrentOperator().getName());
			ServletActionContext.getResponse().setContentType("application/pdf");
			
//			//����ϵͳ��־
//			systemLogService.save(new Date(), 1, admin,
//					admin.getUsername()+"�û��������ڴ�"+startTime+"��"+endTime+"��PDF��ʽͨ�зѷ��˰��ʱ�α���",
//					"�������--ͨ�зѱ���--ͨ�зѷ��˰��ʱ�α���", "tb_OutListSum");
			
			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽͨ�зѷ��˰��ʱ�α���JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽͨ�зѷ��˰��ʱ�α���IO�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽͨ�зѷ��˰��ʱ�α���Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		
		return null;
	}
	
	/**
	 * HTML��ʽͨ�з���ͳ�Ʊ���
	 * @return
	 */
	public String tollsDayStatisticsReport(){
		try {
			admin = this.getCurrentOperator();
			//��ȡ����С������
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
//			admin = adminService.get(getCurrentOperator().getId());
			
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8");
			
			//�������ɵı����¼����
		    int count = reportService.countTollsDayStatistics(startTime, endTime, areaNoValue, parkNoValue);
		    if(count > 10000) {
		    	message = "����HTMLͨ�з���ͳ�Ʊ��������������ѳ���10000����������ѡ���С�����ڷ�Χ";
		    	return ERROR;
		    }
		    
			JasperPrint print=this.reportService.tollsFillReport(jasper1, startTime, endTime, 
					areaNoValue, parkNoValue, getCurrentOperator().getName());
			
			JRHtmlExporter exporter = new JRHtmlExporter();
			
			exporter.setParameter(JRExporterParameter.JASPER_PRINT, print);
			exporter.setParameter(JRExporterParameter.OUTPUT_WRITER, response.getWriter());
			exporter.setParameter(
					JRHtmlExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,
					new Boolean(false));// �Ƿ�ȥ���м�Ŀհ�
			exporter.setParameter(
					JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
					Boolean.FALSE);// �Ƿ����ͼƬ����
			exporter.setParameter(
					JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
					Boolean.FALSE);// ��������Ƿ���СͼƬ����
			exporter.setParameter(JRHtmlExporterParameter.IS_WRAP_BREAK_WORD,
					Boolean.TRUE);// ��������Ƿ�ǿ�ư�װ�쳣����
			
			//��ӡ��ҳ
			String BETWEEN_PAGES_HTML = "<p style='page-break-after:always;'> </p>";
	        exporter.setParameter(JRHtmlExporterParameter.BETWEEN_PAGES_HTML,
	        		BETWEEN_PAGES_HTML);

			exporter.exportReport();
			
			//����ϵͳ��־
			systemLogService.save(new Date(), 1, admin,
					"["+admin.getId()+"]"+admin.getUsername()+"�û��������ڴ�"+startTime+"��"+endTime+"��HTML��ʽͨ�з���ͳ�Ʊ���",
					"�������--ͨ�зѱ���--ͨ�з���ͳ�Ʊ���", "tb_OutListSum");
			
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽͨ�з���ͳ�Ʊ���JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽͨ�з���ͳ�Ʊ���IO�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽͨ�з���ͳ�Ʊ���Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * PDF��ʽͨ�з���ͳ�Ʊ���
	 * @return
	 */
	public String tollsDayStatisticsReportPDF(){
		try{
			admin = this.getCurrentOperator();
			//��ȡ����С������
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//�������ɵı����¼����
		    int count = reportService.countTollsDayStatistics(startTime, endTime, areaNoValue, parkNoValue);
		    if(count > 20000) {
		    	message = "����PDF��ʽͨ�з���ͳ�Ʊ��������������ѳ���20000����������ѡ���С�����ڷ�Χ";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			
			//����pdf�ļ���
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename=tollsReport_tollsDayStatisticsReportPDF.pdf");
			//ServletActionContext.getResponse().setHeader("Content-Disposition", "inline;filename=report_tollsTradeDayReportPDF.pdf");
			
			this.reportService.tollsPdfStream(inputStream, outputStream, startTime, endTime, 
					areaNoValue, parkNoValue, getCurrentOperator().getName());
			ServletActionContext.getResponse().setContentType("application/pdf");
			
//			//����ϵͳ��־
//			systemLogService.save(new Date(), 1, admin,
//					admin.getUsername()+"�û��������ڴ�"+startTime+"��"+endTime+"��PDF��ʽͨ�з���ͳ�Ʊ���",
//					"�������--ͨ�зѱ���--ͨ�з���ͳ�Ʊ���", "tb_OutListSum");
			
			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽͨ�з���ͳ�Ʊ���JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽͨ�з���ͳ�Ʊ���IO�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽͨ�з���ͳ�Ʊ���Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * HTML��ʽͨ�зѷ��ŷֳ����ձ���
	 * @return
	 */
	public String tollsGateLaneDayReport(){
		try {
			admin = this.getCurrentOperator();
			//��ȡ����С������
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8");
			
			//�������ɵı����¼����
		    int count = reportService.countTollsGateLaneDay(startTime, endTime, areaNoValue, parkNoValue);
		    if(count > 10000) {
		    	message = "����HTMLͨ�зѷ��ŷֳ����ձ����������������ѳ���10000����������ѡ���С�����ڷ�Χ";
		    	return ERROR;
		    }
		    
			JasperPrint print = this.reportService.tollsFillReport(jasper1, startTime, endTime, 
					areaNoValue, parkNoValue, getCurrentOperator().getName());
			
			JRHtmlExporter exporter = new JRHtmlExporter();
			
			exporter.setParameter(JRExporterParameter.JASPER_PRINT, print);
			exporter.setParameter(JRExporterParameter.OUTPUT_WRITER, response.getWriter());
			exporter.setParameter(
					JRHtmlExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,
					new Boolean(false));// �Ƿ�ȥ���м�Ŀհ�
			exporter.setParameter(
					JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
					Boolean.FALSE);// �Ƿ����ͼƬ����
			exporter.setParameter(
					JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
					Boolean.FALSE);// ��������Ƿ���СͼƬ����
			exporter.setParameter(JRHtmlExporterParameter.IS_WRAP_BREAK_WORD,
					Boolean.TRUE);// ��������Ƿ�ǿ�ư�װ�쳣����
			
			//��ӡ��ҳ
			String BETWEEN_PAGES_HTML = "<p style='page-break-after:always;'> </p>";
	        exporter.setParameter(JRHtmlExporterParameter.BETWEEN_PAGES_HTML,
	        		BETWEEN_PAGES_HTML);

			exporter.exportReport();
			
			//����ϵͳ��־
			systemLogService.save(new Date(), 1, admin,
					"["+admin.getId()+"]"+admin.getUsername()+"�û��������ڴ�"+startTime+"��"+endTime+"��HTML��ʽͨ�зѷ��ŷֳ����ձ���",
					"�������--ͨ�зѱ���--ͨ�зѷ��ŷֳ����ձ���", "tb_OutListSum");
			
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽͨ�зѷ��ŷֳ����ձ���JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽͨ�зѷ��ŷֳ����ձ���IO�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽͨ�зѷ��ŷֳ����ձ���Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * PDF��ʽͨ�зѷ��ŷֳ����ձ���
	 * @return
	 */
	public String tollsGateLaneDayReportPDF(){
		try{
			admin = this.getCurrentOperator();
			//��ȡ����С������
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//�������ɵı����¼����
		    int count = reportService.countTollsGateLaneDay(startTime, endTime, areaNoValue, parkNoValue);
		    if(count > 20000) {
		    	message = "����PDF��ʽͨ�зѷ��ŷֳ����ձ��������������ѳ���20000����������ѡ���С�����ڷ�Χ";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			
			//����pdf�ļ���
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename=tollsReport_tollsGateLaneDayReportPDF.pdf");
			
			this.reportService.tollsPdfStream(inputStream, outputStream, startTime, endTime, 
					areaNoValue, parkNoValue, getCurrentOperator().getName());
			ServletActionContext.getResponse().setContentType("application/pdf");
			
//			//����ϵͳ��־
//			systemLogService.save(new Date(), 1, admin,
//					admin.getUsername()+"�û��������ڴ�"+startTime+"��"+endTime+"��PDF��ʽͨ�зѷ��ŷֳ����ձ���",
//					"�������--ͨ�зѱ���--ͨ�зѷ��ŷֳ����ձ���", "tb_OutListSum");
			
			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽͨ�зѷ��ŷֳ����ձ���JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽͨ�зѷ��ŷֳ����ձ���IO�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽͨ�зѷ��ŷֳ����ձ���Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	
	
	/**
	 * HTML��ʽͨ�з��±���
	 * @return
	 */
	public String tollsTradeMonthReport(){
		try {
			admin = this.getCurrentOperator();
			//��ȡ����С������
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
		    response.setCharacterEncoding("utf-8");
		    
		    //�������ɵı����¼����
		    int count = reportService.countTollsTradeMonth(startTime, endTime, areaNoValue, parkNoValue);
		    if(count > 10000) {
		    	message = "����HTML��ʽͨ�з��±��������������ѳ���10000����������ѡ���С�����ڷ�Χ";
		    	return ERROR;
		    }
	    
			JasperPrint print=this.reportService.tollsFillReport(jasper1, startTime, endTime,
					areaNoValue, parkNoValue, getCurrentOperator().getName());
			
			JRHtmlExporter exporter = new JRHtmlExporter();
			 
	        exporter.setParameter(JRExporterParameter.JASPER_PRINT, print);
	        exporter.setParameter(JRExporterParameter.OUTPUT_WRITER, response.getWriter());
	        exporter.setParameter(
	        	     JRHtmlExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,
	        	     new Boolean(false));// �Ƿ�ȥ���м�Ŀհ�
	        exporter.setParameter(
	        	     JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
	        	     Boolean.FALSE);// �Ƿ����ͼƬ����
	        exporter.setParameter(
	        	     JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
	        	     Boolean.FALSE);// ��������Ƿ���СͼƬ����
	        exporter.setParameter(JRHtmlExporterParameter.IS_WRAP_BREAK_WORD,
	        	     Boolean.TRUE);// ��������Ƿ�ǿ�ư�װ�쳣����
	        
	        //��ӡ��ҳ
	        String BETWEEN_PAGES_HTML = "<p style='page-break-after:always;'> </p>";
	        exporter.setParameter(JRHtmlExporterParameter.BETWEEN_PAGES_HTML,
	        		BETWEEN_PAGES_HTML);

	        exporter.exportReport();
	        
	        //����ϵͳ��־
			systemLogService.save(new Date(), 1, admin,
					"["+admin.getId()+"]"+admin.getUsername()+"�û��������ڴ�"+startTime+"��"+endTime+"��HTML��ʽͨ�з��±���",
					"�������--ͨ�зѱ���--ͨ�з��±���", "tb_OutListSum");
	        
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽͨ�з��±���JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽͨ�з��±���IO�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽͨ�з��±���Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * PDF��ʽͨ�з��±���
	 * @return
	 */
	public String tollsTradeMonthReportPDF(){
		try{
			admin = this.getCurrentOperator();
			//��ȡ����С������
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//�������ɵı����¼����
		    int count = reportService.countTollsTradeMonth(startTime, endTime, areaNoValue, parkNoValue);
		    if(count > 20000) {
		    	message = "����PDF��ʽͨ�з��±��������������ѳ���20000����������ѡ���С�����ڷ�Χ";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			//����pdf�ļ���
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename="+"tollsReport_tollsTradeMonthReportPDF.pdf");
			
			this.reportService.tollsPdfStream(inputStream, outputStream, startTime, endTime, areaNoValue, parkNoValue, getCurrentOperator().getName());
			ServletActionContext.getResponse().setContentType("application/pdf");
			
//			//����ϵͳ��־
//			systemLogService.save(new Date(), 1, admin,
//					admin.getUsername()+"�û��������ڴ�"+startTime+"��"+endTime+"��PDF��ʽͨ�з��±���",
//					"�������--ͨ�зѱ���--ͨ�з��±���", "tb_OutListSum");

			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽͨ�з��±���JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽͨ�з��±���IOException�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽͨ�з��±���Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * HTML��ʽ�ɷѿ����ױ���
	 * @return
	 */
	public String payCardTradeReport(){
		try {
			admin = this.getCurrentOperator();
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8");
			
			//ȡ����0,1,2,3,4�ĸ�ֵ
			String[] ids = tradeType.split(",");
			String tradeType0 = ids[0];
			String tradeType1 = ids[1];
			String tradeType2 = ids[2];
			String tradeType3 = ids[3];
			String tradeType4 = ids[4];
			
			//�������ɵı����¼����
		    int count = reportService.countPayCardTrade(startTime, endTime + " 23:59:59", tradeType0, tradeType1,
					tradeType2, tradeType3, tradeType4, account.getSys_id(), user.getUserName(), 
					car.getVehPlate(), account.getCardNo(), user.getCredentialsNo(), account.getStatus());
		    if(count > 10000) {
		    	message = "����HTML��ʽ�ɷѿ����ױ��������������ѳ���10000����������ѡ���С�����ڷ�Χ";
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
					new Boolean(false));// �Ƿ�ȥ���м�Ŀհ�
			exporter.setParameter(
					JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
					Boolean.FALSE);// �Ƿ����ͼƬ����
			exporter.setParameter(
					JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
					Boolean.FALSE);// ��������Ƿ���СͼƬ����
			exporter.setParameter(JRHtmlExporterParameter.IS_WRAP_BREAK_WORD,
					Boolean.TRUE);// ��������Ƿ�ǿ�ư�װ�쳣����
					
			//��ӡ��ҳ
			String BETWEEN_PAGES_HTML = "<p style='page-break-after:always;'> </p>";
			exporter.setParameter(JRHtmlExporterParameter.BETWEEN_PAGES_HTML,
			        		BETWEEN_PAGES_HTML);
					
			exporter.exportReport();
			
			//����ϵͳ��־
			systemLogService.save(new Date(), 1, admin,
					"["+admin.getId()+"]"+admin.getUsername()+"�û��������ڴ�"+startTime+"��"+endTime+"��HTML��ʽ�ɷѿ����ױ���",
					"�������--ͨ�зѱ���--�ɷѿ����ױ���", "v_AccountTrade");
			
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ�ɷѿ����ױ���JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ�ɷѿ����ױ���IO�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ�ɷѿ����ױ���Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * PDF��ʽ�ɷѿ����ױ���
	 * @return
	 */
	public String payCardTradeReportPDF(){
		try{
			admin = this.getCurrentOperator();
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);	
			//ȡ����0,1,2,3,4�ĸ�ֵ
			String[] ids = tradeType.split(",");
			String tradeType0 = ids[0];
			String tradeType1 = ids[1];
			String tradeType2 = ids[2];
			String tradeType3 = ids[3];
			String tradeType4 = ids[4];
			
			//�������ɵı����¼����
		    int count = reportService.countPayCardTrade(startTime, endTime + " 23:59:59", tradeType0, tradeType1,
					tradeType2, tradeType3, tradeType4, account.getSys_id(), user.getUserName(), 
					car.getVehPlate(), account.getCardNo(), user.getCredentialsNo(), account.getStatus());
		    if(count > 20000) {
		    	message = "����PDF��ʽ�ɷѿ����ױ��������������ѳ���20000����������ѡ���С�����ڷ�Χ";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			//����pdf�ļ���
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename="+"tollsReport_payCardTradeReportPDF.pdf");
			
			this.reportService.pdfStreamFormate(inputStream, outputStream, startTime, endTime + " 23:59:59", tradeType0, tradeType1,
					tradeType2, tradeType3, tradeType4, getCurrentOperator().getName(), account.getSys_id(), user.getUserName(), 
					car.getVehPlate(), account.getCardNo(), user.getCredentialsNo(), account.getStatus());
			ServletActionContext.getResponse().setContentType("application/pdf");
			
//			//����ϵͳ��־
//			systemLogService.save(new Date(), 1, admin,
//					admin.getUsername()+"�û��������ڴ�"+startTime+"��"+endTime+"��PDF��ʽ�ɷѿ����ױ���",
//					"�������--ͨ�зѱ���--�ɷѿ����ױ���", "v_AccountTrade");
			
			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ�ɷѿ����ױ���JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ�ɷѿ����ױ���IO�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ�ɷѿ����ױ���Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * HTML��ʽ��ӡ�˵�����
	 * @return
	 */
	public String printBillReport(){
		try {
			admin = this.getCurrentOperator();
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8");
			
			//ȡ����0,1,2,3,4�ĸ�ֵ
			String[] ids = tradeType.split(",");
			String tradeType0 = ids[0];
			String tradeType1 = ids[1];
			
			//�������ɵı����¼����
		    int count = reportService.countPrintBill(startTime, endTime + " 23:59:59", tradeType0, tradeType1);
		    if(count > 10000) {
		    	message = "����HTML��ӡ�˵����������������ѳ���10000����������ѡ���С�����ڷ�Χ";
		    	return ERROR;
		    }
		
			JasperPrint print = this.reportService.fillReport(jasper1, startTime, endTime + " 23:59:59",
					tradeType0, tradeType1, getCurrentOperator().getName());
			
			JRHtmlExporter exporter = new JRHtmlExporter();
			
			exporter.setParameter(JRExporterParameter.JASPER_PRINT, print);
			exporter.setParameter(JRExporterParameter.OUTPUT_WRITER, response.getWriter());
			exporter.setParameter(
					JRHtmlExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,
					new Boolean(false));// �Ƿ�ȥ���м�Ŀհ�
			exporter.setParameter(
					JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
					Boolean.FALSE);// �Ƿ����ͼƬ����
			exporter.setParameter(
					JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
					Boolean.FALSE);// ��������Ƿ���СͼƬ����
			exporter.setParameter(JRHtmlExporterParameter.IS_WRAP_BREAK_WORD,
					Boolean.TRUE);// ��������Ƿ�ǿ�ư�װ�쳣����
			
			//��ӡ��ҳ
			String BETWEEN_PAGES_HTML = "<p style='page-break-after:always;'> </p>";
	        exporter.setParameter(JRHtmlExporterParameter.BETWEEN_PAGES_HTML,
	        		BETWEEN_PAGES_HTML);

			exporter.exportReport();
			
			//����ϵͳ��־
			systemLogService.save(new Date(), 1, admin,
					"["+admin.getId()+"]"+admin.getUsername()+"�û��������ڴ�"+startTime+"��"+endTime+"��HTML��ʽ��ӡ�˵�����",
					"�������--ͨ�зѱ���--��ӡ�˵�����", "v_AccountTrade");
			
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ��ӡ�˵�����JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ��ӡ�˵�����IO�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ��ӡ�˵�����Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * PDF��ʽ��ӡ�˵�����
	 * @return
	 */
	public String printBillReportPDF(){
		try{
			admin = this.getCurrentOperator();
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			//ȡ����0,1,2,3,4�ĸ�ֵ
			String[] ids = tradeType.split(",");
			String tradeType0 = ids[0];
			String tradeType1 = ids[1];
			
			//�������ɵı����¼����
		    int count = reportService.countPrintBill(startTime, endTime + " 23:59:59", tradeType0, tradeType1);
		    if(count > 20000) {
		    	message = "����PDF��ӡ�˵����������������ѳ���20000����������ѡ���С�����ڷ�Χ";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			//����pdf�ļ���
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename="+"tollsReport_printBillReportPDF.pdf");
			
			this.reportService.pdfStreamFormate(inputStream, outputStream, startTime, endTime + " 23:59:59",
					tradeType0, tradeType1, getCurrentOperator().getName());
			ServletActionContext.getResponse().setContentType("application/pdf");
			
//			//����ϵͳ��־
//			systemLogService.save(new Date(), 1, admin,
//					admin.getUsername()+"�û��������ڴ�"+startTime+"��"+endTime+"��PDF��ʽ��ӡ�˵�����",
//					"�������--ͨ�зѱ���--��ӡ�˵�����", "v_AccountTrade");
			
			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ��ӡ�˵�����JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ��ӡ�˵�����IO�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ��ӡ�˵�����Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
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
	 * HTML��ʽͨ�зѷֳ�����ʱ�α���
	 * @return
	 */
	public String tollsLaneReport() {
		try {
			admin = this.getCurrentOperator();
			//��ȡ����С������
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			//int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8");
			
			//�������ɵı����¼����
			int count = reportService.countTollsLane(startTime, endTime, areaNoValue, parkNo,pLaneNo);
			if (count > 10000) {
				message ="����HTMLͨ�зѷֳ�����ʱ�α��������������ѳ���10000����������ѡ���С�����ڷ�Χ";
				return ERROR;
			}
			JasperPrint print = this.reportService.laneFillReport(jasper1, startTime, endTime, areaNoValue, parkNo, pLaneNo, getCurrentOperator().getName());

			JRHtmlExporter exporter = new JRHtmlExporter();
			
			exporter.setParameter(JRExporterParameter.JASPER_PRINT, print);
			exporter.setParameter(JRExporterParameter.OUTPUT_WRITER, response.getWriter());
			exporter.setParameter(
					JRHtmlExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,
					new Boolean(false));// �Ƿ�ȥ���м�Ŀհ�
			exporter.setParameter(
					JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
					Boolean.FALSE);// �Ƿ����ͼƬ����
			exporter.setParameter(
					JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
					Boolean.FALSE);// ��������Ƿ���СͼƬ����
			exporter.setParameter(JRHtmlExporterParameter.IS_WRAP_BREAK_WORD,
					Boolean.TRUE);// ��������Ƿ�ǿ�ư�װ�쳣����
			
			//��ӡ��ҳ
			String BETWEEN_PAGES_HTML = "<p style='page-break-after:always;'> </p>";
	        exporter.setParameter(JRHtmlExporterParameter.BETWEEN_PAGES_HTML,
	        		BETWEEN_PAGES_HTML);
			
	        //����ϵͳ��־
			systemLogService.save(new Date(), 1, admin,
					"["+admin.getId()+"]"+admin.getUsername()+"�û��������ڴ�"+startTime+"��"+endTime+"��HTML��ʽͨ�зѷֳ�����ʱ�α���",
					"�������--ͨ�зѱ���--ͨ�зѷֳ�����ʱ�α���", "tb_OutListSum");
			
			exporter.exportReport();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽͨ�зѷֳ�����ʱ�α���JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽͨ�зѷֳ�����ʱ�α���IO�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽͨ�зѷֳ�����ʱ�α���Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;	
	}
	
	/**
	 * PDF��ʽͨ�зѷֳ�����ʱ�α���
	 * @return
	 */
	public String tollsLaneReportPDF() {

			try{
				admin = this.getCurrentOperator();
				//��ȡ����С������
				getSysparamconf();
				
				int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
				
				InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
				
				//�������ɵı����¼����
			    int count = reportService.countTollsLane(startTime, endTime, areaNoValue, parkNo, pLaneNo);
			    if(count > 20000) {
			    	message = "����PDFͨ�зѷֳ�����ʱ�α��������������ѳ���20000����������ѡ���С�����ڷ�Χ";
			    	return ERROR;
			    }
			
				OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
				//����pdf�ļ���
				ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename="+"tollsReport_tollsLaneReportPDF.pdf");
				
				this.reportService.lanePdfStream(inputStream, outputStream, startTime, endTime, areaNoValue, parkNo, pLaneNo, getCurrentOperator().getName());
				ServletActionContext.getResponse().setContentType("application/pdf");
				
//				//����ϵͳ��־
//				systemLogService.save(new Date(), 1, admin,
//						admin.getUsername()+"�û��������ڴ�"+startTime+"��"+endTime+"��PDF��ʽͨ�зѷֳ�����ʱ�α���",
//						"�������--ͨ�зѱ���--ͨ�зѷֳ�����ʱ�α���", "tb_OutListSum");
				
				outputStream.flush();
				outputStream.close();
			} catch (JRException e) {
				systemLogService.save(new Date(), 2, admin, "PDF��ʽͨ�зѷֳ�����ʱ�α���JRException�쳣", e.getMessage(), "JRException");
				e.printStackTrace();
			} catch (IOException e) {
				systemLogService.save(new Date(), 2, admin, "PDF��ʽͨ�зѷֳ�����ʱ�α���IO�쳣", e.getMessage(), "IOException");
				e.printStackTrace();
			} catch (Exception e) {
				systemLogService.save(new Date(), 2, admin, "PDF��ʽͨ�зѷֳ�����ʱ�α���Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
				e.printStackTrace();
			}
			
			return null;
		}
	
	/**
	 * HTML��ʽͨ�з�Ӧ���ֽ���˰��ʱ�α���
	 * @return
	 */
	public String tollsCashMoneyOperSquadDatesReport(){
		try {
			admin = this.getCurrentOperator();
			//��ȡ����С������
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8");
			
			//�������ɵı����¼����
		    int count = reportService.countTollsCashMoneyOperSquadDates(startTime, endTime, areaNoValue, parkNoValue,
					pSquadNo, pOperatorNo);
		    if(count > 10000) {
		    	message = "����HTMLͨ�з�Ӧ���ֽ���˰��ʱ�α��������������ѳ���10000����������ѡ���С�����ڷ�Χ";
		    	return ERROR;
		    }
		    
			JasperPrint print = this.reportService.cashMoneyOperSquadDatesFillReport(jasper1, startTime, endTime, 
					areaNoValue, parkNoValue, pSquadNo, pOperatorNo, getCurrentOperator().getName());
			
			JRHtmlExporter exporter = new JRHtmlExporter();
			
			exporter.setParameter(JRExporterParameter.JASPER_PRINT, print);
			exporter.setParameter(JRExporterParameter.OUTPUT_WRITER, response.getWriter());
			exporter.setParameter(
					JRHtmlExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,
					new Boolean(false));// �Ƿ�ȥ���м�Ŀհ�
			exporter.setParameter(
					JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
					Boolean.FALSE);// �Ƿ����ͼƬ����
			exporter.setParameter(
					JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN,
					Boolean.FALSE);// ��������Ƿ���СͼƬ����
			exporter.setParameter(JRHtmlExporterParameter.IS_WRAP_BREAK_WORD,
					Boolean.TRUE);// ��������Ƿ�ǿ�ư�װ�쳣����
			
			//��ӡ��ҳ
			String BETWEEN_PAGES_HTML = "<p style='page-break-after:always;'> </p>";
	        exporter.setParameter(JRHtmlExporterParameter.BETWEEN_PAGES_HTML,
	        		BETWEEN_PAGES_HTML);
	        
	        //����ϵͳ��־
			systemLogService.save(new Date(), 1, admin,
					"["+admin.getId()+"]"+admin.getUsername()+"�û��������ڴ�"+startTime+"��"+endTime+"��HTML��ʽͨ�з�Ӧ���ֽ���˰��ʱ�α���",
					"�������--ͨ�зѱ���--ͨ�з�Ӧ���ֽ���˰��ʱ�α���", "tb_OutListSum");

			exporter.exportReport();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽͨ�з�Ӧ���ֽ���˰��ʱ�α���JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽͨ�з�Ӧ���ֽ���˰��ʱ�α���IO�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽͨ�з�Ӧ���ֽ���˰��ʱ�α���Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * PDF��ʽͨ�з�Ӧ���ֽ���˰��ʱ�α���
	 * @return
	 */
	public String tollsCashMoneyOperSquadDatesReportPDF(){
		try{
			admin = this.getCurrentOperator();
			//��ȡ����С������
			getSysparamconf();
			
			int areaNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(sysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//�������ɵı����¼����
		    int count = reportService.countTollsCashMoneyOperSquadDates(startTime, endTime, areaNoValue, parkNoValue,
					pSquadNo, pOperatorNo);
		    if(count > 20000) {
		    	message = "����PDFͨ�з�Ӧ���ֽ���˰��ʱ�α��������������ѳ���20000����������ѡ���С�����ڷ�Χ";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			//����pdf�ļ���
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename="+"tollsReport_tollsOperSquadDatesReportPDF.pdf");
			
			this.reportService.cashMoneyOperSquadDatesPdfStream(inputStream, outputStream, startTime, endTime, areaNoValue, parkNoValue,
					pSquadNo, pOperatorNo, getCurrentOperator().getName());
			ServletActionContext.getResponse().setContentType("application/pdf");
			
//			//����ϵͳ��־
//			systemLogService.save(new Date(), 1, admin,
//					admin.getUsername()+"�û��������ڴ�"+startTime+"��"+endTime+"��PDF��ʽͨ�з�Ӧ���ֽ���˰��ʱ�α���",
//					"�������--ͨ�зѱ���--ͨ�з�Ӧ���ֽ���˰��ʱ�α���", "tb_OutListSum");
			
			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽͨ�з�Ӧ���ֽ���˰��ʱ�α���JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽͨ�з�Ӧ���ֽ���˰��ʱ�α���IO�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽͨ�з�Ӧ���ֽ���˰��ʱ�α���Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		
		return null;
	}
	
	// Getters/Setters����
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
