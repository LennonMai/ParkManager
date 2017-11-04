package com.hgsoft.entity;

import java.math.BigDecimal;
import java.util.Date;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;

/**
 * TbSquadLog entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class SquadLog implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	
	// Fields 52个
	private Short areaNo;	//区域编码
	private Short parkNo;	//小区编码
	private Short gateNo;	//大门编码
	private Short laneNo;	//车道编码
	private Integer operatorNo;	//收费员工号
	private Short squadNo;	//工班号
	private Date squadDate;	//工班日期
	private Date loginTime;	//登录时间

//	private TbSquadLogId id;
	
	private String operatorName;	//收费员姓名
	private Date logOutTime;	//下班时间
	private String id;	//身份卡ID号
	private Integer idno;	//身份卡表面号
	private Short laneType;	//车道类型
	private Integer invStartId;	//发票起始编码
	private Integer invEndId;	//发票结束编码
	private Integer invPrintCnt;	//打印发票数
	private Integer iccardCnt;	//IC卡数量
	private Integer foreLoopCnt;	//前线圈计数
	private Integer backLoopCnt;	//后线圈计数
	private Integer poleDownCnt;	//栏杆降杆计数
	private Integer poleUpCnt;	//栏杆抬杆计数
	private Integer loopCancelCnt;	//取消线圈计数
	private Integer modifyCnt;	//修改次数计数
	private Integer badInVoiceCnt;	//废票记数
	private Integer whileVehCnt;	//白名单车计数
	private Integer totalVehCnt;	//总收费车计数
	private BigDecimal totalVehMoney;	//总收费车金额数
	private Integer vtmoney1;	//车型一金额
	private Integer vtmoney2;	//车型二金额
	private Integer vtmoney3;	//车型三金额
	private Integer vtmoney4;	//车型四金额
	private Integer vtmoney5;	//车型五金额
	private Integer vtmoney6;	//车型六金额
	private Integer cdmoney1;	//通行卡金额
	private Integer cdmoney2;	//储值卡金额
	private Integer cdmoney3;	//记帐卡金额
	private Integer vtcnt1;	//车型一计数
	private Integer vtcnt2;	//车型二计数
	private Integer vtcnt3;	//车型三计数
	private Integer vtcnt4;	//车型四计数
	private Integer vtcnt5;	//车型五计数
	private Integer vtcnt6;	//车型六计数
	private Integer cdcnt1;	//通行卡计数
	private Integer cdcnt2;	//储值卡计数
	private Integer cdcnt3;	//记帐卡计数
	private Short integrality;	//下班完整性标志
	private Integer backup1;	//备用一
	private Integer backup2;	//备用二
	private Integer backup3;	//备用三
	private Short listName;	//流水表文件名
	private Integer verifyCode;	//校验码
	private Date uploadTime;	//上传时间

	// Constructors

	/** default constructor */
	public SquadLog() {
	}

	/** minimal constructor */
//	public TbSquadLog(TbSquadLogId id) {
//		this.id = id;
//	}

	/** full constructor */
	public SquadLog(Short areaNo, Short parkNo, Short gateNo, Short laneNo,
			Integer operatorNo, Short squadNo, Date squadDate, Date loginTime,
			
			String operatorName, Date logOutTime,
			String id, Integer idno, Short laneType, Integer invStartId,
			Integer invEndId, Integer invPrintCnt, Integer iccardCnt,
			Integer foreLoopCnt, Integer backLoopCnt, Integer poleDownCnt,
			Integer poleUpCnt, Integer loopCancelCnt, Integer modifyCnt,
			Integer badInVoiceCnt, Integer whileVehCnt, Integer totalVehCnt,
			BigDecimal totalVehMoney, Integer vtmoney1, Integer vtmoney2,
			Integer vtmoney3, Integer vtmoney4, Integer vtmoney5,
			Integer vtmoney6, Integer cdmoney1, Integer cdmoney2,
			Integer cdmoney3, Integer vtcnt1, Integer vtcnt2, Integer vtcnt3,
			Integer vtcnt4, Integer vtcnt5, Integer vtcnt6, Integer cdcnt1,
			Integer cdcnt2, Integer cdcnt3, Short integrality, Integer backup1,
			Integer backup2, Integer backup3, Short listName,
			Integer verifyCode, Date uploadTime) {
//		this.id = id;
		this.areaNo = areaNo;
		this.parkNo = parkNo;
		this.gateNo = gateNo;
		this.laneNo = laneNo;
		this.operatorNo = operatorNo;
		this.squadNo = squadNo;
		this.squadDate = squadDate;
		this.loginTime = loginTime;
		
		this.operatorName = operatorName;
		this.logOutTime = logOutTime;
		this.id = id;
		this.idno = idno;
		this.laneType = laneType;
		this.invStartId = invStartId;
		this.invEndId = invEndId;
		this.invPrintCnt = invPrintCnt;
		this.iccardCnt = iccardCnt;
		this.foreLoopCnt = foreLoopCnt;
		this.backLoopCnt = backLoopCnt;
		this.poleDownCnt = poleDownCnt;
		this.poleUpCnt = poleUpCnt;
		this.loopCancelCnt = loopCancelCnt;
		this.modifyCnt = modifyCnt;
		this.badInVoiceCnt = badInVoiceCnt;
		this.whileVehCnt = whileVehCnt;
		this.totalVehCnt = totalVehCnt;
		this.totalVehMoney = totalVehMoney;
		this.vtmoney1 = vtmoney1;
		this.vtmoney2 = vtmoney2;
		this.vtmoney3 = vtmoney3;
		this.vtmoney4 = vtmoney4;
		this.vtmoney5 = vtmoney5;
		this.vtmoney6 = vtmoney6;
		this.cdmoney1 = cdmoney1;
		this.cdmoney2 = cdmoney2;
		this.cdmoney3 = cdmoney3;
		this.vtcnt1 = vtcnt1;
		this.vtcnt2 = vtcnt2;
		this.vtcnt3 = vtcnt3;
		this.vtcnt4 = vtcnt4;
		this.vtcnt5 = vtcnt5;
		this.vtcnt6 = vtcnt6;
		this.cdcnt1 = cdcnt1;
		this.cdcnt2 = cdcnt2;
		this.cdcnt3 = cdcnt3;
		this.integrality = integrality;
		this.backup1 = backup1;
		this.backup2 = backup2;
		this.backup3 = backup3;
		this.listName = listName;
		this.verifyCode = verifyCode;
		this.uploadTime = uploadTime;
	}

	// Property accessors
//	public TbSquadLogId getId() {
//		return this.id;
//	}
//	public void setId(TbSquadLogId id) {
//		this.id = id;
//	}

	public boolean equals(Object obj) {
		if (obj == this) {
			return true;
		}
		if (!(obj instanceof SquadLog)) {
			return false;
		}
		SquadLog squadLog = (SquadLog) obj;
		return new EqualsBuilder()
				.append(this.areaNo,squadLog.getAreaNo())
				.append(this.parkNo,squadLog.getParkNo())
				.append(this.gateNo,squadLog.getGateNo())
				.append(this.laneNo,squadLog.getLaneNo())
				.append(this.operatorNo,squadLog.getOperatorNo())
				.append(this.squadDate,squadLog.getSquadDate())
				.append(this.squadNo,squadLog.getSquadNo())
				.append(this.loginTime,squadLog.getLoginTime()).isEquals();
	}

	public int hashCode() {
		return new HashCodeBuilder().append(this.areaNo).append(this.parkNo)
				.append(this.gateNo).append(this.laneNo).append(this.laneNo)
				.append(this.squadDate).append(this.squadNo).append(this.loginTime).toHashCode();
	}
	
	/*public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof SquadLog))
			return false;
		SquadLog castOther = (SquadLog) other;

		return ((this.getAreaNo() == castOther.getAreaNo()) || (this
				.getAreaNo() != null
				&& castOther.getAreaNo() != null && this.getAreaNo().equals(
				castOther.getAreaNo())))
				&& ((this.getParkNo() == castOther.getParkNo()) || (this
						.getParkNo() != null
						&& castOther.getParkNo() != null && this.getParkNo()
						.equals(castOther.getParkNo())))
				&& ((this.getGateNo() == castOther.getGateNo()) || (this
						.getGateNo() != null
						&& castOther.getGateNo() != null && this.getGateNo()
						.equals(castOther.getGateNo())))
				&& ((this.getLaneNo() == castOther.getLaneNo()) || (this
						.getLaneNo() != null
						&& castOther.getLaneNo() != null && this.getLaneNo()
						.equals(castOther.getLaneNo())))
				&& ((this.getOperatorNo() == castOther.getOperatorNo()) || (this
						.getOperatorNo() != null
						&& castOther.getOperatorNo() != null && this
						.getOperatorNo().equals(castOther.getOperatorNo())))
				&& ((this.getSquadNo() == castOther.getSquadNo()) || (this
						.getSquadNo() != null
						&& castOther.getSquadNo() != null && this.getSquadNo()
						.equals(castOther.getSquadNo())))
				&& ((this.getSquadDate() == castOther.getSquadDate()) || (this
						.getSquadDate() != null
						&& castOther.getSquadDate() != null && this
						.getSquadDate().equals(castOther.getSquadDate())))
				&& ((this.getLoginTime() == castOther.getLoginTime()) || (this
						.getLoginTime() != null
						&& castOther.getLoginTime() != null && this
						.getLoginTime().equals(castOther.getLoginTime())));
	}

	public int hashCode() {
		int result = 17;

		result = 37 * result
				+ (getAreaNo() == null ? 0 : this.getAreaNo().hashCode());
		result = 37 * result
				+ (getParkNo() == null ? 0 : this.getParkNo().hashCode());
		result = 37 * result
				+ (getGateNo() == null ? 0 : this.getGateNo().hashCode());
		result = 37 * result
				+ (getLaneNo() == null ? 0 : this.getLaneNo().hashCode());
		result = 37
				* result
				+ (getOperatorNo() == null ? 0 : this.getOperatorNo()
						.hashCode());
		result = 37 * result
				+ (getSquadNo() == null ? 0 : this.getSquadNo().hashCode());
		result = 37 * result
				+ (getSquadDate() == null ? 0 : this.getSquadDate().hashCode());
		result = 37 * result
				+ (getLoginTime() == null ? 0 : this.getLoginTime().hashCode());
		return result;
	}*/
	
	
	public Short getAreaNo() {
		return this.areaNo;
	}
	public void setAreaNo(Short areaNo) {
		this.areaNo = areaNo;
	}

	public Short getParkNo() {
		return this.parkNo;
	}
	public void setParkNo(Short parkNo) {
		this.parkNo = parkNo;
	}

	public Short getGateNo() {
		return this.gateNo;
	}
	public void setGateNo(Short gateNo) {
		this.gateNo = gateNo;
	}

	public Short getLaneNo() {
		return this.laneNo;
	}
	public void setLaneNo(Short laneNo) {
		this.laneNo = laneNo;
	}

	public Integer getOperatorNo() {
		return this.operatorNo;
	}
	public void setOperatorNo(Integer operatorNo) {
		this.operatorNo = operatorNo;
	}

	public Short getSquadNo() {
		return this.squadNo;
	}
	public void setSquadNo(Short squadNo) {
		this.squadNo = squadNo;
	}

	public Date getSquadDate() {
		return this.squadDate;
	}
	public void setSquadDate(Date squadDate) {
		this.squadDate = squadDate;
	}

	public Date getLoginTime() {
		return this.loginTime;
	}
	public void setLoginTime(Date loginTime) {
		this.loginTime = loginTime;
	}
	
	
	public String getOperatorName() {
		return this.operatorName;
	}
	public void setOperatorName(String operatorName) {
		this.operatorName = operatorName;
	}

	public Date getLogOutTime() {
		return this.logOutTime;
	}
	public void setLogOutTime(Date logOutTime) {
		this.logOutTime = logOutTime;
	}

	public String getId() {
		return this.id;
	}
	public void setId(String id) {
		this.id = id;
	}

	public Integer getIdno() {
		return this.idno;
	}
	public void setIdno(Integer idno) {
		this.idno = idno;
	}

	public Short getLaneType() {
		return this.laneType;
	}
	public void setLaneType(Short laneType) {
		this.laneType = laneType;
	}

	public Integer getInvStartId() {
		return this.invStartId;
	}
	public void setInvStartId(Integer invStartId) {
		this.invStartId = invStartId;
	}

	public Integer getInvEndId() {
		return this.invEndId;
	}
	public void setInvEndId(Integer invEndId) {
		this.invEndId = invEndId;
	}

	public Integer getInvPrintCnt() {
		return this.invPrintCnt;
	}
	public void setInvPrintCnt(Integer invPrintCnt) {
		this.invPrintCnt = invPrintCnt;
	}

	public Integer getIccardCnt() {
		return this.iccardCnt;
	}
	public void setIccardCnt(Integer iccardCnt) {
		this.iccardCnt = iccardCnt;
	}

	public Integer getForeLoopCnt() {
		return this.foreLoopCnt;
	}
	public void setForeLoopCnt(Integer foreLoopCnt) {
		this.foreLoopCnt = foreLoopCnt;
	}

	public Integer getBackLoopCnt() {
		return this.backLoopCnt;
	}
	public void setBackLoopCnt(Integer backLoopCnt) {
		this.backLoopCnt = backLoopCnt;
	}

	public Integer getPoleDownCnt() {
		return this.poleDownCnt;
	}
	public void setPoleDownCnt(Integer poleDownCnt) {
		this.poleDownCnt = poleDownCnt;
	}

	public Integer getPoleUpCnt() {
		return this.poleUpCnt;
	}
	public void setPoleUpCnt(Integer poleUpCnt) {
		this.poleUpCnt = poleUpCnt;
	}

	public Integer getLoopCancelCnt() {
		return this.loopCancelCnt;
	}
	public void setLoopCancelCnt(Integer loopCancelCnt) {
		this.loopCancelCnt = loopCancelCnt;
	}

	public Integer getModifyCnt() {
		return this.modifyCnt;
	}
	public void setModifyCnt(Integer modifyCnt) {
		this.modifyCnt = modifyCnt;
	}

	public Integer getBadInVoiceCnt() {
		return this.badInVoiceCnt;
	}
	public void setBadInVoiceCnt(Integer badInVoiceCnt) {
		this.badInVoiceCnt = badInVoiceCnt;
	}

	public Integer getWhileVehCnt() {
		return this.whileVehCnt;
	}
	public void setWhileVehCnt(Integer whileVehCnt) {
		this.whileVehCnt = whileVehCnt;
	}

	public Integer getTotalVehCnt() {
		return this.totalVehCnt;
	}
	public void setTotalVehCnt(Integer totalVehCnt) {
		this.totalVehCnt = totalVehCnt;
	}

	public BigDecimal getTotalVehMoney() {
		return totalVehMoney;
	}
	public void setTotalVehMoney(BigDecimal totalVehMoney) {
		this.totalVehMoney = totalVehMoney;
	}
	/*public Integer getTotalVehMoney() {
		return this.totalVehMoney;
	}
	public void setTotalVehMoney(Integer totalVehMoney) {
		this.totalVehMoney = totalVehMoney;
	}*/

	public Integer getVtmoney1() {
		return this.vtmoney1;
	}
	public void setVtmoney1(Integer vtmoney1) {
		this.vtmoney1 = vtmoney1;
	}

	public Integer getVtmoney2() {
		return this.vtmoney2;
	}
	public void setVtmoney2(Integer vtmoney2) {
		this.vtmoney2 = vtmoney2;
	}

	public Integer getVtmoney3() {
		return this.vtmoney3;
	}
	public void setVtmoney3(Integer vtmoney3) {
		this.vtmoney3 = vtmoney3;
	}

	public Integer getVtmoney4() {
		return this.vtmoney4;
	}
	public void setVtmoney4(Integer vtmoney4) {
		this.vtmoney4 = vtmoney4;
	}

	public Integer getVtmoney5() {
		return this.vtmoney5;
	}
	public void setVtmoney5(Integer vtmoney5) {
		this.vtmoney5 = vtmoney5;
	}

	public Integer getVtmoney6() {
		return this.vtmoney6;
	}
	public void setVtmoney6(Integer vtmoney6) {
		this.vtmoney6 = vtmoney6;
	}

	public Integer getCdmoney1() {
		return this.cdmoney1;
	}
	public void setCdmoney1(Integer cdmoney1) {
		this.cdmoney1 = cdmoney1;
	}

	public Integer getCdmoney2() {
		return this.cdmoney2;
	}
	public void setCdmoney2(Integer cdmoney2) {
		this.cdmoney2 = cdmoney2;
	}

	public Integer getCdmoney3() {
		return this.cdmoney3;
	}
	public void setCdmoney3(Integer cdmoney3) {
		this.cdmoney3 = cdmoney3;
	}

	public Integer getVtcnt1() {
		return this.vtcnt1;
	}
	public void setVtcnt1(Integer vtcnt1) {
		this.vtcnt1 = vtcnt1;
	}

	public Integer getVtcnt2() {
		return this.vtcnt2;
	}
	public void setVtcnt2(Integer vtcnt2) {
		this.vtcnt2 = vtcnt2;
	}

	public Integer getVtcnt3() {
		return this.vtcnt3;
	}
	public void setVtcnt3(Integer vtcnt3) {
		this.vtcnt3 = vtcnt3;
	}

	public Integer getVtcnt4() {
		return this.vtcnt4;
	}
	public void setVtcnt4(Integer vtcnt4) {
		this.vtcnt4 = vtcnt4;
	}

	public Integer getVtcnt5() {
		return this.vtcnt5;
	}
	public void setVtcnt5(Integer vtcnt5) {
		this.vtcnt5 = vtcnt5;
	}

	public Integer getVtcnt6() {
		return this.vtcnt6;
	}
	public void setVtcnt6(Integer vtcnt6) {
		this.vtcnt6 = vtcnt6;
	}

	public Integer getCdcnt1() {
		return this.cdcnt1;
	}
	public void setCdcnt1(Integer cdcnt1) {
		this.cdcnt1 = cdcnt1;
	}

	public Integer getCdcnt2() {
		return this.cdcnt2;
	}
	public void setCdcnt2(Integer cdcnt2) {
		this.cdcnt2 = cdcnt2;
	}

	public Integer getCdcnt3() {
		return this.cdcnt3;
	}
	public void setCdcnt3(Integer cdcnt3) {
		this.cdcnt3 = cdcnt3;
	}

	public Short getIntegrality() {
		return this.integrality;
	}
	public void setIntegrality(Short integrality) {
		this.integrality = integrality;
	}

	public Integer getBackup1() {
		return this.backup1;
	}
	public void setBackup1(Integer backup1) {
		this.backup1 = backup1;
	}

	public Integer getBackup2() {
		return this.backup2;
	}
	public void setBackup2(Integer backup2) {
		this.backup2 = backup2;
	}

	public Integer getBackup3() {
		return this.backup3;
	}
	public void setBackup3(Integer backup3) {
		this.backup3 = backup3;
	}

	public Short getListName() {
		return this.listName;
	}
	public void setListName(Short listName) {
		this.listName = listName;
	}

	public Integer getVerifyCode() {
		return this.verifyCode;
	}
	public void setVerifyCode(Integer verifyCode) {
		this.verifyCode = verifyCode;
	}

	public Date getUploadTime() {
		return this.uploadTime;
	}
	public void setUploadTime(Date uploadTime) {
		this.uploadTime = uploadTime;
	}

}