<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
	<head>
		<title>交接班信息修改</title>
		<%@include file="../../../include/common.jsp" %>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript">
			function getLaneOperNo() { //修改获取收费员工号
				document.getElementById("laneOperatorNo").value="";
	    	   	document.getElementById("laneOperatorNo").value=document.getElementById("operatorNo").value;	
				
			}
			function back(id,count){
				window.location.href = "squadLog_list.do?pager.currentPage="+id+"&pager.pageSize="+count;
			}
		</script>

	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="squadLog_update.do?" >
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">工号：</td>
						<td width="80%" class="pn-fcontent"><input type="text"  name="squadLog.operatorNo" value="${squadLog.operatorNo}" size="40" readonly="readonly" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px" /></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">收费员：</td>
						<td width="80%" class="pn-fcontent"><input type="text"  name="squadLog.operatorName" value="${squadLog.operatorName}" size="40" readonly="readonly" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px" /></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">工班日期：</td>
						<td width="80%" class="pn-fcontent"><input type="text"  name="squadLog.squadDate" value="${squadLog.squadDate}" size="40" readonly="readonly" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px" /></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">工班：</td>
						<td width="80%" class="pn-fcontent"><input type="text"  name="squadLog.squadNo" value="${squadLog.squadNo}" size="40" readonly="readonly" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px" /></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">上班时间：</td>
						<td width="80%" class="pn-fcontent"><input type="text"  name="squadLog.loginTime" value="${squadLog.loginTime}" size="40" readonly="readonly" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px" /></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">下班时间：</td>
						<td width="80%" class="pn-fcontent"><input type="text"  name="squadLog.logOutTime" value="${squadLog.logOutTime}" size="40" readonly="readonly" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px" /></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">工班流水数：</td>
						<td width="80%" class="pn-fcontent">
							<input type="text"  name="squadLog.totalVehCnt" value="${squadLog.totalVehCnt}" class="required zeroAndInteger max2147483647" size="20" />
							<span style="color: red">&nbsp;*</span>
						</td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">工班通行费：</td>
						<td width="80%" class="pn-fcontent">
							<input type="text"  name="squadLog.totalVehMoney" value="${squadLog.totalVehMoney}" class="required isNo_NotOverDecimal" size="20" />
							<span style="color: red">&nbsp;*</span>
						</td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">流水数：</td>
						<td width="80%" class="pn-fcontent"><input type="text"  name="count" value="${count}" size="20" readonly="readonly" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px" /><font color="red">（参考值）</font></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">通行费：</td>
						<td width="80%" class="pn-fcontent"><input type="text"  name="money" value="${money}" size="20" readonly="readonly" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px" /><font color="red">（参考值）</font></td>
					</tr>
					<input type="hidden"  name="squadLog.areaNo" value="${squadLog.areaNo}" size="40"/>
					<input type="hidden"  name="squadLog.parkNo" value="${squadLog.parkNo}" size="40"/>
					<input type="hidden"  name="squadLog.gateNo" value="${squadLog.gateNo}" size="40"/>
					<input type="hidden"  name="squadLog.laneNo" value="${squadLog.laneNo}" size="40"/>
					<!-- <input type="hidden"  name="squadLog.operatorNo" value="${squadLog.operatorNo}" size="40"/>
					<input type="hidden"  name="squadLog.squadNo" value="${squadLog.squadNo}" size="40"/>
					<input type="hidden"  name="squadLog.squadDate" value="${squadLog.squadDate}" size="40"/>
					<input type="hidden"  name="squadLog.loginTime" value="${squadLog.loginTime}" size="40"/> -->
					
					<!-- <input type="hidden"  name="squadLog.operatorName" value="${squadLog.operatorName}" size="40"/>
					<input type="hidden"  name="squadLog.logOutTime" value="${squadLog.logOutTime}" size="40"/> -->
					<%--<input type="hidden"  name="squadLog.id" value="${squadLog.id}" size="40"/>
					<input type="hidden"  name="squadLog.idno" value="${squadLog.idno}" size="40"/>
					<input type="hidden"  name="squadLog.laneType" value="${squadLog.laneType}" size="40"/>
					<input type="hidden"  name="squadLog.invStartId" value="${squadLog.invStartId}" size="40"/>
					<input type="hidden"  name="squadLog.invEndId" value="${squadLog.invEndId}" size="40"/>
					<input type="hidden"  name="squadLog.invPrintCnt" value="${squadLog.invPrintCnt}" size="40"/>
					<input type="hidden"  name="squadLog.iccardCnt" value="${squadLog.iccardCnt}" size="40"/>
					<input type="hidden"  name="squadLog.foreLoopCnt" value="${squadLog.foreLoopCnt}" size="40"/>
					<input type="hidden"  name="squadLog.backLoopCnt" value="${squadLog.backLoopCnt}" size="40"/>
					<input type="hidden"  name="squadLog.poleDownCnt" value="${squadLog.poleDownCnt}" size="40"/>
					<input type="hidden"  name="squadLog.poleUpCnt" value="${squadLog.poleUpCnt}" size="40"/>
					<input type="hidden"  name="squadLog.loopCancelCnt" value="${squadLog.loopCancelCnt}" size="40"/>
					<input type="hidden"  name="squadLog.modifyCnt" value="${squadLog.modifyCnt}" size="40"/>
					<input type="hidden"  name="squadLog.badInVoiceCnt" value="${squadLog.badInVoiceCnt}" size="40"/>
					<input type="hidden"  name="squadLog.whileVehCnt" value="${squadLog.whileVehCnt}" size="40"/>
					<!-- <input type="hidden"  name="squadLog.totalVehCnt" value="${squadLog.totalVehCnt}" size="40"/>
					<input type="hidden"  name="squadLog.totalVehMoney" value="${squadLog.totalVehMoney}" size="40"/> -->
					<input type="hidden"  name="squadLog.vtmoney1" value="${squadLog.vtmoney1}" size="40"/>
					<input type="hidden"  name="squadLog.vtmoney2" value="${squadLog.vtmoney2}" size="40"/>
					<input type="hidden"  name="squadLog.vtmoney3" value="${squadLog.vtmoney3}" size="40"/>
					<input type="hidden"  name="squadLog.vtmoney4" value="${squadLog.vtmoney4}" size="40"/>
					<input type="hidden"  name="squadLog.vtmoney5" value="${squadLog.vtmoney5}" size="40"/>
					<input type="hidden"  name="squadLog.vtmoney6" value="${squadLog.vtmoney6}" size="40"/>
					<input type="hidden"  name="squadLog.cdmoney1" value="${squadLog.cdmoney1}" size="40"/>
					<input type="hidden"  name="squadLog.cdmoney2" value="${squadLog.cdmoney2}" size="40"/>
					<input type="hidden"  name="squadLog.cdmoney3" value="${squadLog.cdmoney3}" size="40"/>
					<input type="hidden"  name="squadLog.vtcnt1" value="${squadLog.vtcnt1}" size="40"/>
					<input type="hidden"  name="squadLog.vtcnt2" value="${squadLog.vtcnt2}" size="40"/>
					<input type="hidden"  name="squadLog.vtcnt3" value="${squadLog.vtcnt3}" size="40"/>
					<input type="hidden"  name="squadLog.vtcnt4" value="${squadLog.vtcnt4}" size="40"/>
					<input type="hidden"  name="squadLog.vtcnt5" value="${squadLog.vtcnt5}" size="40"/>
					<input type="hidden"  name="squadLog.vtcnt6" value="${squadLog.vtcnt6}" size="40"/>
					<input type="hidden"  name="squadLog.cdcnt1" value="${squadLog.cdcnt1}" size="40"/>
					<input type="hidden"  name="squadLog.cdcnt2" value="${squadLog.cdcnt2}" size="40"/>
					<input type="hidden"  name="squadLog.cdcnt3" value="${squadLog.cdcnt3}" size="40"/>
					<input type="hidden"  name="squadLog.integrality" value="${squadLog.integrality}" size="40"/>
					<input type="hidden"  name="squadLog.backup1" value="${squadLog.backup1}" size="40"/>
					<input type="hidden"  name="squadLog.backup2" value="${squadLog.backup2}" size="40"/>
					<input type="hidden"  name="squadLog.backup3" value="${squadLog.backup3}" size="40"/>
					<input type="hidden"  name="squadLog.listName" value="${squadLog.listName}" size="40"/>
					<input type="hidden"  name="squadLog.verifyCode" value="${squadLog.verifyCode}" size="40"/>
					<input type="hidden"  name="squadLog.uploadTime" value="${squadLog.uploadTime}" size="40"/>
					--%><tr>
						<td colspan="2" class="pn-fbutton">
							<input type="submit" value=" 修 改 "/> &nbsp;
						    <input type="reset"" value=" 重 置 " /> &nbsp;
						     <input type="button" value=" 返 回 " onclick="return back(${pager.currentPage },${pager.pageSize })"/></td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>