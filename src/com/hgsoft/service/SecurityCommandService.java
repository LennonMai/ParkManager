package com.hgsoft.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hgsoft.dao.SecurityCommandDao;
import com.hgsoft.entity.SecurityCommand;
import com.hgsoft.util.Pager;

@Service
public class SecurityCommandService {

	@Resource
	private SecurityCommandDao securityCommandDao;

	/**
	 * 根据条件查询注册安全信息的用户
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List querySecurityCommand(Pager pager, String owner, String cardNo, String vehPlate, String type,
			String validType) {
		List resultList = securityCommandDao.querySecurityCommand(pager, owner, cardNo, vehPlate, type, validType);
		return resultList;
	}

	@SuppressWarnings("unchecked")
	public List queryCommand(String cardNo, String type, String validType) {
		List resultList = securityCommandDao.queryCommand(cardNo, type, validType);
		return resultList;
	}

	// 根据车牌号和卡号查询
	public boolean getCheckUserCardInfo(String cardNo, String vehPlate) {

		return securityCommandDao.getCheckUserCardInfo(cardNo, vehPlate);
	}

	// 增加安全指令
	public SecurityCommand save(SecurityCommand securityCommand) {
		return securityCommandDao.save(securityCommand);
	}

	public boolean getByVehPlateTypeValidType(String vehPlate, short type, short vt, String startTime, String endTime) {
		return securityCommandDao.getByVehPlateTypeValidType(vehPlate, type, vt, startTime, endTime);
	}

	// 检查是否为不定时
	public boolean getByCardNoTypeValidType(String cardNo, short type, short vt) {
		return securityCommandDao.getByCardNoTypeValidType(cardNo, type, vt);
	}

	// 根据commandId来获得对象
	public SecurityCommand getByCommandId(String commandId) {
		return securityCommandDao.getByCommandId(commandId);
	}

	// 保存
	public void update(SecurityCommand securityCommand) {
		securityCommandDao.update(securityCommand);
	}

	// 删除
	public void delete(SecurityCommand securityCommand) {
		securityCommandDao.delete(securityCommand);
	}

	// chenfuyuan
	public void deleteByCardNo(String cardNo) {
		securityCommandDao.deleteByCardNo(cardNo);
	}

}
