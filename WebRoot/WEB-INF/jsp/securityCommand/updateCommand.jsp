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
            //�����ύǰ���м��
			function check(){	
				if("${securityCommand.validType}"==1){
					if(document.getElementById('dayStartTime').value == ""){
						$("#tishiTime").empty();
						$("#tishiTime").append("ÿ����Ч��ʼʱ�䲻��Ϊ��");
						return false;
					}else{
						$("#tishiTime").empty();
					}
					if(document.getElementById('dayEndTime').value == ""){
						document.getElementById('tishiTime').innerText="ÿ����Ч����ʱ�䲻��Ϊ��";
						$("#tishiTime").empty();
						$("#tishiTime").append("ÿ����Ч����ʱ�䲻��Ϊ��");
						return false;
					}else{
						$("#tishiTime").empty();
					}
					if(document.getElementById('dayStartTime').value>document.getElementById('dayEndTime').value){
						$("#tishiTime").empty();
						$("#tishiTime").append("��ʼʱ�䲻�ܴ��ڽ���ʱ��");
						return false;
					}else{
						$("#tishiTime").empty();
					}
				}
				if("${securityCommand.validType}"==2){
					if(document.getElementById('startTime1').value == ""){
						$("#tishiTime").empty();
						$("#tishiTime").append("������Ч��ʼʱ�䲻��Ϊ��");
						return false;
					}else{
						$("#tishiTime").empty();
					}
					if(document.getElementById('endTime1').value == ""){
						$("#tishiTime").empty();
						$("#tishiTime").append("������Ч����ʱ�䲻��Ϊ��");
						return false;
					}else{
						$("#tishiTime").empty();
					}
					if(document.getElementById('startTime1').value>document.getElementById('endTime1').value){
						$("#tishiTime").empty();
						$("#tishiTime").append("��ʼʱ�䲻�ܴ��ڽ���ʱ��");
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
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<form class="ropt" method="post">
					
				</form>
				<div class="clear"></div>
			</div>
			<form method="post" action="securityCommand_updateCommand.do" onsubmit="return check();">
				<table width="800" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">ָ�����ͣ�</td>
						<td width="80%" class="pn-fcontent">
							<c:if test="${securityCommand.type==1}">����</c:if>
							<c:if test="${securityCommand.type==2}">����</c:if>
						</td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">��    �ţ�</td>
						<td width="80%" class="pn-fcontent">
							${securityCommand.cardNo }
						</td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">��Ч���ͣ�</td>
						<td width="80%" class="pn-fcontent">
							<c:if test="${securityCommand.validType==1}">ÿ����Ч</c:if>
							<c:if test="${securityCommand.validType==2}">������Ч</c:if>
						</td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">ʱ �� �Σ�</td>
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
						<input type="submit" value=" �� �� "/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="button" value=" �� �� " onclick="back(${pager.currentPage },${pager.pageSize });"/>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>