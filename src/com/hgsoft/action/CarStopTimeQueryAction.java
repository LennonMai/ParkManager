package com.hgsoft.action;

import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.hgsoft.entity.Admin;
import com.hgsoft.service.AdminService;
import com.hgsoft.service.CarStopTimeQueryService;
import com.hgsoft.service.SystemLogService;
import com.hgsoft.util.ExcelUtil;

@Controller
@Scope("prototype")
public class CarStopTimeQueryAction extends BaseAction {
	@Resource
	private CarStopTimeQueryService carStopTimeQueryService;
	@Resource
	private AdminService adminService;
	@Resource
	private SystemLogService systemLogService;
	private Admin admin;
	private String stopTime;
	private Integer stopCount;
	private String groupByMonth;
	private String carType;
	private String filed;
	private String startTime = null;
	private String endTime = null;

	public String list() {
		if ((getStopTime() == null && getStopCount() == null
				&& getGroupByMonth() == null && getCarType() == null)
				|| ("".equals(getStopTime()) && getStopCount() == null
						&& "".equals(getGroupByMonth()) && ""
							.equals(getCarType()))) {
			list = null;
		} else {
			if (groupByMonth != null && !"".equals(groupByMonth)) {
				startTime = groupByMonth + "-01 00:00:00";
				endTime = getAddMountMonth(startTime.toString(), 1);// 开始时间加上1个月后的月份的第一天
			}
			list = carStopTimeQueryService.findByCondition(pager,
					getStopCount(), getStopTime(), startTime, endTime,
					getCarType());
		}
		return "list";
	}

	// 日期加上一个月份
	public String getAddMountMonth(String date, int amount) {
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			if (date.length() <= 10) {
				date = date + " 00:00:00";
			}
			Date dateTemp = sdf.parse(date);
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(dateTemp);
			calendar.add(Calendar.MONTH, amount);
			String nowdateTemp = sdf.format(calendar.getTime());
			return nowdateTemp;
		} catch (Exception e) {
			admin = adminService.get(getCurrentOperator().getId());
			systemLogService.save(new Date(), 2, admin,
					"CarStopTimeQueryAction中getAddMountMonth（）设置日期加一个月份时发生的异常",
					e.getMessage(), "Exception");
			e.printStackTrace();
			return null;
		}
	}

	// 导出
	@SuppressWarnings("unchecked")
	public String exportParkCard() {
		Map<String, String> mapUserCard = new HashMap<String, String>();
		Map<String, String> mapRuleType = new HashMap<String, String>();
		String[] fileds = filed.split(",");
		String[] headers = new String[fileds.length];
		StringBuffer filedStrs = new StringBuffer(0);
		StringBuffer filedStr = new StringBuffer(0);
		String filedStrings = "";
		String filedString = "";
		int count = 0;
		for (int i = 0; i < fileds.length; i++) {// 获取用户选择的字段
			String str = fileds[i].trim();
			if (str.equals("vehPlate")) {
				headers[count] = "车牌号";
				count++;
				filedStrs.append("vehPlate,");
				filedStr.append("vehPlate,");
			} else if (str.equals("stopTime")) {
				headers[count] = "停留时长超过";
				count++;
				filedStrs
						.append("datediff(mi, inoptime, optime)/60 as stopTime,");
				filedStr.append("MIN(stopTime) as stopTime,");
			} else if (str.equals("stopCount")) {
				headers[count] = "次数达到";
				count++;
				filedStrs.append("count(vehPlate) as stopCount,");
				filedStr.append("sum(stopCount) as stopCount,");
			} else if (str.equals("carType")) {
				headers[count] = "车辆类型";
				count++;
				filedStrs
						.append("CASE WHEN UserCardType in(13,14,15) THEN '校内车'  ELSE '校外车'  END as carType,");
				filedStr.append("carType,");
			} else if (str.equals("groupByMonth")) {
				headers[count] = "月份";
				count++;
				filedStrs
						.append("CONVERT(varchar(4), opTime, 120 )+'年'+substring(CONVERT(varchar(10), opTime, 120 ),6,2)+'月' as groupByMonth,");
				filedStr.append("groupByMonth,");
			}
			filedStrings = filedStrs.substring(0, filedStrs.length() - 1);
			filedString = filedStr.substring(0, filedStr.length() - 1);
		}
		if (groupByMonth != null && !"".equals(groupByMonth)) {
			startTime = groupByMonth + "-01 00:00:00";
			endTime = getAddMountMonth(startTime.toString(), 1);// 开始时间加上1个月后的月份的第一天
		}
		Map map = new HashMap();// 将查询条件放到map中，方便传参
		map.put("stopTime", getStopTime());
		map.put("stopCount", getStopCount());
		map.put("carType", getCarType());
		map.put("startTime", startTime);
		map.put("endTime", endTime);
		list = carStopTimeQueryService.exportWhite(filedString,filedStrings, map);
		try {
			HttpServletResponse response = ServletActionContext.getResponse();
			response.setContentType("octets/stream");// 简单可以设置为信息流
			SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
			String title = "TQcarInfo" + format.format(new Date()) + ".xls";
			response.addHeader("Content-Disposition", "attachment;filename="
					+ title);
			// 客户端不缓存
			response.addHeader("Pragma", "no-cache");
			response.addHeader("Cache-Control", "no-cache");
			ExcelUtil<Object[]> _excelUtil = new ExcelUtil<Object[]>();
			OutputStream out = response.getOutputStream();
			_excelUtil.expExcel("车辆停留时间查询", headers, list, out, 5000,
					mapUserCard, mapRuleType);
			systemLogService.save(new Date(), 1, this.getCurrentOperator(), "["
					+ this.getCurrentOperator().getId() + "]"
					+ this.getCurrentOperator().getUsername()
					+ "用户导出车辆停留时间查询信息文件成功", "车辆停留时间查询-导出", "车辆停留时间查询信息"
					+ format.format(new Date()) + ".xls");
			out.close();
		} catch (IOException e) {
			systemLogService.save(new Date(), 2, getCurrentOperator(), "["
					+ this.getCurrentOperator().getId() + "]"
					+ this.getCurrentOperator().getUsername()
					+ "用户将车辆停留时间查询信息导出到Excel时抛出的IO异常", "车辆停留时间查询信息查询-导出",
					"IOException");
			e.printStackTrace();
		}
		return null;
	}

	public String getStopTime() {
		return stopTime;
	}

	public void setStopTime(String stopTime) {
		this.stopTime = stopTime;
	}

	public Integer getStopCount() {
		return stopCount;
	}

	public void setStopCount(Integer stopCount) {
		this.stopCount = stopCount;
	}

	public String getGroupByMonth() {
		return groupByMonth;
	}

	public void setGroupByMonth(String groupByMonth) {
		this.groupByMonth = groupByMonth;
	}

	public String getCarType() {
		return carType;
	}

	public void setCarType(String carType) {
		this.carType = carType;
	}

	public String getFiled() {
		return filed;
	}

	public void setFiled(String filed) {
		this.filed = filed;
	}

}
