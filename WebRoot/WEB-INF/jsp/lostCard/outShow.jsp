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
					��ǰλ�ã� ${currentPosition}
				</div>
				<form class="ropt" method="post">
					<input type="button" value=" �� �� " onclick="history.back();" />
				</tr>
				</form>
				<div class="clear"></div>
			</div>
			<table width="800" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
				<tr>
					<td class="pn-flabel pn-flabel-h">
						���ڼ�¼�ţ�
					</td>
					<td class="pn-fcontent">
						${list[0].RecordNo }
					</td>
					<td class="pn-flabel pn-flabel-h">
						С���ţ�
					</td>
					<td class="pn-fcontent">
						${list[0].ParkNo }
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						С�����ƣ�
					</td>
					<td class="pn-fcontent">
						<c:forEach items="${parkList}" var="temp">
							<c:if test="${temp.parkNo==list[0].ParkNo}">${temp.parkName}</c:if>
						</c:forEach>
					</td>
					<td class="pn-flabel pn-flabel-h">
						�����ˮ�ţ�
					</td>
					<td class="pn-fcontent">
						${list[0].inListNo }
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						��ڴ��ű�ţ�
					</td>
					<td class="pn-fcontent">
						${list[0].inGateNo }
					</td>
					<td class="pn-flabel pn-flabel-h">
						��ڴ�������
					</td>
					<td class="pn-fcontent">
						${list[0].inGateName }
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						��ڳ����ţ�
					</td>
					<td class="pn-fcontent">
						${list[0].inLaneNo }
					</td>
					<td class="pn-flabel pn-flabel-h">
						��ڳ��ͣ�
					</td>
					<td class="pn-fcontent">
						<c:forEach items="${vehTypeList}" var="typeItem">
                            <c:if test="${typeItem.vehTypeNo==list[0].inVehType}">${typeItem.vehTypeName}</c:if>
                        </c:forEach>
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						��ڳ��֣�
					</td>
					<td class="pn-fcontent">
						<c:forEach items="${vehClassList}" var="classItem">
                            <c:if test="${classItem.vehClassNo==list[0].inVehClass}">${classItem.vehClassName}</c:if>
                        </c:forEach>
					</td>
					<td class="pn-flabel pn-flabel-h">
						��ڳ��ƣ�
					</td>
					<td class="pn-fcontent">
						${list[0].InVehPlate }
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						��ڷ���ʱ�䣺
					</td>
					<td class="pn-fcontent">
						<fmt:formatDate value="${list[0].inOpTime }" pattern="yyyy-MM-dd HH:mm:ss" />
					</td>
					<td class="pn-flabel pn-flabel-h">
						��ڷ���Ա���ţ�
					</td>
					<td class="pn-fcontent">
						${list[0].inOperatorNo }
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						��ڳ����Զ�ʶ��
					</td>
					<td class="pn-fcontent">
						${list[0].inVehTypeAuto }
					</td>
					<td class="pn-flabel pn-flabel-h">
						��ڳ����Զ�ʶ��
					</td>
					<td class="pn-fcontent">
						${list[0].inVehPlateAuto }
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						�ϴ�ʱ�䣺
					</td>
					<td class="pn-fcontent">
						<fmt:formatDate value="${list[0].uploadTime }" pattern="yyyy-MM-dd HH:mm:ss" />
					</td>
					<td class="pn-flabel pn-flabel-h">
						��ˮ���ļ�����
					</td>
					<td class="pn-fcontent">
						${list[0].listName }
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						������ˮ�ţ�
					</td>
					<td class="pn-fcontent">
						${list[0].listNo }
					</td>
					<td class="pn-flabel pn-flabel-h">
						���ڴ��ű�ţ�
					</td>
					<td class="pn-fcontent">
						${list[0].GateNo }
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						���ڴ�������
					</td>
					<td class="pn-fcontent">
						${list[0].gateName }
					</td>
					<td class="pn-flabel pn-flabel-h">
						���ڳ����ţ�
					</td>
					<td class="pn-fcontent">
						${list[0].laneNo }
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						���ڳ��ͣ�
					</td>
					<td class="pn-fcontent">
						<c:forEach items="${vehTypeList}" var="typeItem">
                            <c:if test="${typeItem.vehTypeNo==list[0].vehType}">${typeItem.vehTypeName}</c:if>
                        </c:forEach>
					</td>
					<td class="pn-flabel pn-flabel-h">
						���ڳ��֣�
					</td>
					<td class="pn-fcontent">
						<c:forEach items="${vehClassList}" var="classItem">
                            <c:if test="${classItem.vehClassNo==list[0].vehClass}">${classItem.vehClassName}</c:if>
                        </c:forEach>
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						���ڳ��ƣ�
					</td>
					<td class="pn-fcontent">
						${list[0].vehPlate }
					</td>
					<td class="pn-flabel pn-flabel-h">
						���ڷ���ʱ�䣺
					</td>
					<td class="pn-fcontent">
						<fmt:formatDate value="${list[0].opTime }" pattern="yyyy-MM-dd HH:mm:ss" />
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						�շ�Ա���ţ�
					</td>
					<td class="pn-fcontent">
						${list[0].operatorNo }
					</td>
					<td class="pn-flabel pn-flabel-h">
						�շ�Ա������
					</td>
					<td class="pn-fcontent">
						${list[0].operatorName }
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						��ݿ�ID�ţ�
					</td>
					<td class="pn-fcontent">
						${list[0].id }
					</td>
					<td class="pn-flabel pn-flabel-h">
						��ݿ�����ţ�
					</td>
					<td class="pn-fcontent">
						${list[0].idno }
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						֧�������ͣ�
					</td>
					<td class="pn-fcontent">
						<c:if test="${list[0].payCardType ==0}">�޿�</c:if>
						<c:forEach items="${cardTypeList}" var="temp">
							<c:if test="${temp.cardType == list[0].payCardType}">${temp.typeName}</c:if>
						</c:forEach>
					</td>
					<td class="pn-flabel pn-flabel-h">
						֧�����ţ�
					</td>
					<td class="pn-fcontent">
						${list[0].payCardId }
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						֧��������ţ�
					</td>
					<td class="pn-fcontent">
						${list[0].payCardNo }
					</td>
					<td class="pn-flabel pn-flabel-h">
						֧������
					</td>
					<td class="pn-fcontent">
						${list[0].payCardBalance }
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						�շѳ���
					</td>
					<td class="pn-fcontent">
						${list[0].cashMoney }
					</td>
					<td class="pn-flabel pn-flabel-h">
						��ѳ���
					</td>
					<td class="pn-fcontent">
						${list[0].freeMoney }
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						δ����
					</td>
					<td class="pn-fcontent">
						${list[0].unpayMoney }
					</td>
					<td class="pn-flabel pn-flabel-h">
						ETC��
					</td>
					<td class="pn-fcontent">
						${list[0].etcmoney }
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						���·�α��룺
					</td>
					<td class="pn-fcontent"></td>
					<td class="pn-flabel pn-flabel-h">
						ETC����ϵ�кţ�
					</td>
					<td class="pn-fcontent">
						${list[0].etctradeNo }
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						ETCTAC�룺
					</td>
					<td class="pn-fcontent">
						${list[0].etctac }
					</td>
					<td class="pn-flabel pn-flabel-h">
						ETC�ն˽���ϵ�кţ�
					</td>
					<td class="pn-fcontent">
						${list[0].etctermTradNo }
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						У���룺
					</td>
					<td class="pn-fcontent">
						${list[0].verifyCode }
					</td>
					<td class="pn-flabel pn-flabel-h">
						ETC�ն˱��룺
					</td>
					<td class="pn-fcontent">
						${list[0].etctermCode }
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						����ţ�
					</td>
					<td class="pn-fcontent">
						<c:forEach items="${squadList}" var="item">
                            <c:if test="${item.squadNo==list[0].squadNo}">${item.squadName}</c:if>
                        </c:forEach>
					</td>
					<td class="pn-flabel pn-flabel-h">
						�������ڣ�
					</td>
					<td class="pn-fcontent">
						<fmt:formatDate value="${list[0].squadDate }" pattern="yyyy-MM-dd" />
						
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						ͨ��ȯ���ͣ�
					</td>
					<td class="pn-fcontent">
						<c:forEach items="${ticketTypeList}" var="item">
                            <c:if test="${item.ticketTypeNo==list[0].ticketType}">${item.ticketTypeName}</c:if>
                        </c:forEach>
					</td>
					<td class="pn-flabel pn-flabel-h">
						ͨ�п�ID�ţ�
					</td>
					<td class="pn-fcontent">
						${list[0].cardId }
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						ͨ�п�����ţ�
					</td>
					<td class="pn-fcontent">
						${list[0].cardNo }
					</td>
					<td class="pn-flabel pn-flabel-h">
						���б��룺
					</td>
					<td class="pn-fcontent">
						${list[0].cardBoxNo }
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						������룺
					</td>
					<td class="pn-fcontent">
						${list[0].cardTrunkNo }
					</td>
					<td class="pn-flabel pn-flabel-h">
						���ʰ汾�ţ�
					</td>
					<td class="pn-fcontent">
						${list[0].priceVerNo }
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						�����¼���
					</td>
					<td class="pn-fcontent">
<%-- 						<c:forEach items="${spEventList}" var="item">
                            <c:if test="${item.spEventNo==list[0].spEvent}">${item.spEventName}</c:if>
                        </c:forEach> --%>
                        ${list[0].SpEvent }
					</td>
					<td class="pn-flabel pn-flabel-h">
						��Ʊ�ţ�
					</td>
					<td class="pn-fcontent">
						${list[0].invoiceId }
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						��������
					</td>
					<td class="pn-fcontent">
						${list[0].vehCount }
					</td>
					<td class="pn-flabel pn-flabel-h">
						������룺
					</td>
					<td class="pn-fcontent">
						${list[0].areaNo }
					</td>
				</tr>
				<tr>
					<td class="pn-flabel pn-flabel-h">
						�������ƣ�
					</td>
					<td class="pn-fcontent">
						<c:forEach items="${areaList}" var="item1">
							<c:if test="${item1.areaNo==list[0].areaNo}">${item1.areaName}</c:if>
						</c:forEach>
					</td>
					<td class="pn-flabel pn-flabel-h">
						OBU�ţ�
					</td>
					<td class="pn-fcontent">
						${list[0].OBUId }
					</td>
				</tr>
				
			</table>
		</div>
	</body>
</html>