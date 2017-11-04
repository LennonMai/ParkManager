<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<title></title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/jquery.js"></script>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<script type="text/javascript">
            //数据提交前进行检测
			function check(){	
				if("${securityCommand.validType}"==1){
					if(document.getElementById('dayStartTime').value == ""){
						$("#tishiTime").empty();
						$("#tishiTime").append("每日有效开始时间不能为空");
						return false;
					}else{
						$("#tishiTime").empty();
					}
					if(document.getElementById('dayEndTime').value == ""){
						document.getElementById('tishiTime').innerText="每日有效结束时间不能为空";
						$("#tishiTime").empty();
						$("#tishiTime").append("每日有效结束时间不能为空");
						return false;
					}else{
						$("#tishiTime").empty();
					}
					if(document.getElementById('dayStartTime').value>document.getElementById('dayEndTime').value){
						$("#tishiTime").empty();
						$("#tishiTime").append("开始时间不能大于结束时间");
						return false;
					}else{
						$("#tishiTime").empty();
					}
				}
				if("${securityCommand.validType}"==2){
					if(document.getElementById('startTime1').value == ""){
						$("#tishiTime").empty();
						$("#tishiTime").append("当次有效开始时间不能为空");
						return false;
					}else{
						$("#tishiTime").empty();
					}
					if(document.getElementById('endTime1').value == ""){
						$("#tishiTime").empty();
						$("#tishiTime").append("当次有效结束时间不能为空");
						return false;
					}else{
						$("#tishiTime").empty();
					}
					if(document.getElementById('startTime1').value>document.getElementById('endTime1').value){
						$("#tishiTime").empty();
						$("#tishiTime").append("开始时间不能大于结束时间");
						return false;
					}else{
						$("#tishiTime").empty();
					}
				}
				return true;
			}
			function back(id,count){
				window.location.href = "securityCommand_query.do?pager.currentPage="+id+"&pager.pageSize="+count;
			}		
		</script>
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<form class="ropt" method="post">
					
				</form>
				<div class="clear"></div>
			</div>
			<form method="post" action="securityCommand_updateCommand.do" onsubmit="return check();">
				<table width="800" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">指令类型：</td>
						<td width="80%" class="pn-fcontent">
							<c:if test="${securityCommand.type==1}">锁定</c:if>
							<c:if test="${securityCommand.type==2}">解锁</c:if>
						</td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">卡    号：</td>
						<td width="80%" class="pn-fcontent">
							${securityCommand.cardNo }
						</td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">有效类型：</td>
						<td width="80%" class="pn-fcontent">
							<c:if test="${securityCommand.validType==1}">每日有效</c:if>
							<c:if test="${securityCommand.validType==2}">当次有效</c:if>
						</td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">时 间 段：</td>
						<td width="80%" class="pn-fcontent">
								<c:if test="${securityCommand.validType==1}">
									<input name="dayStartTime" id="dayStartTime" type="text" value="${securityCommand.startTime }:00" class="Wdate" onclick="WdatePicker({dateFmt:'HH:mm:ss'})" readonly="readonly"/>
									<input name="dayEndTime" id="dayEndTime" type="text" value="${securityCommand.endTime }:00" class="Wdate" onclick="WdatePicker({dateFmt:'HH:mm:ss'})" readonly="readonly"/>
								</c:if>
								<c:if test="${securityCommand.validType==2}">
									<input type="text" name="startTime1" id ="startTime1" class="Wdate" value="${securityCommand.startTime }:00" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly"/>
									<input type="text" name="endTime1" id="endTime1" class="Wdate" value="${securityCommand.endTime }:00" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly"/>
								</c:if>&nbsp;<font style="color:red">*<label id="tishiTime"></label></font>
						</td>
					</tr>
					<tr>
						<td colspan="2" class="pn-fbutton">
						<input type="hidden" name="commandId" value="${securityCommand.commandId }" />
						<input type="hidden" name="pager.pageSize" value="${pager.pageSize}" />
						<input type="hidden" name="pager.currentPage" value="${pager.currentPage }" />
						<input type="submit" value=" 修 改 "/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="button" value=" 返 回 " onclick="back(${pager.currentPage },${pager.pageSize });"/>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>