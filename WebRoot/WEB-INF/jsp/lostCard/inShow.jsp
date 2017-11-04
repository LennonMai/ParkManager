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
			<table width="900" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
				<tr>
					<td class="pn-fcontent" width="600">
						<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
							<tr>
								<td class="pn-flabel pn-flabel-h">记 录 号：</td>
								<td class="pn-fcontent">${list[0].RecordNo}</td>
								<td class="pn-flabel pn-flabel-h">流 水 号：</td>
								<td class="pn-fcontent">${list[0].ListNo}</td>
							</tr>
							<tr>
								<td class="pn-flabel pn-flabel-h">区域编码：</td>
								<td class="pn-fcontent">${list[0].AreaNo}</td>
								<td class="pn-flabel pn-flabel-h">区域名称：</td>
								<td class="pn-fcontent">
									<c:forEach items="${areaList}" var="item1">
										<c:if test="${item1.areaNo==list[0].AreaNo}">${item1.areaName}</c:if>
									</c:forEach>
								</td>
							</tr>
							<tr>
								<td class="pn-flabel pn-flabel-h">小 区 号：</td>
								<td class="pn-fcontent">${list[0].ParkNo}</td>
								<td class="pn-flabel pn-flabel-h">小区名称：</td>
								<td class="pn-fcontent">
									<c:forEach items="${parkList}" var="temp">
										<c:if test="${temp.parkNo==list[0].ParkNo}">${temp.parkName}</c:if>
									</c:forEach>
								</td>
							</tr>
							<tr>
								<td class="pn-flabel pn-flabel-h">大 门 号：</td>
								<td class="pn-fcontent">${list[0].GateNo}</td>
								<td class="pn-flabel pn-flabel-h">大门名称：</td>
								<td class="pn-fcontent">${list[0].GateName}</td>
							</tr>
							<tr>
								<td class="pn-flabel pn-flabel-h">车 道 号：</td>
								<td class="pn-fcontent">${list[0].LaneNo}</td>
								<td class="pn-flabel pn-flabel-h">车    型：</td>
								<td class="pn-fcontent">
									<c:forEach items="${vehTypeList}" var="typeItem">
		                            	<c:if test="${typeItem.vehTypeNo==list[0].VehType}">${typeItem.vehTypeName}</c:if>
		                            </c:forEach>
								</td>
							</tr>
							<tr>
								<td class="pn-flabel pn-flabel-h">车    种：</td>
								<td class="pn-fcontent">
									<c:forEach items="${vehClassList}" var="classItem">
		                            	<c:if test="${classItem.vehClassNo==list[0].VehClass}">${classItem.vehClassName}</c:if>
		                            </c:forEach>
								</td>
								<td class="pn-flabel pn-flabel-h">上传时间：</td>
								<td class="pn-fcontent"><fmt:formatDate value="${list[0].UploadTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							</tr>
							<tr>
								<td class="pn-flabel pn-flabel-h">车 牌 号：</td>
								<td class="pn-fcontent">${list[0].VehPlate}</td>
								<td class="pn-flabel pn-flabel-h">车 辆 数：</td>
								<td class="pn-fcontent">${list[0].VehCount}</td>
							</tr>
							<tr>
								<td class="pn-flabel pn-flabel-h">发卡时间：</td>
								<td class="pn-fcontent">
									<fmt:formatDate value="${list[0].OpTime}" pattern="yyyy-MM-dd HH:mm:ss" />
								</td>
								<td class="pn-flabel pn-flabel-h">收费员工号：</td>
								<td class="pn-fcontent">${list[0].OperatorNo}</td>
							</tr>
							<tr>
								<td class="pn-flabel pn-flabel-h">收费员姓名：</td>
								<td class="pn-fcontent">${list[0].OperatorName}</td>
								<td class="pn-flabel pn-flabel-h">身份卡ID号：</td>
								<td class="pn-fcontent">${list[0].ID}</td>
							</tr>
							<tr>
								<td class="pn-flabel pn-flabel-h">身份卡表面号：</td>
								<td class="pn-fcontent">${list[0].CardTrunkNo}</td>
								<td class="pn-flabel pn-flabel-h">车型自动识别：</td>
								<td class="pn-fcontent">${list[0].VehTypeAuto}</td>
							</tr>
							<tr>
								<td class="pn-flabel pn-flabel-h">车牌自动识别：</td>
								<td class="pn-fcontent">${list[0].VehPlateAuto}</td>
								<td class="pn-flabel pn-flabel-h">工 班 号：</td>
								<td class="pn-fcontent">
									<c:forEach items="${squadList}" var="item">
		                            	<c:if test="${item.squadNo==list[0].SquadNo}">${item.squadName}</c:if>
		                            </c:forEach>
								</td>
							</tr>
							<tr>
								<td class="pn-flabel pn-flabel-h">工班日期：</td>
								<td class="pn-fcontent">
									<fmt:formatDate value="${list[0].SquadDate}" pattern="yyyy-MM-dd" />
								</td>
								<td class="pn-flabel pn-flabel-h">通行卷类型：</td>
								<td class="pn-fcontent">
									<c:forEach items="${ticketTypeList}" var="item">
		                            	<c:if test="${item.ticketTypeNo==list[0].TicketType}">${item.ticketTypeName}</c:if>
		                            </c:forEach>
								</td>
							</tr>
							<tr>
								<td class="pn-flabel pn-flabel-h">obu号：</td>
								<td class="pn-fcontent">${list[0].OBUid}</td>
								<td class="pn-flabel pn-flabel-h">通行卡ID号：</td>
								<td class="pn-fcontent">${list[0].CardID}</td>
							</tr>
							<tr>
								<td class="pn-flabel pn-flabel-h">通行卡表面号：</td>
								<td class="pn-fcontent">${list[0].CardNo}</td>
								<td class="pn-flabel pn-flabel-h">卡盒编码：</td>
								<td class="pn-fcontent">${list[0].CardBoxNo}</td>
							</tr>
							<tr>
								<td class="pn-flabel pn-flabel-h">卡箱编码：</td>
								<td class="pn-fcontent">${list[0].CardTrunkNo}</td>
								<td class="pn-flabel pn-flabel-h">特殊事件：</td>
								<td class="pn-fcontent">
<%-- 									<c:forEach items="${spEventList}" var="item">
		                            	<c:if test="${item.spEventNo==list[0].SpEvent}">${item.spEventName}</c:if>
		                            </c:forEach> --%>
		                             ${list[0].SpEvent }
								</td>
							</tr>
							<tr>
								<td class="pn-flabel pn-flabel-h">校验码：</td>
								<td class="pn-fcontent">${list[0].VerifyCode}</td>
								<td class="pn-flabel pn-flabel-h">流水表文件名：</td>
								<td class="pn-fcontent">${list[0].ListName}</td>
							</tr>
						</table>
					</td>
					<td class="pn-fcontent" valign="bottom">
						<b>&nbsp;&nbsp;入口图像：</b>
						<br/>
						<br/>
						<img src="lostCard_readImg.do?imagSrc=${inSrc}" alt="无图片" width="450px"/>
					</td>
				</tr>
			</table>	
		</div>
	</body>
</html>