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
	private String card_type = "card_type";// �����ͣ�0Ϊ���˿���1Ϊ��ֵ��
	private String card_type_remark = "�˻����Ͳ�����0���ǳ�ֵ��д����1���ǳ�ֵд��,���ֵ����0����1�ͳ�ʼ��Ϊ0. û���������ϵͳ�Զ���ӣ���ʼ��ֵΪ0)";
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

	public String query() {//����������ѯ�˻�������־
		if (null == updateAccountLog.getAccountNo() && "".equals(updateAccountLog.getCardNo()) && "".equals(updateAccountLog.getUserName()) && null == updateAccountLog.getCredentialsType() && "".equals(updateAccountLog.getCredentialsNo()) && "".equals(updateAccountLog.getVehPlate()) && null == updateAccountLog.getStatus() && startTime == null && endTime == null) {
			return queryUpdateAccountLog();
		} else {

			list = updateAccountLogService.findAllItemByHqlAndTime(pager, updateAccountLog.getAccountNo(), updateAccountLog.getCardNo(), updateAccountLog.getUserName(), updateAccountLog.getCredentialsType(), updateAccountLog.getCredentialsNo(), updateAccountLog.getVehPlate(), updateAccountLog.getStatus(), startTime, endTime);

		}
		return "queryUpdateAccountLog";
	}

	public String detail() {
		admin = adminService.get(getCurrentOperator().getId());
		// �����˻������ͣ�0Ϊ���ݳ�ֵ��Ϊ��д����1Ϊд��
		param_card_type = sysparamconfService.queryOrSave(card_type, "0", card_type_remark, "UpdateAccountLogAction��detail()����card_type����ʱset������get��������ʱ���쳣", admin);
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
