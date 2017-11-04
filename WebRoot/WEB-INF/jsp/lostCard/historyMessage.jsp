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
			<table width="800" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
				<tr>
					<td width="10%" class="pn-flabel pn-flabel-h">卡表面号：</td>
					<td class="pn-fcontent">${loseCardHis.cardNo }</td>
					<td width="10%" class="pn-flabel pn-flabel-h">卡 状 态</td>
					<td class="pn-fcontent">
						<c:if test="${loseCardHis.cardStatus == 11}">入口发卡</c:if>
						<c:if test="${loseCardHis.cardStatus == 12}">出口回收</c:if>
						<c:if test="${loseCardHis.cardStatus == 13}">丢卡(丢失数据不足，无法追回)</c:if>
						<c:if test="${loseCardHis.cardStatus == 14}">未知</c:if>
						<c:if test="${loseCardHis.cardStatus == 15}">坏卡</c:if>
						<c:if test="${loseCardHis.cardStatus == 16}">已罚款</c:if>
					</td>
					<td width="10%" class="pn-flabel pn-flabel-h">拿卡车牌：</td>
					<td width="15%" class="pn-fcontent">${loseCardHis.vehPlate }</td>
					<td width="10%" class="pn-flabel pn-flabel-h">拿卡车主：</td>
					<td class="pn-fcontent">${loseCardHis.owner }</td>
				</tr>
				<tr>
					<td width="50%" class="pn-fcontent" colspan="4">
						<br/>入口信息：<br/>
						<table cellspacing=1 class="pn-ftable" bodercolor=#ffaa00>
							<tr>
								<td width="10%" class="pn-flabel pn-flabel-h">流 水 号：</td>
								<td width="15%" class="pn-fcontent">${listInlist[0].listNo }</td>
								<td width="10%" class="pn-flabel pn-flabel-h">小 区 名：</td>
								<td width="15%" class="pn-fcontent">
									<c:forEach items="${parkList}" var="temp">
										<c:if test="${temp.parkNo==listInlist[0].parkNo}">${temp.parkName}</c:if>
									</c:forEach>
								</td>
							</tr>
							<tr>
								<td width="10%" class="pn-flabel pn-flabel-h">时    间：</td>
								<td width="15%" class="pn-fcontent">
									<fmt:formatDate value="${listInlist[0].opTime}" pattern="yyyy-MM-dd HH:mm:ss" />
								</td>
								<td width="10%" class="pn-flabel pn-flabel-h">大 门 名：</td>
								<td width="15%" class="pn-fcontent">${listInlist[0].gateName }</td>
							</tr>
							<tr>
								<td width="10%" class="pn-flabel pn-flabel-h">发 卡 员：</td>
								<td width="15%" class="pn-fcontent">${listInlist[0].operatorName }</td>
								<td width="10%" class="pn-flabel pn-flabel-h">车 道 号：</td>
								<td width="15%" class="pn-fcontent">${listInlist[0].laneNo }</td>
							</tr>
							<tr>
								<td width="10%" class="pn-flabel pn-flabel-h">发 卡 号：</td>
								<td width="15%" class="pn-fcontent" colspan="3">${listInlist[0].operatorNo }</td>
							</tr>
							<tr>
								<td class="pn-fcontent" colspan="4">
									&nbsp;&nbsp; <br/><b>入口图像：</b><br/><br/>
									<img src="lostCard_readImg.do?imagSrc=${imagSrc }" alt="无图片"/>
								</td>
							</tr>
						</table>
					</td>
					<td width="50%" class="pn-fcontent" colspan="4">
						<br/>出口信息：<br/>
						<table cellspacing=1 class="pn-ftable" bodercolor=#ffaa00>
							<tr>
								<td width="10%" class="pn-flabel pn-flabel-h">流 水 号：</td>
								<td width="15%" class="pn-fcontent">${list[0].listNo }</td>
								<td width="10%" class="pn-flabel pn-flabel-h">小 区 名：</td>
								<td width="15%" class="pn-fcontent">
									<c:forEach items="${parkList}" var="temp">
										<c:if test="${temp.parkNo==list[0].parkNo}">${temp.parkName}</c:if>
									</c:forEach>
								</td>
							</tr>
							<tr>
								<td width="10%" class="pn-flabel pn-flabel-h">时    间：</td>
								<td width="15%" class="pn-fcontent">
									<fmt:formatDate value="${list[0].opTime}" pattern="yyyy-MM-dd HH:mm:ss" />
								</td>
								<td width="10%" class="pn-flabel pn-flabel-h">大 门 名：</td>
								<td width="15%" class="pn-fcontent">${list[0].gateName }</td>
							</tr>
							<tr>
								<td width="10%" class="pn-flabel pn-flabel-h">收 费 员：</td>
								<td width="15%" class="pn-fcontent">${list[0].operatorName }</td>
								<td width="10%" class="pn-flabel pn-flabel-h">车 道 号：</td>
								<td width="15%" class="pn-fcontent">${list[0].laneNo }</td>
							</tr>
							<tr>
								<td width="10%" class="pn-flabel pn-flabel-h">收 费 号：</td>
								<td width="15%" class="pn-fcontent">${list[0].operatorNo }</td>
								<td width="10%" class="pn-flabel pn-flabel-h">备    注：</td>
								<td width="15%" class="pn-fcontent">
									<c:if test="${list[0] == null}"></c:if>
									<c:if test="${list[0] != null}">${loseCardHis.outRemark}</c:if>
								</td>
							</tr>
							<tr>
								<td class="pn-fcontent" colspan="4">
									&nbsp;&nbsp;<br/><b>出口图像：</b><br/><br/>
									<img src="lostCard_readImg.do?imagSrc=${outSrc }" alt="无图片"/>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
	</body>
</html>