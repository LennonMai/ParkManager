<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
	<head>
		<title></title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<form class="ropt" method="post">
					<input type="button" value=" �� �� " onclick="history.back();"/>
				</form>
				<div class="clear"></div>
			</div>
			<form name="tableForm" method="post" action="securityVehPass_queryVehPass.do?vehPassId=${vehPassId }">
			<!-- ��ʾlist����-->
			<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th>�������</th>
						<th>�����Ƿ���Ч</th>
						<th>ָ����</th>
						<th>ָ���޸ı��</th>
						<th>�������</th>
						<th>��    ��</th>					
						<th>��Ч����</th>
						<th>��    ʽ</th>
						<th>����ʱ��</th>
						<th>��Чʱ��</th>
						<th>ʧЧʱ��</th>
						<th>״    ̬</th>
						<th>����Ա����</th>
						<th>����Ա��</th>
						<th>ָ���Ƿ���Ч</th>
						<th>�鿴ָ����ʷ</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
							<td>${item[0].vehPassId }</td>
							<td>
								<c:if test="${item[0].isValid==0}">������</c:if>
								<c:if test="${item[0].isValid==1}">��Ч</c:if>
							</td>
							<td>${item[0].commandId }</td>
							<td>${item[0].commandModId }</td>
							<td>${item[1].cardNo }</td>
							<td>
								<c:if test="${item[1].type==1}">����</c:if>
								<c:if test="${item[1].type==2}">����</c:if>
							</td>
							<td>
								<c:if test="${item[1].validType==1}">ÿ����Ч</c:if>
								<c:if test="${item[1].validType==2}">������Ч</c:if>
								<c:if test="${item[1].validType==3}">������Ч</c:if>
								<c:if test="${item[1].validType==4}">����ʱ</c:if>
							</td>
							<td>
								<c:if test="${item[1].useType==1}">����</c:if>
								<c:if test="${item[1].useType==2}">����</c:if>
								<c:if test="${item[1].useType==3}">�˹�</c:if>
							</td>
							<td><fmt:formatDate value="${item[1].opTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td>${item[1].startTime}</td>
							<td>${item[1].endTime}</td>
							<td>
								<c:if test="${item[1].status==0}">δ����</c:if>
								<c:if test="${item[1].status==1}">�ѷ���</c:if>
								<c:if test="${item[1].status==2}">�Ѵ�</c:if>
							</td>
							<td>
								<c:if test="${item[1].operatorType==1}">�˹�</c:if>
								<c:if test="${item[1].operatorType==2}">����</c:if>
								<c:if test="${item[1].operatorType==3}">����</c:if>
								<c:if test="${item[1].operatorType==4}">���ݿ���ҵ</c:if>
							</td>
							<td>${item[1].operatorNo }</td>
							<td>
								<c:if test="${item[1].isValid==0}">��Ч</c:if>
								<c:if test="${item[1].isValid==1}">��Ч</c:if>
							</td>		
							<td>
								<a href="securityCommandBackup_show.do?commandId=${item[1].commandId }&modId=${item[1].modId }" class="pn-loperator">��  ��</a>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<jsp:include page="../include/pager.jsp"/>
			</form>
		</div>
	</body>
</html>