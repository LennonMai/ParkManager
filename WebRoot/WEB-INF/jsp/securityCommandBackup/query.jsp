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
				<div class="clear"></div>
			</div>
			<form name="tableForm" method="post" action="securityCommandBackup_query.do">
				<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
					<tr>
						<td class="pn-flabel pn-flabel-h">用户名：</td>
						<td class="pn-fcontent">
						  <input type="text" name="owner" value="${owner}" />
						</td>
						<td class="pn-flabel pn-flabel-h">指令类型：</td>
						<td class="pn-fcontent">
						  	<select name="type">
						  		<option value="" <c:if test="${type==null}">selected</c:if>>-请选择-</option>
						  		<option value="1" <c:if test="${type==1}">selected</c:if>>锁定</option>
						  		<option value="2" <c:if test="${type==2}">selected</c:if>>解锁</option>
						  	</select>
						</td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">卡&nbsp;&nbsp;号：</td>
						<td class="pn-fcontent">
						  <input type="text" name="cardNo" value="${cardNo}" />
						</td>
						<td class="pn-flabel pn-flabel-h">有效类型：</td>
						<td class="pn-fcontent">
							<select name="validType">
								<option value="" <c:if test="${validType==null}">selected</c:if>>-请选择-</option>
						  		<option value="1" <c:if test="${validType==1}">selected</c:if>>每日有效</option>
						  		<option value="2" <c:if test="${validType==2}">selected</c:if>>当次有效</option>
								<option value="3" <c:if test="${validType==3}">selected</c:if>>永久有效</option>
								<option value="4" <c:if test="${validType==4}">selected</c:if>>不定时</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">车牌号：</td>
						<td class="pn-fcontent" colspan="3">
						  <input type="text" name="vehPlate" value="${vehPlate}" />
						</td>
					</tr>
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input type="submit" value=" 查 询 " />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="reset" value=" 重 置 " />	
						</td>
					</tr>
				</table>
			<!-- 显示list数据-->
			<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th>用户姓名</th>
						<th>卡表面号</th>
						<th>车 牌 号</th>
						<th>指令类型</th>
						<th>有效类型</th>
						<th>添加方式</th>					
						<th>状    态</th>
						<th>添加时间</th>
						<th>生效时间</th>
						<th>失效时间</th>
						<th>修改时间</th>
						<th>操作员类型</th>
						<th>操 作 员</th>
						<th>操作历史</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
							<td>${item[1].owner }</td>
							<td>${item[0].cardNo }</td>
							<td>${item[1].vehPlate }</td>
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
							<td>
								<c:if test="${item[0].useType==1}">短信</c:if>
								<c:if test="${item[0].useType==2}">语音</c:if>
								<c:if test="${item[0].useType==3}">人工</c:if>
							</td>
							<td>
								<c:if test="${item[0].attribute==0}">正常</c:if>
								<c:if test="${item[0].attribute==1}">已删除</c:if>
								<c:if test="${item[0].attribute==2}">已处理</c:if>
								<c:if test="${item[0].attribute==3}">超时未处理</c:if>
							</td>
							<td><fmt:formatDate value="${item[0].opTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td>${item[0].startTime}</td>
							<td>${item[0].endTime}</td>
							<td><fmt:formatDate value="${item[0].addTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td>
								<c:if test="${item[0].operatorType==1}">人工</c:if>
								<c:if test="${item[0].operatorType==2}">语音</c:if>
								<c:if test="${item[0].operatorType==3}">车道</c:if>
								<c:if test="${item[0].operatorType==4}">数据库作业</c:if>
							</td>
							<td>${item[0].operatorNo }</td>		
							<td>
								<a href="securityCommandBackup_show.do?commandId=${item[0].commandId }&modId=${item[0].modId }" class="pn-loperator">查 看</a>
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