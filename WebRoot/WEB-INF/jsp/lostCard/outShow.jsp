<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
	<head>
		<title></title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css" />
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css" />
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">
					当前位置： ${currentPosition}
				</div>
				<form class="ropt" method="post">
					<input type="button" value=" 返 回 " onclick="history.back();" />
				</tr>
				</form>
				<div class="clear"></div>
			</div>
			<table width="800" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
				<tr>
					<td class="pn-flabel pn-flabel-h">
						出口记录号：
					</td>
					<td class="pn-fcontent">
						${list[0].RecordNo }
					</td>
					<td class="pn-flabel pn-flabel-h">
						小区号：
					</td>
					<td class="pn-fcontent">
						${list[0].ParkNo }
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						小区名称：
					</td>
					<td class="pn-fcontent">
						<c:forEach items="${parkList}" var="temp">
							<c:if test="${temp.parkNo==list[0].ParkNo}">${temp.parkName}</c:if>
						</c:forEach>
					</td>
					<td class="pn-flabel pn-flabel-h">
						入口流水号：
					</td>
					<td class="pn-fcontent">
						${list[0].inListNo }
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						入口大门编号：
					</td>
					<td class="pn-fcontent">
						${list[0].inGateNo }
					</td>
					<td class="pn-flabel pn-flabel-h">
						入口大门名：
					</td>
					<td class="pn-fcontent">
						${list[0].inGateName }
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						入口车道号：
					</td>
					<td class="pn-fcontent">
						${list[0].inLaneNo }
					</td>
					<td class="pn-flabel pn-flabel-h">
						入口车型：
					</td>
					<td class="pn-fcontent">
						<c:forEach items="${vehTypeList}" var="typeItem">
                            <c:if test="${typeItem.vehTypeNo==list[0].inVehType}">${typeItem.vehTypeName}</c:if>
                        </c:forEach>
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						入口车种：
					</td>
					<td class="pn-fcontent">
						<c:forEach items="${vehClassList}" var="classItem">
                            <c:if test="${classItem.vehClassNo==list[0].inVehClass}">${classItem.vehClassName}</c:if>
                        </c:forEach>
					</td>
					<td class="pn-flabel pn-flabel-h">
						入口车牌：
					</td>
					<td class="pn-fcontent">
						${list[0].InVehPlate }
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						入口发卡时间：
					</td>
					<td class="pn-fcontent">
						<fmt:formatDate value="${list[0].inOpTime }" pattern="yyyy-MM-dd HH:mm:ss" />
					</td>
					<td class="pn-flabel pn-flabel-h">
						入口发卡员工号：
					</td>
					<td class="pn-fcontent">
						${list[0].inOperatorNo }
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						入口车型自动识别：
					</td>
					<td class="pn-fcontent">
						${list[0].inVehTypeAuto }
					</td>
					<td class="pn-flabel pn-flabel-h">
						入口车牌自动识别：
					</td>
					<td class="pn-fcontent">
						${list[0].inVehPlateAuto }
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						上传时间：
					</td>
					<td class="pn-fcontent">
						<fmt:formatDate value="${list[0].uploadTime }" pattern="yyyy-MM-dd HH:mm:ss" />
					</td>
					<td class="pn-flabel pn-flabel-h">
						流水表文件名：
					</td>
					<td class="pn-fcontent">
						${list[0].listName }
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						出口流水号：
					</td>
					<td class="pn-fcontent">
						${list[0].listNo }
					</td>
					<td class="pn-flabel pn-flabel-h">
						出口大门编号：
					</td>
					<td class="pn-fcontent">
						${list[0].GateNo }
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						出口大门名：
					</td>
					<td class="pn-fcontent">
						${list[0].gateName }
					</td>
					<td class="pn-flabel pn-flabel-h">
						出口车道号：
					</td>
					<td class="pn-fcontent">
						${list[0].laneNo }
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						出口车型：
					</td>
					<td class="pn-fcontent">
						<c:forEach items="${vehTypeList}" var="typeItem">
                            <c:if test="${typeItem.vehTypeNo==list[0].vehType}">${typeItem.vehTypeName}</c:if>
                        </c:forEach>
					</td>
					<td class="pn-flabel pn-flabel-h">
						出口车种：
					</td>
					<td class="pn-fcontent">
						<c:forEach items="${vehClassList}" var="classItem">
                            <c:if test="${classItem.vehClassNo==list[0].vehClass}">${classItem.vehClassName}</c:if>
                        </c:forEach>
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						出口车牌：
					</td>
					<td class="pn-fcontent">
						${list[0].vehPlate }
					</td>
					<td class="pn-flabel pn-flabel-h">
						出口发卡时间：
					</td>
					<td class="pn-fcontent">
						<fmt:formatDate value="${list[0].opTime }" pattern="yyyy-MM-dd HH:mm:ss" />
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						收费员工号：
					</td>
					<td class="pn-fcontent">
						${list[0].operatorNo }
					</td>
					<td class="pn-flabel pn-flabel-h">
						收费员姓名：
					</td>
					<td class="pn-fcontent">
						${list[0].operatorName }
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						身份卡ID号：
					</td>
					<td class="pn-fcontent">
						${list[0].id }
					</td>
					<td class="pn-flabel pn-flabel-h">
						身份卡表面号：
					</td>
					<td class="pn-fcontent">
						${list[0].idno }
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						支付卡类型：
					</td>
					<td class="pn-fcontent">
						<c:if test="${list[0].payCardType ==0}">无卡</c:if>
						<c:forEach items="${cardTypeList}" var="temp">
							<c:if test="${temp.cardType == list[0].payCardType}">${temp.typeName}</c:if>
						</c:forEach>
					</td>
					<td class="pn-flabel pn-flabel-h">
						支付卡号：
					</td>
					<td class="pn-fcontent">
						${list[0].payCardId }
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						支付卡表面号：
					</td>
					<td class="pn-fcontent">
						${list[0].payCardNo }
					</td>
					<td class="pn-flabel pn-flabel-h">
						支付卡余额：
					</td>
					<td class="pn-fcontent">
						${list[0].payCardBalance }
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						收费车金额：
					</td>
					<td class="pn-fcontent">
						${list[0].cashMoney }
					</td>
					<td class="pn-flabel pn-flabel-h">
						免费车金额：
					</td>
					<td class="pn-fcontent">
						${list[0].freeMoney }
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						未付金额：
					</td>
					<td class="pn-fcontent">
						${list[0].unpayMoney }
					</td>
					<td class="pn-flabel pn-flabel-h">
						ETC金额：
					</td>
					<td class="pn-fcontent">
						${list[0].etcmoney }
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						免费路段编码：
					</td>
					<td class="pn-fcontent"></td>
					<td class="pn-flabel pn-flabel-h">
						ETC交易系列号：
					</td>
					<td class="pn-fcontent">
						${list[0].etctradeNo }
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						ETCTAC码：
					</td>
					<td class="pn-fcontent">
						${list[0].etctac }
					</td>
					<td class="pn-flabel pn-flabel-h">
						ETC终端交易系列号：
					</td>
					<td class="pn-fcontent">
						${list[0].etctermTradNo }
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						校验码：
					</td>
					<td class="pn-fcontent">
						${list[0].verifyCode }
					</td>
					<td class="pn-flabel pn-flabel-h">
						ETC终端编码：
					</td>
					<td class="pn-fcontent">
						${list[0].etctermCode }
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						工班号：
					</td>
					<td class="pn-fcontent">
						<c:forEach items="${squadList}" var="item">
                            <c:if test="${item.squadNo==list[0].squadNo}">${item.squadName}</c:if>
                        </c:forEach>
					</td>
					<td class="pn-flabel pn-flabel-h">
						工班日期：
					</td>
					<td class="pn-fcontent">
						<fmt:formatDate value="${list[0].squadDate }" pattern="yyyy-MM-dd" />
						
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						通行券类型：
					</td>
					<td class="pn-fcontent">
						<c:forEach items="${ticketTypeList}" var="item">
                            <c:if test="${item.ticketTypeNo==list[0].ticketType}">${item.ticketTypeName}</c:if>
                        </c:forEach>
					</td>
					<td class="pn-flabel pn-flabel-h">
						通行卡ID号：
					</td>
					<td class="pn-fcontent">
						${list[0].cardId }
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						通行卡表面号：
					</td>
					<td class="pn-fcontent">
						${list[0].cardNo }
					</td>
					<td class="pn-flabel pn-flabel-h">
						卡盒编码：
					</td>
					<td class="pn-fcontent">
						${list[0].cardBoxNo }
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						卡箱编码：
					</td>
					<td class="pn-fcontent">
						${list[0].cardTrunkNo }
					</td>
					<td class="pn-flabel pn-flabel-h">
						费率版本号：
					</td>
					<td class="pn-fcontent">
						${list[0].priceVerNo }
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						特殊事件：
					</td>
					<td class="pn-fcontent">
<%-- 						<c:forEach items="${spEventList}" var="item">
                            <c:if test="${item.spEventNo==list[0].spEvent}">${item.spEventName}</c:if>
                        </c:forEach> --%>
                        ${list[0].SpEvent }
					</td>
					<td class="pn-flabel pn-flabel-h">
						发票号：
					</td>
					<td class="pn-fcontent">
						${list[0].invoiceId }
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						车辆数：
					</td>
					<td class="pn-fcontent">
						${list[0].vehCount }
					</td>
					<td class="pn-flabel pn-flabel-h">
						区域编码：
					</td>
					<td class="pn-fcontent">
						${list[0].areaNo }
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						区域名称：
					</td>
					<td class="pn-fcontent">
						<c:forEach items="${areaList}" var="item1">
							<c:if test="${item1.areaNo==list[0].areaNo}">${item1.areaName}</c:if>
						</c:forEach>
					</td>
					<td class="pn-flabel pn-flabel-h">
						OBU号：
					</td>
					<td class="pn-fcontent">
						${list[0].OBUId }
					</td>
				</tr>
				
			</table>
		</div>
	</body>
</html>