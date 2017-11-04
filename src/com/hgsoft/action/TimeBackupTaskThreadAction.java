package com.hgsoft.action;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletContext;
import org.springframework.orm.hibernate3.HibernateTemplate;
import com.hgsoft.entity.Sysparamconf;
import com.hgsoft.entity.SystemLog;
import com.hgsoft.util.ExcelUtil;
import com.hgsoft.util.JdbcUtil;



/**
 * 定时任务线程类
 */
public class TimeBackupTaskThreadAction extends Thread {

	@SuppressWarnings("unused")
	private ServletContext context = null;
	private HibernateTemplate hibernateTemplate;
	private JdbcUtil jdbc;
	
	@SuppressWarnings("unused")
	private	int date,month,hour,minute,second,months;
	private String time,year;
	private File file;
	private String filePath="filePath_sysLogBackupTask",path;
	/**
	 * 构造函数
	 * @param context
	 */
	public TimeBackupTaskThreadAction(){};
	public TimeBackupTaskThreadAction(ServletContext context) {
		this.context = context;
	}


	@SuppressWarnings("deprecation")
	public void run() {
		while (true) {
				
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd_HH-mm-ss");
				
				month=dateFormat.getCalendar().getTime().getMonth()+1;
				date=dateFormat.getCalendar().getTime().getDate();
				hour=dateFormat.getCalendar().getTime().getHours();
				minute=dateFormat.getCalendar().getTime().getMinutes();
				second=dateFormat.getCalendar().getTime().getSeconds();
				
				
				//System.out.println(dateFormat.getCalendar().getTime().toLocaleString()+"本地系统时间："+month+"-"+date+"-"+hour+"-"+minute+"-"+second);
				String[] startAllDate,startDate,startTime;
				//chenfuyuan
				List<Sysparamconf> paramList_TIME_updateUserCarInfoStatusTask=this.queryAndSaveTIME_updateUserCarInfoStatusTask();
				try {
					if (!paramList_TIME_updateUserCarInfoStatusTask.isEmpty()) {
						time = paramList_TIME_updateUserCarInfoStatusTask.get(0).getPvalue();
						startAllDate = time.split("_");
						String dateString = startAllDate[0].toString();
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
						Date dateTemp = new Date();
						Date date1 = sdf.parse(sdf.format(dateTemp));
						Date date2 = sdf.parse(dateString);
						if (date1.getTime() >= date2.getTime()) {
							startTime = startAllDate[1].split(":");
							if (Integer.valueOf(startTime[0].trim()) == hour ){//&& Integer.valueOf(startTime[1].trim()) == minute) {
								//if (Integer.valueOf(startTime[2].trim()) == second || Integer.valueOf(startTime[2].trim()) == second - 1) {
								if(isRightMinuteSecond(minute,Integer.valueOf(startTime[1].trim()),second,Integer.valueOf(startTime[2].trim()))){
									String sql = "UPDATE TB_USERCARDINFO SET STATUS=9 WHERE STATUS=0 AND USERCARDTYPE=14 AND RECNO NOT IN (SELECT USERRECNO FROM TB_USERCARDBILL GROUP BY USERRECNO HAVING MAX(ENDTIME)>=CONVERT(CHAR(10), GETDATE(), 120))";// 更新过期账户的状态为“未缴费”
									// String sql1 =
									// "update tb_UserCardInfo set payEndTime = (select b.maxTime from (select * from (select userrecno,MAX(endtime)as maxTime from tb_UserCardBill where userrecno=RecNO group by userrecno)as a where a.maxTime< GETDATE())as b where userrecno=RecNO) where USERTYPE=14";
									//String sql1 = "update tb_UserCardInfo set payEndTime = (select a.maxTime from (select userrecno,MAX(endtime)as maxTime from tb_UserCardBill where userrecno=RecNO group by userrecno)as a) where USERTYPE=14 and RecNO in (select distinct(userrecno) from  tb_UserCardBill)";// 更新账户的缴费期限，没有缴费记录是为空。
									getJdbc().update(sql);
									//timeBackupTaskThread.getJdbc().update(sql1);
								}
							}
						}

					}
				} catch (Exception e) {
					break;
				}
				
				//System.out.println("时间检测： " + System.currentTimeMillis());
				@SuppressWarnings("unchecked")
				List<Sysparamconf> Sysparamconf=(List<Sysparamconf>) this.getHibernateTemplate().find("from Sysparamconf spc where spc.pname='TIME_sysLogBackupTask'");
				try {if(!Sysparamconf.isEmpty()){
					time=Sysparamconf.get(0).getPvalue();
					startAllDate=time.split("_");
					months=Integer.valueOf(startAllDate[0].trim());
					startDate=startAllDate[1].split("-");
					startTime=startAllDate[2].split(":");
					
					//测试
					//System.out.println("是否是对的月："+isRightMonth(Integer.valueOf(startDate[0].trim()),Integer.valueOf(startDate[1].trim()),months));
					//System.out.println("日、时、分、秒："+Integer.valueOf(startDate[2].trim())+"<-->"+date+"  "
					//		+Integer.valueOf(startTime[0].trim())+"<-->"+hour+"  "+Integer.valueOf(startTime[1].trim())+"<-->"+minute
					//		+"  "+Integer.valueOf(startTime[2].trim())+"<-->"+second);

					if(isRightMonth(Integer.valueOf(startDate[0].trim()),Integer.valueOf(startDate[1].trim()),months)&&date==Integer.valueOf(startDate[2].trim())
							&&Integer.valueOf(startTime[0].trim())==hour){
						
						//判断是否是匹配的分秒
						if(isRightMinuteSecond(minute,Integer.valueOf(startTime[1].trim()),second,Integer.valueOf(startTime[2].trim()))){	
							//System.out.println("---- 秒、分符合 ---- ");
							this.systemLogBackupTask();
							//System.out.println("本地系统时间："+month+"-"+date+"-"+hour+"-"+minute+"-"+second);
							//System.out.println("定制任务时间："+time);
						}
						
					}
				}												
				// 休眠2秒
				Thread.sleep(2 * 1000);
			} catch (InterruptedException e) {
				break;
			}
			

		}
	}
	//检查是否是需要备份的月
	@SuppressWarnings({ "deprecation" })
	public boolean isRightMonth(int startYear,int startMonth,int months){
		Date nowDate=new Date();
		int rightMonth=startMonth+months;
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd_HH-mm-ss");

		int nowMonth=dateFormat.getCalendar().getTime().getMonth()+1;
		year=nowDate.toLocaleString().toString().trim().split(" ")[0].split("-")[0].trim();
		int nowYear=Integer.valueOf(year);		
		
		//System.out.println("now year:"+nowYear+"  "+"startYear:"+startYear+"  "+"startMonth:"+startMonth+"  "+"months:"+months+"  "+"now month:"+month);
	    
		for(int i=1;i<=22;i++){
			
			if(nowYear==startYear){
				if(nowMonth==rightMonth){
					return true;
				}
				rightMonth=rightMonth+months;
			}
			if(nowYear>startYear){
				if(nowMonth==rightMonth-12){
					return true;
				}
				rightMonth=rightMonth+months;
			}
		}
		return false;	
	}

	// 检查是否是需要备份的分、秒
	public boolean isRightMinuteSecond(int currentMinute, int taskMinute,
			int currentSecond, int taskSecond) {
		if (taskSecond == 0) {
			if (currentSecond == 59) {
				if ((currentMinute + 1) == taskMinute) {
					if (taskSecond == currentSecond
							|| 60 == (currentSecond + 1)) {

						return true;
					}
				}

			} else {
				if (currentMinute == taskMinute) {
					if (taskSecond == currentSecond
							|| 60 == (currentSecond + 1)) {

						return true;
					}
				}
			}
		} else {
			if (currentMinute == taskMinute) {
				if (taskSecond == currentSecond
						|| taskSecond == (currentSecond + 1)) {

					return true;
				}
			}

		}
		return false;
	}

	// 创建目录
	private void mdir() {
		@SuppressWarnings("unchecked")
		List<Sysparamconf> Sysparamconf=(List<Sysparamconf>) this.getHibernateTemplate().find("from Sysparamconf spc where spc.pname='"+filePath+"'");
		path = Sysparamconf.get(0).getPvalue();;
		//System.out.println("path:"+path);
		file = new File(path);
		file.mkdir();
		//System.out.println("file.mkdir():"+file.mkdir());
		//if(file.getParentFile().exists()){ System.out.println("目录已经存在");}	
	}

	public void systemLogBackupTask() {
		this.mdir();
		Date date = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd_HH-mm-ss");
		String _date = dateFormat.format(date);
		String _filename = "systemLog" + "[" + _date + "]";
		try {

			ExcelUtil<SystemLog> ex = new ExcelUtil<SystemLog>();
			String[] headers = { "日志ID", "时间", "日志类型", "用户ID", "日志内容","影响范围", "备注" };
			
			//允许存放在一个Excel文件的最大数目
			int maxListNo=60000;
			List<SystemLog> systemlogsubList=new ArrayList<SystemLog>() ;
			
			@SuppressWarnings("unchecked")
			List<SystemLog> systemlogList=(List<SystemLog>) this.getHibernateTemplate().find("from SystemLog");
			
			//System.out.println(systemlogList.size()+" -- size:"+systemlogList.size()/maxListNo);
			
			//当超过maxListNo时以多个excel文件输出
			if(systemlogList.size()>maxListNo){
				int n=systemlogList.size()/maxListNo;
				int startIndex,endIndex;
				for(int i=1;i<=n+1;i++){
					
					if(i!=n+1){
						startIndex=i*maxListNo-maxListNo;
						endIndex=i*maxListNo;
						systemlogsubList=systemlogList.subList(startIndex, endIndex);
						
						//System.out.println("i*maxListNo-maxListNo, i*maxListNo："+(i*maxListNo-maxListNo)+"  "+i*maxListNo);
					}
					else {
						startIndex=i*maxListNo-maxListNo;
						endIndex=systemlogList.size();
						systemlogsubList=systemlogList.subList(startIndex, endIndex);
						//System.out.println("i*maxListNo-maxListNo, systemlogList.size()："+(i*maxListNo-maxListNo)+"  "+systemlogList.size());
					}
					
					//System.out.println("systemlogsubList:"+systemlogsubList.size());
					
					try {
						
						OutputStream out = new FileOutputStream(path+ "/"+ _filename+"_["+startIndex+"~"+endIndex+"].xls");
						
						try {
							ex.exportExcel(headers, systemlogsubList, out);
							out.close();
						} catch (IOException e) {
							e.printStackTrace();
						}

					} catch (FileNotFoundException e) {
						e.printStackTrace();
					}
				}
			}
			//当日志记录数不超过maxListNo时以一个excel文件输出
			else {
				try {
					OutputStream out = new FileOutputStream(path+ "/"+ _filename+ ".xls");
					try {
						ex.exportExcel(headers, systemlogList, out);
						out.close();
					} catch (IOException e) {
						e.printStackTrace();
					}

				} catch (FileNotFoundException e) {
					e.printStackTrace();
				}
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	@SuppressWarnings("unchecked")
	public List<Sysparamconf> queryAndSaveTIME_updateUserCarInfoStatusTask(){

		List<Sysparamconf> paramList_TIME_updateUserCarInfoStatusTask=(List<Sysparamconf>) this.getHibernateTemplate().find("from Sysparamconf spc where spc.pname='TIME_updateUserCarInfoStatusTask'");
		if(paramList_TIME_updateUserCarInfoStatusTask.isEmpty()){
			Sysparamconf param = new Sysparamconf();
			param.setPname("TIME_updateUserCarInfoStatusTask");
			param.setPtype(0);
			param.setPvalue("2011-04-13_00:00:00");
			param.setRemark("每天定时更改过期校园卡账户状态和缴费期限。（2011-04-13_00:00:00,表示当前时间大于或者等于2011年4月13号时，00：00：00执行）。");
			this.getHibernateTemplate().save(param);
			paramList_TIME_updateUserCarInfoStatusTask=(List<Sysparamconf>) this.getHibernateTemplate().find("from Sysparamconf spc where spc.pname='TIME_updateUserCarInfoStatusTask'");
			return paramList_TIME_updateUserCarInfoStatusTask;
		} else {
			return paramList_TIME_updateUserCarInfoStatusTask;
		}
	}
	
	/**
	 * Getter/Setter方法注入HibernateTemplate
	 */
	public HibernateTemplate getHibernateTemplate() {
		return hibernateTemplate;
	}

	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}
	public JdbcUtil getJdbc() {
		return jdbc;
	}
	public void setJdbc(JdbcUtil jdbc) {
		this.jdbc = jdbc;
	}
}
