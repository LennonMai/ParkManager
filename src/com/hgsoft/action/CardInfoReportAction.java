package com.hgsoft.action;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.export.JRHtmlExporter;
import net.sf.jasperreports.engine.export.JRHtmlExporterParameter;
import net.sf.jasperreports.engine.export.JRXlsExporter;
import net.sf.jasperreports.engine.export.JRXlsExporterParameter;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hgsoft.entity.Admin;
import com.hgsoft.entity.CarSmallType;
import com.hgsoft.entity.CarType;
import com.hgsoft.entity.CardType;
import com.hgsoft.entity.Sysparamconf;
import com.hgsoft.entity.SystemLog;
import com.hgsoft.service.AdminService;
import com.hgsoft.service.CarSmallTypeService;
import com.hgsoft.service.CarTypeService;
import com.hgsoft.service.OwnerIdentityService;
import com.hgsoft.service.ReportService;
import com.hgsoft.service.SysparamconfService;
import com.hgsoft.service.SystemLogService;
import com.hgsoft.service.UserCardTypeService;
import com.opensymphony.xwork2.ActionContext;


/**
 * @author caijunhua
 * @date November 18, 2010
 * @Description ����Ϣ���������
 */

@Controller
@Scope("prototype")
public class CardInfoReportAction extends BaseAction {
	@Resource
	private ReportService reportService;
	@Resource
	private SystemLogService systemLogService;
	@Resource
	private AdminService adminService;
	@Resource
	private SysparamconfService sysparamconfService;
	@Resource
	private CarTypeService carTypeService;
	@Resource
	private CarSmallTypeService carSmallTypeService;
	
	private SystemLog systemlog;
	private Admin admin;
	private Sysparamconf param_parkReport;
	
	private String startTime;
	private String endTime;
	private String jasper;
	private String jasperPDF;
	private String jasperExcel;
	private String parkReport = "parkReport";
	private String parkReport_remark = "��cardInfoReport���Ǹ�У����jsp�ļ������ֵΪhg������cardInfoReprot�ļ����µ�hg�ļ����е�jsp����ʼֵΪhg";
	private Integer carType;
	private String parkingSpace;
	private List listCarType;
	
	public String getStartTime() {
		return startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public void setJasper(String jasper) {
		this.jasper = jasper;
	}
	public void setJasperPDF(String jasperPDF) {
		this.jasperPDF = jasperPDF;
	}
	
	/**
	 * ����ϸ��Ϣ��ѯҳ��
	 * @return
	 */
	public String cardInfo() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		endTime=sdf.format(new Date());
		param_parkReport = sysparamconfService.queryOrSave(parkReport, "hg", parkReport_remark, "CardInfoReportAction��cardInfo()����parkReport����ʱset������get��������ʱ���쳣", admin);
		return "cardInfo";
	}
	
	
	/**
	 * ��ʱ����̬�����ѯҳ��
	 * @return
	 */
	public String cardDynamic() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		endTime=sdf.format(new Date());
		return "cardDynamic";
	}
	/**
	 * �±����ɷѼ�¼�����ѯҳ��
	 * @return
	 */
	public String carMonthBill() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		endTime=sdf.format(new Date());
		return "carMonthBill";
	}
	/**
	 * �±����ɷ���ͳ�Ʊ����ѯҳ��
	 * @return
	 */
	public String carMonthBillDay() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		endTime=sdf.format(new Date());
		return "carMonthBillDay";
	}
	/**
	 * �±����ɷ�������ͳ�Ʊ����ѯҳ��
	 * @return
	 */
	public String carMonthBillDayType() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		endTime=sdf.format(new Date());
		return "carMonthBillDayType";
	}
	/**
	 * ���⿨�ɷѱ����ѯҳ��
	 * @return
	 */
	public String carMonthParking(){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		endTime=sdf.format(new Date());
		return "carMonthParking";
	}
	
	/**
	 * HTML��ʽ����ϸ��Ϣ����
	 * @return
	 */
	public String cardInfoReport() {
		try {
			admin = adminService.get(getCurrentOperator().getId());
			HttpServletResponse response = ServletActionContext.getResponse();
			
			String temp = "/WEB-INF/jsp/report/cardInfoReport/"+param_parkReport.getPvalue()+"/jasper/cardInfoReport.jasper";
			String jasper1 = ServletActionContext.getServletContext().getRealPath(temp);
			//String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
		    response.setCharacterEncoding("utf-8");
		    
		    //�������ɵı����¼����
		    int count = reportService.countCardInfo(startTime, endTime + " 23:59:59");
		    if(count > 10000) {
		    	message = "����HTML��ʽ����ϸ��Ϣ���������������ѳ���10000����������ѡ���С�����ڷ�Χ";
		    	return ERROR;
		    }
		    
			JasperPrint print = this.reportService.fillReport(jasper1, startTime, endTime + " 23:59:59", getCurrentOperator().getName());
			
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
	        Admin admin = this.getCurrentOperator();
			systemLogService.save(new Date(), 1, admin,
					"["+admin.getId()+"]"+admin.getUsername()+"�û��������ڴ�"+startTime+"��"+endTime+"��HTML��ʽ����ϸ��Ϣ����",
					"�������--����Ϣ����--����ϸ��Ϣ����", "tb_usercardinfo");
	        
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ����ϸ��Ϣ����JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ����ϸ��Ϣ����IO�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ����ϸ��Ϣ����Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * PDF��ʽ����ϸ��Ϣ����
	 * @return
	 */
	public String cardInfoReportPDF() {
		try{
			admin = adminService.get(getCurrentOperator().getId());
			String jasperPDF = "/WEB-INF/jsp/report/cardInfoReport/"+param_parkReport.getPvalue()+"/jasper/cardInfoReport.jasper";
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//�������ɵı����¼����
		    int count = reportService.countCardInfo(startTime, endTime + " 23:59:59");
		    if(count > 20000) {
		    	message = "����PDF��ʽ����ϸ��Ϣ���������������ѳ���20000����������ѡ���С�����ڷ�Χ";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			//����pdf�ļ���
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename="+"cardInfoReport_cardInfoReportPDF.pdf");
			
			this.reportService.pdfStreamFormate(inputStream, outputStream, startTime, endTime + " 23:59:59", getCurrentOperator().getName());
			ServletActionContext.getResponse().setContentType("application/pdf");

			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ����ϸ��Ϣ����JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ����ϸ��Ϣ����IOException�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ����ϸ��Ϣ����Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * HTML��ʽ��ʱ����̬����
	 * @return
	 */
	public String cardDynamicReport() {
		try {
			admin = this.getCurrentOperator();
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
		    response.setCharacterEncoding("utf-8");
		    
		    //�������ɵı����¼����
//		    int count = reportService.countCardDynamic();
//		    if(count > 10000) {
//		    	message = "����HTML��ʽ��ʱ����̬���������������ѳ���10000����������ѡ���С�����ڷ�Χ";
//		    	return ERROR;
//		    }
		    
			JasperPrint print = this.reportService.fillReport(jasper1, getCurrentOperator().getName());
			
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
					"["+admin.getId()+"]"+admin.getUsername()+"�û�����HTML��ʽ��ʱ����̬����",
					"�������--����Ϣ����--��ʱ����̬����", "tb_CardDynamic");
	        
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ��ʱ����̬����JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ��ʱ����̬����IO�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ��ʱ����̬����Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * PDF��ʽ��ʱ����̬����
	 * @return
	 */
	public String cardDynamicReportPDF() {
		try{
			admin = this.getCurrentOperator();
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//�������ɵı����¼����
//		    int count = reportService.countCardDynamic();
//		    if(count > 20000) {
//		    	message = "����PDF��ʽ��ʱ����̬���������������ѳ���20000����������ѡ���С�����ڷ�Χ";
//		    	return ERROR;
//		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			//����pdf�ļ���
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename="+"cardInfoReport_cardDynamicReportPDF.pdf");
			
			this.reportService.pdfStreamFormate(inputStream, outputStream, getCurrentOperator().getName());
			ServletActionContext.getResponse().setContentType("application/pdf");

			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ��ʱ����̬����JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ��ʱ����̬����IOException�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ��ʱ����̬����Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * HTML��ʽ�±����ɷѼ�¼����
	 * @return
	 */
	public String carMonthBillReport() {
		try {
			admin = this.getCurrentOperator();
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8");
			
			//�������ɵı����¼����
			int count = reportService.countCarMonthBill(startTime, endTime + " 23:59:59");
			if(count > 10000) {
				message = "����HTML��ʽ�±����ɷѼ�¼���������������ѳ���10000����������ѡ���С�����ڷ�Χ";
				return ERROR;
			}
			
			JasperPrint print = this.reportService.fillReport(jasper1, startTime, endTime + " 23:59:59", getCurrentOperator().getName());
			
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
					"["+admin.getId()+"]"+admin.getUsername()+"�û��������ڴ�"+startTime+"��"+endTime+"��HTML��ʽ�±����ɷѼ�¼����",
					"�������--����Ϣ����--�±����ɷѼ�¼����", "tb_userCardBill");
			
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ�±����ɷѼ�¼����JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ�±����ɷѼ�¼����IO�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ�±����ɷѼ�¼����Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * PDF��ʽ�±����ɷѼ�¼����
	 * @return
	 */
	public String carMonthBillReportPDF() {
		try{
			admin = this.getCurrentOperator();
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//�������ɵı����¼����
		    int count = reportService.countCarMonthBill(startTime, endTime + " 23:59:59");
		    if(count > 20000) {
		    	message = "����PDF��ʽ�±����ɷѼ�¼���������������ѳ���20000����������ѡ���С�����ڷ�Χ";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			//����pdf�ļ���
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename="+"cardInfoReport_carMonthBillReportPDF.pdf");
			
			this.reportService.pdfStreamFormate(inputStream, outputStream, startTime, endTime + " 23:59:59", getCurrentOperator().getName());
			ServletActionContext.getResponse().setContentType("application/pdf");

			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ�±����ɷѼ�¼����JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ�±����ɷѼ�¼����IOException�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ�±����ɷѼ�¼����Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * HTML��ʽ�±����ɷ���ͳ�Ʊ���
	 * @return
	 */
	public String carMonthBillDayReport() {
		try {
			admin = this.getCurrentOperator();
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8");
			
			//�������ɵı����¼����
			int count = reportService.countCarMonthBillDay(startTime, endTime + " 23:59:59");
			if(count > 10000) {
				message = "����HTML��ʽ�±����ɷ���ͳ�Ʊ��������������ѳ���10000����������ѡ���С�����ڷ�Χ";
				return ERROR;
			}
			
			JasperPrint print = this.reportService.fillReport(jasper1, startTime, endTime + " 23:59:59", getCurrentOperator().getName());
			
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
					"["+admin.getId()+"]"+admin.getUsername()+"�û��������ڴ�"+startTime+"��"+endTime+"��HTML��ʽ�±����ɷ���ͳ�Ʊ���",
					"�������--����Ϣ����--�±����ɷ���ͳ�Ʊ���", "tb_userCardBill");
			
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ�±����ɷ���ͳ�Ʊ���JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ�±����ɷ���ͳ�Ʊ���IO�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ�±����ɷ���ͳ�Ʊ���Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * PDF��ʽ�±����ɷ���ͳ�Ʊ���
	 * @return
	 */
	public String carMonthBillDayReportPDF() {
		try{
			admin = this.getCurrentOperator();
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//�������ɵı����¼����
			int count = reportService.countCarMonthBillDay(startTime, endTime + " 23:59:59");
			if(count > 20000) {
				message = "����PDF��ʽ�±����ɷ���ͳ�Ʊ��������������ѳ���20000����������ѡ���С�����ڷ�Χ";
				return ERROR;
			}
			
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			//����pdf�ļ���
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename="+"cardInfoReport_carMonthBillDayReportPDF.pdf");
			
			this.reportService.pdfStreamFormate(inputStream, outputStream, startTime, endTime + " 23:59:59", getCurrentOperator().getName());
			ServletActionContext.getResponse().setContentType("application/pdf");
			
			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ�±����ɷ���ͳ�Ʊ���JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ�±����ɷ���ͳ�Ʊ���IOException�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ�±����ɷ���ͳ�Ʊ���Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * HTML��ʽ�±����ɷ�������ͳ�Ʊ���
	 * @return
	 */
	public String carMonthBillDayTypeReport() {
		try {
			admin = this.getCurrentOperator();
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8");
			
			//�������ɵı����¼����
			int count = reportService.countCarMonthBillDayType(startTime, endTime + " 23:59:59");
			if(count > 10000) {
				message = "����HTML��ʽ�±����ɷ�������ͳ�Ʊ��������������ѳ���10000����������ѡ���С�����ڷ�Χ";
				return ERROR;
			}
			
			JasperPrint print = this.reportService.fillReport(jasper1, startTime, endTime + " 23:59:59", getCurrentOperator().getName());
			
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
					"["+admin.getId()+"]"+admin.getUsername()+"�û��������ڴ�"+startTime+"��"+endTime+"��HTML��ʽ�±����ɷ�������ͳ�Ʊ���",
					"�������--����Ϣ����--�±����ɷ�������ͳ�Ʊ���", "tb_userCardBill");
			
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ�±����ɷ�������ͳ�Ʊ���JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ�±����ɷ�������ͳ�Ʊ���IO�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ�±����ɷ�������ͳ�Ʊ���Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * PDF��ʽ�±����ɷ�������ͳ�Ʊ���
	 * @return
	 */
	public String carMonthBillDayTypeReportPDF() {
		try{
			admin = this.getCurrentOperator();
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//�������ɵı����¼����
			int count = reportService.countCarMonthBillDayType(startTime, endTime + " 23:59:59");
			if(count > 20000) {
				message = "����PDF��ʽ�±����ɷ�������ͳ�Ʊ��������������ѳ���20000����������ѡ���С�����ڷ�Χ";
				return ERROR;
			}
			
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			//����pdf�ļ���
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename="+"cardInfoReport_carMonthBillDayTypeReportPDF.pdf");
			
			this.reportService.pdfStreamFormate(inputStream, outputStream, startTime, endTime + " 23:59:59", getCurrentOperator().getName());
			ServletActionContext.getResponse().setContentType("application/pdf");
			
			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ�±����ɷ�������ͳ�Ʊ���JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ�±����ɷ�������ͳ�Ʊ���IOException�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ�±����ɷ�������ͳ�Ʊ���Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * HTML��ʽ���⿨�ɷѱ���
	 * @return
	 */
	public String carMonthParkingReport(){
		try {
			admin = this.getCurrentOperator();
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
		    response.setCharacterEncoding("utf-8");
		    
		    //�������ɵı����¼����
		    int count = reportService.countCarMonthParking(startTime, endTime + " 23:59:59");
		    if(count > 10000) {
		    	message = "����HTML��ʽ���⿨�ɷѱ��������������ѳ���10000����������ѡ���С�����ڷ�Χ";
		    	return ERROR;
		    }
		    
			JasperPrint print=this.reportService.fillReport(jasper1, startTime, endTime + " 23:59:59", getCurrentOperator().getName());
			
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
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ���⿨�ɷѱ���JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ���⿨�ɷѱ���IO�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ���⿨�ɷѱ���Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * PDF��ʽ���⿨�ɷѱ���
	 * @return
	 */
	public String carMonthParkingReportPDF(){
		try{
			admin = this.getCurrentOperator();
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//�������ɵı����¼����
		    int count = reportService.countCarMonthParking(startTime, endTime + " 23:59:59");
		    if(count > 20000) {
		    	message = "����PDF��ʽ���⿨�ɷѱ��������������ѳ���20000����������ѡ���С�����ڷ�Χ";
		    	return ERROR;
		    }
		
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			//����pdf�ļ���
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename="+"cardInfoReport_carMonthParkingReportPDF.pdf");
			
			this.reportService.pdfStreamFormate(inputStream, outputStream, startTime, endTime + " 23:59:59", getCurrentOperator().getName());
			ServletActionContext.getResponse().setContentType("application/pdf");

			outputStream.flush();
			outputStream.close();
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ���⿨�ɷѱ���JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ���⿨�ɷѱ���IOException�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ���⿨�ɷѱ���Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * EXCEL��ʽ���⿨�ɷѱ���
	 * 
	 * @return
	 */
	public String carMonthParkingReportExcel() {
		try {
			admin = this.getCurrentOperator();
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext()
					.getRealPath(jasperExcel);
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8");

			// �������ɵı����¼����
			int count = reportService.countCarMonthParking(startTime, endTime + " 23:59:59");
			if (count > 20000) {
				message = "����EXCEL��ʽ���⿨�ɷѱ��������������ѳ���20000����������ѡ���С�����ڷ�Χ";
				return ERROR;
			}

			JasperPrint print = this.reportService.fillReport(jasper1,
					startTime, endTime + " 23:59:59", getCurrentOperator().getName());

			/*
			 * ����ͷ��Ϣ
			 */
			ServletActionContext.getResponse().setContentType(
					"application/vnd.ms-excel");
			String fileName = new String(
					"cardInfoReport_carMonthParkingReportExcel.xls".getBytes("GBK"),
					"ISO8859_1");
			ServletActionContext.getResponse().setHeader("Content-disposition",
					"attachment; filename=" + fileName);

			OutputStream ouputStream = ServletActionContext.getResponse()
					.getOutputStream();
			JRXlsExporter exporter = new JRXlsExporter();
			exporter.setParameter(JRExporterParameter.JASPER_PRINT, print);
			exporter.setParameter(JRExporterParameter.OUTPUT_STREAM,
					ouputStream);
			exporter.setParameter(
					JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,
					Boolean.TRUE);
			exporter.setParameter(JRXlsExporterParameter.IS_ONE_PAGE_PER_SHEET,
					Boolean.FALSE);
			exporter.setParameter(
					JRXlsExporterParameter.IS_WHITE_PAGE_BACKGROUND,
					Boolean.FALSE);
			exporter.exportReport();
			ouputStream.flush();
			ouputStream.close();

		} catch (JRException e) {
			systemLogService
					.save(new Date(), 2, admin, "Excel��ʽ���⿨�ɷѱ���JRException�쳣", e
							.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "Excel��ʽ���⿨�ɷѱ���IO�쳣", e
					.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin,
					"Excel��ʽ���⿨�ɷѱ���Runtime Exception�쳣", e.getMessage(),
					"Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	
	
	/**
	 * ����ϸ��Ϣ��ѯҳ��(��������ѯ�������ͣ�ͣ����)
	 * @return
	 */
	public String cardInfoInCarType() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		endTime=sdf.format(new Date());
		listCarType = carTypeService.getAllCarType();
		param_parkReport = sysparamconfService.queryOrSave(parkReport, "hg", parkReport_remark, "CardInfoReportAction��cardInfo()����parkReport����ʱset������get��������ʱ���쳣", admin);
		return "cardInfoInCarType";
	}
	
	
	/**
	 * HTML��ʽ����ϸ��Ϣ����(��������ѯ�������ͣ�ͣ����)
	 * @return
	 */
	public String cardInfoReportInCarType(){
		try{
			admin = adminService.get(getCurrentOperator().getId());
			
			HttpServletResponse response = ServletActionContext.getResponse();
			
			String temp = "/WEB-INF/jsp/report/cardInfoReport/"+param_parkReport.getPvalue()+"/jasper/cardInfoReportInCarType.jasper";
			String jasper1 = ServletActionContext.getServletContext().getRealPath(temp);
			//String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
		    response.setCharacterEncoding("utf-8");
		    
		    //�������ɵı����¼����
		    int count = reportService.countCardInfoInCartype(startTime, endTime + " 23:59:59", carType, parkingSpace);
		    if(count > 10000) {
		    	message = "����HTML��ʽ����ϸ��Ϣ���������������ѳ���10000����������ѡ���С�����ڷ�Χ";
		    	return ERROR;
		    }
		    String carTypeName = "";
		    if(carType!=null && !carType.equals("")){
		    	CarType type = carTypeService.getCarTypeByCarType(carType);
			    carTypeName = type.getCarTypeName();
		    }
		    
			JasperPrint print = this.reportService.fillReport(jasper1, startTime, endTime + " 23:59:59", getCurrentOperator().getName(), carType, parkingSpace, carTypeName);
			
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
	        Admin admin = this.getCurrentOperator();
			systemLogService.save(new Date(), 1, admin,
					"["+admin.getId()+"]"+admin.getUsername()+"�û��������ڴ�"+startTime+"��"+endTime+"��HTML��ʽ����ϸ��Ϣ����",
					"�������--����Ϣ����--����ϸ��Ϣ����", "tb_usercardinfo");
	        
		} catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ����ϸ��Ϣ����JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ����ϸ��Ϣ����IO�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "HTML��ʽ����ϸ��Ϣ����Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * ���ݳ��������첽��ѯ��������С����
	 * */
	public String findCarSmallType(){
		ServletResponse response = ServletActionContext.getResponse();
		List list = carSmallTypeService.findSmallTypeByCarType(carType);
		if(list==null){
			return null;
		}
		response.setContentType("text/xml;charset=gbk");
		PrintWriter pw =null;
		try {
			pw = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		try {
			pw.print("<?xml version=\"1.0\" encoding=\"gbk\"?>");
			pw.print("<CarSmallTypes>");
			for(int i=0; i<list.size(); i++){
				CarSmallType carSmallType = (CarSmallType) list.get(i);
				
				pw.print("<CarSmallType id='" + carSmallType.getCarSmallType() + "' name='" +carSmallType.getCarSmallName() + "' />");
			}
			pw.print("</CarSmallTypes>");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	public String cardInfoReportInCarTypePDF(){
		try {
			admin = adminService.get(getCurrentOperator().getId());
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasperPDF = "/WEB-INF/jsp/report/cardInfoReport/"+param_parkReport.getPvalue()+"/jasper/cardInfoReportInCarType.jasper";
			InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
			
			//�������ɵı����¼����
		    int count = reportService.countCardInfoInCartype(startTime, endTime + " 23:59:59", carType, parkingSpace);
			if(count > 20000) {
			    	message = "����PDF��ʽ����ϸ��Ϣ���������������ѳ���20000����������ѡ���С�����ڷ�Χ";
			    	return ERROR;
			    }
			 String carTypeName = "";
			    if(carType!=null && !carType.equals("")){
			    	CarType type = carTypeService.getCarTypeByCarType(carType);
				    carTypeName = type.getCarTypeName().trim();
			    }
			OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename="+"cardInfoReport_cardInfoReportInCarTypePDF.pdf");
			this.reportService.pdfStreamFormate(inputStream, outputStream, startTime, endTime + " 23:59:59", getCurrentOperator().getName(), carType, parkingSpace, carTypeName);
			ServletActionContext.getResponse().setContentType("application/pdf");

			outputStream.flush();
			outputStream.close();
			
		}  catch (JRException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ����ϸ��Ϣ����JRException�쳣", e.getMessage(), "JRException");
			e.printStackTrace();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ����ϸ��Ϣ����IOException�쳣", e.getMessage(), "IOException");
			e.printStackTrace();
		} catch (Exception e) {
			systemLogService.save(new Date(), 2, admin, "PDF��ʽ����ϸ��Ϣ����Runtime Exception�쳣", e.getMessage(), "Runtime Exception");
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
	public Sysparamconf getParam_parkReport() {
		return param_parkReport;
	}
	public void setParam_parkReport(Sysparamconf param_parkReport) {
		this.param_parkReport = param_parkReport;
	}
	public void setJasperExcel(String jasperExcel) {
		this.jasperExcel = jasperExcel;
	}
	public Integer getCarType() {
		return carType;
	}
	public void setCarType(Integer carType) {
		this.carType = carType;
	}
	public String getParkingSpace() {
		return parkingSpace;
	}
	public void setParkingSpace(String parkingSpace) {
		this.parkingSpace = parkingSpace;
	}
	public List getListCarType() {
		return listCarType;
	}
	public void setListCarType(List listCarType) {
		this.listCarType = listCarType;
	}
	
	
}
