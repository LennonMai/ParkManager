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
		<script type="text/javascript" src="${basePath}/js/dtree.js"></script>
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
			<form name="tableForm" method="post" action="securityCommandBackup_show.do">
			<!-- ��ʾlist����-->
			<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th>ָ����</th>
						<th>ָ���޸ĺ�</th>
						<th>��    ��</th>
						<th>��    ʽ</th>
						<th>��    ��</th>
						<th>ָ������</th>
						<th>��Ч����</th>
						<th>���ʱ��</th>
						<th>��Чʱ��</th>
						<th>ʧЧʱ��</th>
						<th>�޸�ʱ��</th>
						<th>״    ̬</th>
						<th>����Ա����</th>
						<th>����Ա���</th>
						<th>��Ч��־</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
							<td>${item[1].commandId }</td>
							<td>${item[1].postModId }</td>
							<td>
								<c:if test="${item[1].operationType==1}">��� </c:if>
								<c:if test="${item[1].operationType==2}">�޸� </c:if>
								<c:if test="${item[1].operationType==3}">ɾ�� </c:if>
							</td>
							<td>
								<c:if test="${item[0].useType==1}">����</c:if>
								<c:if test="${item[0].useType==2}">����</c:if>
								<c:if test="${item[0].useType==3}">�˹�</c:if>
							</td>
							<td>${item[0].cardNo }</td>
							<td>
								<c:if test="${item[0].type==1}">����</c:if>
								<c:if test="${item[0].type==2}">����</c:if>
							</td>
							<td>
								<c:if test="${item[0].validType==1}">ÿ����Ч</c:if>
								<c:if test="${item[0].validType==2}">������Ч</c:if>
								<c:if test="${item[0].validType==3}">������Ч</c:if>
								<c:if test="${item[0].validType==4}">����ʱ</c:if>
							</td>
							<td><fmt:formatDate value="${item[0].opTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>							
							<td>${item[0].startTime}</td>
							<td>${item[0].endTime}</td>
							<td><fmt:formatDate value="${item[0].addTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td>
								<c:if test="${item[0].attribute==0}">����</c:if>
								<c:if test="${item[0].attribute==1}">��ɾ��</c:if>
								<c:if test="${item[0].attribute==2}">�Ѵ���</c:if>
								<c:if test="${item[0].attribute==3}">��ʱδ����</c:if>
							</td>
							<td>
								<c:if test="${item[0].operatorType==1}">�˹�</c:if>
								<c:if test="${item[0].operatorType==2}">����</c:if>
								<c:if test="${item[0].operatorType==3}">����</c:if>
								<c:if test="${item[0].operatorType==4}">���ݿ���ҵ</c:if>
							</td>
							<td>${item[0].operatorNo }</td>		
							<td>
								<c:if test="${item[0].isValid==0}">��Ч</c:if>
								<c:if test="${item[0].isValid==1}">��Ч</c:if>
							</td>
						</tr>
					</c:forEach>
					<input type="hidden" name="commandId" value="${commandId }" />
					<input type="hidden" name="modId" value="${modId }">
				</tbody>
			</table>
			<jsp:include page="../include/pager.jsp"/>
			</form>
		</div>
	</body>
</html>