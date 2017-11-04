package com.hgsoft.action;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
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

import com.hgsoft.entity.Admin;
import com.hgsoft.entity.Sysparamconf;
import com.hgsoft.service.OtherReportService;
import com.hgsoft.service.OtherSysparamconfService;
import com.hgsoft.service.SystemLogService;

/**
 * @author caijunhua
 * @date October 26, 2010
 * @Description ������Դͨ�зѱ��������
 */

@Controller
@Scope("prototype")
public class OtherTollsReportAction extends BaseAction {
	@Resource
	private OtherReportService otherReportService;
	@Resource
	private OtherSysparamconfService otherSysparamconfService;
	@Resource
	SystemLogService systemLogService;
	private String startTime;
	private String endTime;	
	private Admin admin;
	private String jasperPDF;
	private String pLaneNo;
	private Sysparamconf setAreaNo;
	private Sysparamconf setParkNo;
	private String jasper;
	
	@SuppressWarnings("unchecked")
	private List laneList;
	@SuppressWarnings("unchecked")
	public List getLaneList() {
		return laneList;
	}
	
	public String getEndTime() {
		return endTime;
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
				
				int areaNoValue = Integer.parseInt(otherSysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
				int parkNoValue = Integer.parseInt(otherSysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
				
				InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
				
				//�������ɵı����¼����
			    int count = otherReportService.countTollsLane(startTime, endTime, areaNoValue, parkNoValue, pLaneNo);
			    if(count > 20000) {
			    	message = "����PDFͨ�зѷֳ�����ʱ�α��������������ѳ���20000����������ѡ���С�����ڷ�Χ";
			    	return ERROR;
			    }
			
				OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
				//����pdf�ļ���
				ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename="+"tollsReport_tollsLaneReportPDF.pdf");
				
				this.otherReportService.lanePdfStream(inputStream, outputStream, startTime, endTime, areaNoValue, parkNoValue, pLaneNo, getCurrentOperator().getName());
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
	
	
	//��ȡ����С������
	public void getSysparamconf() {
		//��ȡ����С������
		Sysparamconf areaNo = otherSysparamconfService.getSysparamconfByQname("AreaNo");
		Sysparamconf parkNo = otherSysparamconfService.getSysparamconfByQname("ParkNo");
		setAreaNo = new Sysparamconf();
		setParkNo = new Sysparamconf();
		if(areaNo == null) {
			setAreaNo.setPname("AreaNo");
			//�����ֵΪ3301
			setAreaNo.setPvalue("4430");
			setAreaNo.setPtype(0);
			setAreaNo.setRemark("������");
			otherSysparamconfService.save(setAreaNo);
		}
		if(parkNo == null) {
			setParkNo.setPname("ParkNo");
			//�����ֵΪ1
			setParkNo.setPvalue("101");
			setParkNo.setPtype(0);
			setParkNo.setRemark("С�����");
			otherSysparamconfService.save(setParkNo);
		}
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
			
			int areaNoValue = Integer.parseInt(otherSysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(otherSysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8");
			
			//�������ɵı����¼����
			int count = otherReportService.countTollsLane(startTime, endTime, areaNoValue, parkNoValue, pLaneNo);
			if (count > 10000) {
				message ="����HTMLͨ�зѷֳ�����ʱ�α��������������ѳ���10000����������ѡ���С�����ڷ�Χ";
				return ERROR;
			}
			JasperPrint print = this.otherReportService.laneFillReport(jasper1, startTime, endTime, areaNoValue, parkNoValue, pLaneNo, getCurrentOperator().getName());

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
	 * ת��ͨ�зѷֳ�����ʱ�α���༭ҳ��
	 * @return
	 */
	public String tollsLane(){
		laneList = otherReportService.getLaneInformationByLaneNo("laneNo");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		endTime=sdf.format(new Date());
		return "tollsLane";
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public Admin getAdmin() {
		return admin;
	}

	public void setAdmin(Admin admin) {
		this.admin = admin;
	}

	public String getJasperPDF() {
		return jasperPDF;
	}

	public void setJasperPDF(String jasperPDF) {
		this.jasperPDF = jasperPDF;
	}

	public Sysparamconf getSetAreaNo() {
		return setAreaNo;
	}

	public void setSetAreaNo(Sysparamconf setAreaNo) {
		this.setAreaNo = setAreaNo;
	}

	public Sysparamconf getSetParkNo() {
		return setParkNo;
	}

	public void setSetParkNo(Sysparamconf setParkNo) {
		this.setParkNo = setParkNo;
	}

	public String getJasper() {
		return jasper;
	}

	public void setJasper(String jasper) {
		this.jasper = jasper;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public String getPLaneNo() {
		return pLaneNo;
	}

	public void setPLaneNo(String pLaneNo) {
		this.pLaneNo = pLaneNo;
	}	
	
}
