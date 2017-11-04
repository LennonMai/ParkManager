package com.hgsoft.action;
import java.util.Date;
import javax.annotation.Resource;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import com.hgsoft.entity.Account;
import com.hgsoft.entity.Admin;
import com.hgsoft.entity.Car;
import com.hgsoft.entity.Sysparamconf;
import com.hgsoft.entity.UpdateAccountLog;
import com.hgsoft.entity.User;
import com.hgsoft.service.AdminService;
import com.hgsoft.service.SysparamconfService;
import com.hgsoft.service.UpdateAccountLogService;

@Controller
@Scope("prototype")
public class UpdateAccountLogAction extends BaseAction {
	private Account account;
	private User user;
	private Car car;
	private Admin admin;
	private UpdateAccountLog updateAccountLog;
	private Sysparamconf param_card_type;
	private Date startTime;
	private Date endTime;
	private String card_type = "card_type";// 卡类型，0为记账卡，1为储值卡
	private String card_type_remark = "账户类型参数（0就是充值不写卡，1就是充值写卡,如果值不是0或者1就初始化为0. 没设置其参数系统自动添加，初始化值为0)";
	@Resource
	private UpdateAccountLogService updateAccountLogService;
	@Resource
	private SysparamconfService sysparamconfService;
	@Resource
	private AdminService adminService;
	public String queryUpdateAccountLog() {
		list = updateAccountLogService.findByPager(pager);
		return "queryUpdateAccountLog";
	}

	public String query() {//根据条件查询账户更改日志
		if (null == updateAccountLog.getAccountNo() && "".equals(updateAccountLog.getCardNo()) && "".equals(updateAccountLog.getUserName()) && null == updateAccountLog.getCredentialsType() && "".equals(updateAccountLog.getCredentialsNo()) && "".equals(updateAccountLog.getVehPlate()) && null == updateAccountLog.getStatus() && startTime == null && endTime == null) {
			return queryUpdateAccountLog();
		} else {

			list = updateAccountLogService.findAllItemByHqlAndTime(pager, updateAccountLog.getAccountNo(), updateAccountLog.getCardNo(), updateAccountLog.getUserName(), updateAccountLog.getCredentialsType(), updateAccountLog.getCredentialsNo(), updateAccountLog.getVehPlate(), updateAccountLog.getStatus(), startTime, endTime);

		}
		return "queryUpdateAccountLog";
	}

	public String detail() {
		admin = adminService.get(getCurrentOperator().getId());
		// 设置账户卡类型，0为根据充值分为不写卡，1为写卡
		param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "UpdateAccountLogAction中detail()设置card_type参数时set（），get（）参数时的异常", admin);
		updateAccountLog = updateAccountLogService.getUpdateAccountLogByAccountNoAndSeqNo(updateAccountLog.getAccountNo(), updateAccountLog.getSeqNo());
		return "show";
	}

	public Account getAccount() {
		return account;
	}

	public void setAccount(Account account) {
		this.account = account;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Car getCar() {
		return car;
	}

	public void setCar(Car car) {
		this.car = car;
	}

	public UpdateAccountLog getUpdateAccountLog() {
		return updateAccountLog;
	}

	public void setUpdateAccountLog(UpdateAccountLog updateAccountLog) {
		this.updateAccountLog = updateAccountLog;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	public Sysparamconf getParam_card_type() {
		return param_card_type;
	}

	public void setParam_card_type(Sysparamconf paramCardType) {
		param_card_type = paramCardType;
	}

}
