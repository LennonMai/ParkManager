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
				<div class="rpos">当前位置： ${currentPosition}</div>
				<form class="ropt" method="post">
					<input type="button" value=" 返 回 " onclick="history.back();"/>
				</form>
				<div class="clear"></div>
			</div>
			<form name="tableForm" method="post" action="securityVehPass_queryVehPass.do?vehPassId=${vehPassId }">
			<!-- 显示list数据-->
			<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th>过车编号</th>
						<th>依据是否有效</th>
						<th>指令编号</th>
						<th>指令修改编号</th>
						<th>卡表面号</th>
						<th>类    型</th>					
						<th>有效类型</th>
						<th>方    式</th>
						<th>产生时间</th>
						<th>生效时间</th>
						<th>失效时间</th>
						<th>状    态</th>
						<th>操作员类型</th>
						<th>操作员号</th>
						<th>指令是否有效</th>
						<th>查看指令历史</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
							<td>${item[0].vehPassId }</td>
							<td>
								<c:if test="${item[0].isValid==0}">被覆盖</c:if>
								<c:if test="${item[0].isValid==1}">有效</c:if>
							</td>
							<td>${item[0].commandId }</td>
							<td>${item[0].commandModId }</td>
							<td>${item[1].cardNo }</td>
							<td>
								<c:if test="${item[1].type==1}">锁定</c:if>
								<c:if test="${item[1].type==2}">解锁</c:if>
							</td>
							<td>
								<c:if test="${item[1].validType==1}">每日有效</c:if>
								<c:if test="${item[1].validType==2}">当次有效</c:if>
								<c:if test="${item[1].validType==3}">永久有效</c:if>
								<c:if test="${item[1].validType==4}">不定时</c:if>
							</td>
							<td>
								<c:if test="${item[1].useType==1}">短信</c:if>
								<c:if test="${item[1].useType==2}">语音</c:if>
								<c:if test="${item[1].useType==3}">人工</c:if>
							</td>
							<td><fmt:formatDate value="${item[1].opTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td>${item[1].startTime}</td>
							<td>${item[1].endTime}</td>
							<td>
								<c:if test="${item[1].status==0}">未发送</c:if>
								<c:if test="${item[1].status==1}">已发送</c:if>
								<c:if test="${item[1].status==2}">已答复</c:if>
							</td>
							<td>
								<c:if test="${item[1].operatorType==1}">人工</c:if>
								<c:if test="${item[1].operatorType==2}">语音</c:if>
								<c:if test="${item[1].operatorType==3}">车道</c:if>
								<c:if test="${item[1].operatorType==4}">数据库作业</c:if>
							</td>
							<td>${item[1].operatorNo }</td>
							<td>
								<c:if test="${item[1].isValid==0}">无效</c:if>
								<c:if test="${item[1].isValid==1}">有效</c:if>
							</td>		
							<td>
								<a href="securityCommandBackup_show.do?commandId=${item[1].commandId }&modId=${item[1].modId }" class="pn-loperator">查  看</a>
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