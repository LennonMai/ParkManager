<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
	<head>
		<title>���⳵��������Ϣ��ѯ</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/dtree.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript" src="${basePath}/js/jquery.js"></script>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<script type="text/javascript">
		</script>
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form name="tableForm" method="post" action="specialVeh_handleMsgQuery.do">
				<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
					<tr>
						<td class="pn-flabel pn-flabel-h">�������ͣ�</td>
						<td class="pn-fcontent">
							<input type="text" name="spVehHandle.laneType" value="${spVehHandle.laneType }"/>
						</td>
						<td class="pn-flabel pn-flabel-h">������</td>
						<td class="pn-fcontent">
							<input type="text" name="spVehHandle.tableName" value="${spVehHandle.tableName }"/>
						</td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">�������ͣ�</td>
						<td class="pn-fcontent">
							<input type="text" name="spVehHandle.handleType" value="${spVehHandle.handleType }"/>
						</td>
						<td class="pn-flabel pn-flabel-h">״̬��</td>
						<td class="pn-fcontent">
							<input type="text" name="spVehHandle.status" value="${spVehHandle.status }"/>
						</td>
					</tr>
					<tr>
						<td colspan="4" class="pn-fbutton">
							<input type="submit" value=" �� ѯ " />&nbsp;
							<input type="reset" value=" �� �� "/>	
						</td>
					</tr>
				</table>
				<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
					<thead class="pn-lthead">
						<tr>
							<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��������</th>
							<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��&nbsp;&nbsp;��</th>
							<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">״&nbsp;&nbsp;̬</th>
							<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��������</th>
							<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��&nbsp;&nbsp;ʾ</th>
							<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">˵&nbsp;&nbsp;��</th>
						</tr>
					</thead>
					<tbody class="pn-ltbody">
						<c:forEach items="${spList}" var="item">
							<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
								<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.laneType }</td>
								<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.tableName }</td>
								<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.status }</td>
								<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.handleType }</td>
								<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.hint }</td>
								<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.remark }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<jsp:include page="../include/pager.jsp"/>
			</form>
		</div>
	</body>
</html>