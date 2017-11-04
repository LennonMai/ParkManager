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
				<table width="800" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
					<tr>
						<td class="pn-fcontent" width="60%">
							<br/>
							�������Ϣ��<br/>
							<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
							<tr>
								<td class="pn-flabel pn-flabel-h">
									�����ˮ�ţ�
								</td>
								<td class="pn-fcontent">
									${list[0].inListNo }
								</td>
								<td class="pn-flabel pn-flabel-h">
									������ˮ�ţ�
								</td>
								<td class="pn-fcontent">
									${list[0].listNo }
								</td>
							</tr>
							<tr>
								<td class="pn-flabel pn-flabel-h">
									���С������
								</td>
								<td class="pn-fcontent">
									<c:forEach items="${parkList}" var="temp">
										<c:if test="${temp.parkNo == listInlist[0].parkNo}">${temp.parkName}</c:if>
									</c:forEach>
								</td>
								<td class="pn-flabel pn-flabel-h">
									����С�����ƣ�
								</td>
								<td class="pn-fcontent">
									<c:forEach items="${parkList}" var="temp">
										<c:if test="${temp.parkNo == list[0].parkNo}">${temp.parkName}</c:if>
									</c:forEach>
								</td>
							</tr>
							<tr>
								<td class="pn-flabel pn-flabel-h">
									��ڴ�������
								</td>
								<td class="pn-fcontent">
									${list[0].inGateName }
								</td>
								<td class="pn-flabel pn-flabel-h">
									���ڴ�������
								</td>
								<td class="pn-fcontent">
									${list[0].gateName }
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
									���ڳ����ţ�
								</td>
								<td class="pn-fcontent">
									${list[0].laneNo }
								</td>
							</tr>
							<tr>
								<td class="pn-flabel pn-flabel-h">
									��ڳ��ͣ�
								</td>
								<td class="pn-fcontent">
									<c:forEach items="${vehTypeList}" var="item">
                            			<c:if test="${item.vehTypeNo==list[0].inVehType}">${item.vehTypeName}</c:if>
                            		</c:forEach>
								</td>
								<td class="pn-flabel pn-flabel-h">
									���ڳ��ͣ�
								</td>
								<td class="pn-fcontent">
									<c:forEach items="${vehTypeList}" var="item">
                            			<c:if test="${item.vehTypeNo==list[0].vehType}">${item.vehTypeName}</c:if>
                            		</c:forEach>
								</td>
							</tr>
							<tr>
								<td class="pn-flabel pn-flabel-h">
									��ڳ��֣�
								</td>
								<td class="pn-fcontent">
									<c:forEach items="${vehClassList}" var="item">
                            			<c:if test="${item.vehClassNo==list[0].inVehClass}">${item.vehClassName}</c:if>
                            		</c:forEach>
								</td>
								<td class="pn-flabel pn-flabel-h">
									���ڳ��֣�
								</td>
								<td class="pn-fcontent">
									<c:forEach items="${vehClassList}" var="item">
                            			<c:if test="${item.vehClassNo==list[0].vehClass}">${item.vehClassName}</c:if>
                            		</c:forEach>
								</td>
							</tr>
							<tr>
								<td class="pn-flabel pn-flabel-h">
									��ڳ��ƣ�
								</td>
								<td class="pn-fcontent">
									${list[0].inVehPlate }
								</td>
								<td class="pn-flabel pn-flabel-h">
									���ڳ��ƣ�
								</td>
								<td class="pn-fcontent">
									${list[0].vehPlate }
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
									�����շ�ʱ�䣺
								</td>
								<td class="pn-fcontent">
									<fmt:formatDate value="${list[0].opTime }" pattern="yyyy-MM-dd HH:mm:ss" />
								</td>
							</tr>
							<tr>
								<td class="pn-flabel pn-flabel-h">
									��ڷ���Ա��
								</td>
								<td class="pn-fcontent">
									${listInlist[0].operatorName }
								</td>
								<td class="pn-flabel pn-flabel-h">
									�����շ�Ա��
								</td>
								<td class="pn-fcontent">
									${list[0].operatorName }
								</td>
							</tr>
						</table>
						</td>
						<td class="pn-fcontent" width="40%" align="center">
							�������ƣ�<span>
										<c:forEach items="${areaList}" var="item1">
											<c:if test="${item1.areaNo==list[0].areaNo}">${item1.areaName}</c:if>
										</c:forEach>
									</span>
							<br/>
							<br/>
							<br/>
							ͨ��ȯ���ͣ�
								<c:forEach items="${ticketTypeList}" var="item">
                            		<c:if test="${item.ticketTypeNo==list[0].ticketType}">${item.ticketTypeName}</c:if>
                            	</c:forEach>
							<br/>
							<br/>
							<br/>
							������ţ�${list[0].cardNo }
							<br/>
							<br/>
							<br/>
							�շѽ�${list[0].cashMoney }
						</td>
					</tr>
					<tr>
						<td class="pn-fcontent" align="left" colspan="2">
							<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
								<tr>
									<td class="pn-fcontent" width="45%">
										<br/>&nbsp;&nbsp;<b>���ͼ��</b><br/><br/>
										<img src="lostCard_readImg.do?imagSrc=${inSrc}" alt="��ͼƬ" width="450px"/>
									</td>
									<td class="pn-fcontent" width="10%" align="center">
										<b>ͼ��Ա�</b>
									</td>
									<td class="pn-fcontent" width="45%">
										<br/>&nbsp;&nbsp;<b>����ͼ��</b><br/><br/>
										<img src="lostCard_readImg.do?imagSrc=${outSrc}" alt="��ͼƬ" width="450px"/>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
		</div>
	</body>
</html>