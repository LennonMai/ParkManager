<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<title></title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
	</head>

	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<br/>
			<br/>
			&nbsp;&nbsp;&nbsp;&nbsp;��Ƭ״̬ͳ�Ʒֲ��������λ���ţ�
			<br/>
			<br/>
			<table align="left" class="pn-ltable" width="800" cellspacing="1" cellpadding="0" border="0" >
				<thead class="pn-lthead">
					<tr>
						<c:forEach items="${cardScatterList}" var="item">
							<th style="white-space: nowrap; padding-left: 5px; padding-right: 5px;">
								<c:if test="${item[1]==11}">��ڷ���(��;)</c:if>
								<c:if test="${item[1]==12}">���ڻ���</c:if>
								<c:if test="${item[1]==13}">����</c:if>
								<c:if test="${item[1]==14}">δ֪����ʧ��</c:if>
								<c:if test="${item[1]==15}">����</c:if>
								<c:if test="${item[1]==16}">�����ѷ���</c:if>
							</th>
						</c:forEach>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<tr>
						<c:forEach items="${cardScatterList}" var="item">
							<td align="center">
								${item[0]}
							</td>
						</c:forEach>
					</tr>
				</tbody>
			</table>
			<br/>
			<br/>
			<br/>
			<br/>
			<br/>
			<br/>
			<br/>
			&nbsp;&nbsp;&nbsp;&nbsp;�û������ͷֲ��������λ���ţ�
			<br/>
			<br/>
			<table align="left" class="pn-ltable" width="800" cellspacing="1" cellpadding="0" border="0" >
				<thead class="pn-lthead">
					<tr>
						<th style="white-space: nowrap; padding-left: 5px; padding-right: 5px;">
							
						</th>
						<c:forEach items="${userCardTypeList}" var="item">
							<th style="white-space: nowrap; padding-left: 5px; padding-right: 5px;">
								${item[2]}
							</th>
						</c:forEach>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<tr>
						<td align="center">
							����
						</td>
						<c:forEach items="${userCardTypeList}" var="item">
							<td align="center">
								${item[0]}
							</td>
						</c:forEach>
					</tr>
					<tr>
						<td align="center">
							����
						</td>
						<c:forEach items="${userCardTypeList}" var="item">
							<td align="center">
								${item[1]}
							</td>
						</c:forEach>
					</tr>
				</tbody>
			</table>
			<br/>
			<br/>
			<br/>
			<br/>
			<br/>
			<br/>
			<br/>
			<br/>
			&nbsp;&nbsp;&nbsp;&nbsp;ͨ��ȯ���ͷֲ������
			<br/>
			<br/>
			<table align="left" class="pn-ltable" width="800" cellspacing="1" cellpadding="0" border="0" >
				<thead class="pn-lthead">
					<tr>
						<c:forEach items="${ticketTypeList}" var="item">
							<th style="white-space: nowrap; padding-left: 5px; padding-right: 5px;">
								${item[1]}
							</th>
						</c:forEach>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<tr>
						<c:forEach items="${ticketTypeList}" var="item">
							<td align="center">
								${item[0]}
							</td>
						</c:forEach>
					</tr>
				</tbody>
			</table>
		</div>
	</body>
</html>