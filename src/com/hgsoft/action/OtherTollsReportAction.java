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
 * @Description 外数据源通行费报表控制器
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
	 * PDF格式通行费分车道分时段报表
	 * @return
	 */
	public String tollsLaneReportPDF() {

			try{
				admin = this.getCurrentOperator();
				//读取区域、小区参数
				getSysparamconf();
				
				int areaNoValue = Integer.parseInt(otherSysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
				int parkNoValue = Integer.parseInt(otherSysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
				
				InputStream inputStream = ServletActionContext.getServletContext().getResourceAsStream(jasperPDF);
				
				//计算生成的报表记录条数
			    int count = otherReportService.countTollsLane(startTime, endTime, areaNoValue, parkNoValue, pLaneNo);
			    if(count > 20000) {
			    	message = "生成PDF通行费分车道分时段报表数据量过大，已超过20000条，请重新选择较小的日期范围";
			    	return ERROR;
			    }
			
				OutputStream outputStream = ServletActionContext.getResponse().getOutputStream();
				//设置pdf文件名
				ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment; filename="+"tollsReport_tollsLaneReportPDF.pdf");
				
				this.otherReportService.lanePdfStream(inputStream, outputStream, startTime, endTime, areaNoValue, parkNoValue, pLaneNo, getCurrentOperator().getName());
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
	
	
	//读取区域、小区参数
	public void getSysparamconf() {
		//读取区域、小区参数
		Sysparamconf areaNo = otherSysparamconfService.getSysparamconfByQname("AreaNo");
		Sysparamconf parkNo = otherSysparamconfService.getSysparamconfByQname("ParkNo");
		setAreaNo = new Sysparamconf();
		setParkNo = new Sysparamconf();
		if(areaNo == null) {
			setAreaNo.setPname("AreaNo");
			//浙大数值为3301
			setAreaNo.setPvalue("4430");
			setAreaNo.setPtype(0);
			setAreaNo.setRemark("区域编号");
			otherSysparamconfService.save(setAreaNo);
		}
		if(parkNo == null) {
			setParkNo.setPname("ParkNo");
			//浙大数值为1
			setParkNo.setPvalue("101");
			setParkNo.setPtype(0);
			setParkNo.setRemark("小区编号");
			otherSysparamconfService.save(setParkNo);
		}
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
			
			int areaNoValue = Integer.parseInt(otherSysparamconfService.getSysparamconfByQname("AreaNo").getPvalue());
			int parkNoValue = Integer.parseInt(otherSysparamconfService.getSysparamconfByQname("ParkNo").getPvalue());
			
			HttpServletResponse response = ServletActionContext.getResponse();
			String jasper1 = ServletActionContext.getServletContext().getRealPath(jasper);
			response.setContentType("text/html");
			response.setCharacterEncoding("utf-8");
			
			//计算生成的报表记录条数
			int count = otherReportService.countTollsLane(startTime, endTime, areaNoValue, parkNoValue, pLaneNo);
			if (count > 10000) {
				message ="生成HTML通行费分车道分时段报表数据量过大，已超过10000条，请重新选择较小的日期范围";
				return ERROR;
			}
			JasperPrint print = this.otherReportService.laneFillReport(jasper1, startTime, endTime, areaNoValue, parkNoValue, pLaneNo, getCurrentOperator().getName());

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
	 * 转向通行费分车道分时段报表编辑页面
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
