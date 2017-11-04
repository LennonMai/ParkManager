<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
	<head>
		<title></title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/dtree.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript" src="${basePath}/js/jquery.js"></script>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<script type="text/javascript">
			function check() {
				if(get("startTime").value > get("endTime").value) {
					alert("��ʼʱ��������ڻ���ڽ���ʱ��");
					return false;
				}
			}
		</script>
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form name="tableForm" method="post" action="unitollInterface_listAccountAgentImportLog.do" onsubmit="return check();">
				<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
					<tr>
						<td style="padding-top: 5px;padding-bottom: 5px;" width="40%" class="pn-flabel pn-flabel-h">
							����ʱ�䷶Χ��
						</td>
						<td style="padding-top: 5px;padding-bottom: 5px;" width="60%" class="pn-fcontent">
						  	<input type="text" name="startTime" value="${startTime }" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
					    	- <input type="text" name="endTime" value="${endTime }" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
						  	&nbsp;<font style="color:red">*</font>
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
						<th>���ݰ����</th>
						<th>����ʱ��</th>
						<th>�ļ���</th>
						<th>���ݼ�¼��</th>
						<th>��ע</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${accountAgentImportLogList}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
							<td>${item.packNo }</td>
							<td><fmt:formatDate value="${item.opTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td>${item.fileName }</td>
							<td>${item.recCount }</td>
							<td>${item.reserved }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<jsp:include page="../include/pager.jsp"/>
			</form>
		</div>
	</body>
</html>