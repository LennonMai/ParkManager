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
			<form name="tableForm" method="post" action="unitollInterface_listOwnerIncomeSum.do" onsubmit="return check();">
				<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
					<tr>
						<td style="padding-top: 5px;padding-bottom: 5px;"  width="40%" class="pn-flabel pn-flabel-h">
							�������ڷ�Χ��
						</td>
						<td style="padding-top: 5px;padding-bottom: 5px;"  width="60%" class="pn-fcontent">
						  	<input type="text" name="startTime" value="${startTime }" class="Wdate" onClick="WdatePicker()"> 
						  	- <input type="text" name="endTime" value="${endTime }" class="Wdate" onClick="WdatePicker()">
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
						<th>���к�</th>
						<th>��ʼ����ʱ��</th>
						<th>��������ʱ��</th>
						<th>�������</th>
						<th>ҵ������</th>
						<th>ҵ������</th>
						<th>ʵ�ս��</th>
						<th>�����</th>
						<th>��ͨ������</th>
						<th>��������ʱ��</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${ownerIncomeSumList}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
							<td>${item.listNo }</td>
							<td><fmt:formatDate value="${item.startTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td><fmt:formatDate value="${item.endTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td>${item.areaNo }</td>
							<td>${item.ownCode }</td>
							<td>${item.ownName }</td>
							<td>${item.income }</td>
							<td>${item.serviceFee }</td>
							<td>
								<c:if test="${item.ictype==5||item.ictype==22 }">��ֵ��</c:if>
								<c:if test="${item.ictype==6||item.ictype==23 }">���˿�</c:if>
							</td>
							<td><fmt:formatDate value="${item.genDate }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<jsp:include page="../include/pager.jsp"/>
			</form>
		</div>
	</body>
</html>