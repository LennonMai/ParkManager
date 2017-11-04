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
				<div class="rpos">当前位置： ${currentPosition}</div>
				<form class="ropt" method="post">
					<input type="button" value=" 返 回 " onclick="history.back();"/>
				</form>
				<div class="clear"></div>
			</div>
			<form name="tableForm" method="post" action="securityCommandBackup_show.do">
			<!-- 显示list数据-->
			<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th>指令编号</th>
						<th>指令修改号</th>
						<th>操    作</th>
						<th>方    式</th>
						<th>卡    号</th>
						<th>指令类型</th>
						<th>有效类型</th>
						<th>添加时间</th>
						<th>生效时间</th>
						<th>失效时间</th>
						<th>修改时间</th>
						<th>状    态</th>
						<th>操作员类型</th>
						<th>操作员编号</th>
						<th>有效标志</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
							<td>${item[1].commandId }</td>
							<td>${item[1].postModId }</td>
							<td>
								<c:if test="${item[1].operationType==1}">添加 </c:if>
								<c:if test="${item[1].operationType==2}">修改 </c:if>
								<c:if test="${item[1].operationType==3}">删除 </c:if>
							</td>
							<td>
								<c:if test="${item[0].useType==1}">短信</c:if>
								<c:if test="${item[0].useType==2}">语音</c:if>
								<c:if test="${item[0].useType==3}">人工</c:if>
							</td>
							<td>${item[0].cardNo }</td>
							<td>
								<c:if test="${item[0].type==1}">锁定</c:if>
								<c:if test="${item[0].type==2}">解锁</c:if>
							</td>
							<td>
								<c:if test="${item[0].validType==1}">每日有效</c:if>
								<c:if test="${item[0].validType==2}">当次有效</c:if>
								<c:if test="${item[0].validType==3}">永久有效</c:if>
								<c:if test="${item[0].validType==4}">不定时</c:if>
							</td>
							<td><fmt:formatDate value="${item[0].opTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>							
							<td>${item[0].startTime}</td>
							<td>${item[0].endTime}</td>
							<td><fmt:formatDate value="${item[0].addTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td>
								<c:if test="${item[0].attribute==0}">正常</c:if>
								<c:if test="${item[0].attribute==1}">已删除</c:if>
								<c:if test="${item[0].attribute==2}">已处理</c:if>
								<c:if test="${item[0].attribute==3}">超时未处理</c:if>
							</td>
							<td>
								<c:if test="${item[0].operatorType==1}">人工</c:if>
								<c:if test="${item[0].operatorType==2}">语音</c:if>
								<c:if test="${item[0].operatorType==3}">车道</c:if>
								<c:if test="${item[0].operatorType==4}">数据库作业</c:if>
							</td>
							<td>${item[0].operatorNo }</td>		
							<td>
								<c:if test="${item[0].isValid==0}">无效</c:if>
								<c:if test="${item[0].isValid==1}">有效</c:if>
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