<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java"
	pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
	<head>
		<title></title>
		<link type="text/css" rel="stylesheet"
			href="${basePath}/css/admin.css" />
		<link type="text/css" rel="stylesheet"
			href="${basePath}/css/theme.css" />
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript"
			src="${basePath}/datePicker/WdatePicker.js"></script>

	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">
					当前位置： ${currentPosition}
				</div>
				<div class="clear"></div>
			</div>
			<form method="post" action="">
				<!--  <form method="post" action="car_save.do" onsubmit="return check();">-->
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1"
					border="0" >

					<tr>
						<td class="pn-flabel pn-flabel-h">
							账号：
						</td>
						<td class="pn-fcontent">
							<input type="text" name="account.sys_id"
								value="${account.sys_id}" readonly="true"
								style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px" />
						</td>
						<td class="pn-flabel pn-flabel-h">
							序号：
						</td>
						<td class="pn-fcontent">
							<input type="text" name="vAccountTrade.seqNo"
								value="${list[0].seqNo}" readonly="true"
								style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px" />
						</td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">
							交易类型：
						</td>
						<c:if test="${list[0].tradeType==0}">
							<td class="pn-fcontent">
								<input type="text" name="vAccountTrade.tradeType" value="通行费扣费"
									readonly="true"
									style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px" />
							</td>
						</c:if>
						<c:if test="${list[0].tradeType==1}">
							<td class="pn-fcontent">
								<input type="text" name="vAccountTrade.tradeType" value="充值"
									readonly="true"
									style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px" />
							</td>
						</c:if>
						<c:if test="${list[0].tradeType==2}">
							<td class="pn-fcontent">
								<input type="text" name="vAccountTrade.tradeType" value="冲正"
									readonly="true"
									style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px" />
							</td>
						</c:if>
						<c:if test="${list[0].tradeType==3}">
							<td class="pn-fcontent">
								<input type="text" name="vAccountTrade.tradeType" value="销户"
									readonly="true"
									style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px" />
							</td>
						</c:if>
						<c:if test="${list[0].tradeType==4}">
							<td class="pn-fcontent">
								<input type="text" name="vAccountTrade.tradeType" value="开户"
									readonly="true"
									style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px" />
							</td>
						</c:if>
						<c:if test="${list[0].tradeType==5}">
							<td class="pn-fcontent">
								<input type="text" name="vAccountTrade.tradeType" value="其他"
									readonly="true"
									style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px" />
							</td>
						</c:if>

						<td class="pn-flabel pn-flabel-h">
							账号状态：
						</td>
						<c:if test="${account.status==0}">
							<td class="pn-fcontent">
								<input type="text" name="account.status" value="有效"
									readonly="true"
									style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px" />
							</td>
						</c:if>
						<c:if test="${account.status==1}">
							<td class="pn-fcontent">
								<input type="text" name="account.status" value="挂失"
									readonly="true"
									style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px" />
							</td>
						</c:if>
						<c:if test="${account.status==2}">
							<td class="pn-fcontent">
								<input type="text" name="account.status" value="预销户"
									readonly="true"
									style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px" />
							</td>
						</c:if>
						<c:if test="${account.status==3}">
							<td class="pn-fcontent">
								<input type="text" name="account.status" value="余额不足"
									readonly="true"
									style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px" />
							</td>
						</c:if>
						<c:if test="${account.status==4}">
							<td class="pn-fcontent">
								<input type="text" name="account.status" value="其他"
									readonly="true"
									style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px" />
							</td>
						</c:if>
						<c:if test="${account.status==5}">
							<td class="pn-fcontent">
								<input type="text" name="account.status" value="已销户"
									readonly="true"
									style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px" />
							</td>
						</c:if>
						<c:if test="${account.status==6}">
							<td class="pn-fcontent">
								<input type="text" name="account.status" value="余额过低"
									readonly="true"
									style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px" />
							</td>
						</c:if>
						<c:if test="${account.status==7}">
							<td class="pn-fcontent">
								<input type="text" name="account.status" value="黑名单"
									readonly="true"
									style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px" />
							</td>
						</c:if>
					</tr>
					<tr>


						<td class="pn-flabel pn-flabel-h">
							卡号：
						</td>
						<td class="pn-fcontent">
							<input type="text" name="vAccountTrade.cardNo"
								value="${list[0].cardNo}" readonly="true"
								style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px" />
						</td>
						<td class="pn-flabel pn-flabel-h">
							交易流水号：
						</td>
						<td class="pn-fcontent">
							<input type="text" name="vAccountTrade.listNo"
								value="${list[0].listNo}" size="27" readonly="true"
								style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px" />
						</td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">
							交易时间：
						</td>
						<td class="pn-fcontent">
							<input type="text" name="vAccountTrade.opTime"
								value="${list[0].opTime}" readonly="true"
								style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px" />
						</td>
						<td class="pn-flabel pn-flabel-h">
							车牌号：
						</td>
						<td class="pn-fcontent">
							<input type="text" name="vAccountTrade.vehPlate"
								value="${list[0].vehPlate}" readonly="true"
								style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px" />
						</td>

					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">
							金额（元）：
						</td>
						<td class="pn-fcontent">
							<input type="text" name="vAccountTrade.fee"
								value="<fmt:formatNumber value="${list[0].fee/100}" pattern="#.##" type="number"/>"
								readonly="true"
								style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px" />
						</td>
						<td class="pn-flabel pn-flabel-h">
							这条记录操作后的余额（元）：
						</td>
						<td class="pn-fcontent">
							<input type="text" name="vAccountTrade.balance"
								value="<fmt:formatNumber value="${list[0].balance/100}" pattern="#.##" type="number"/>"
								readonly="true"
								style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px" />
						</td>

					</tr>





					<tr>
						<td class="pn-flabel pn-flabel-h">
							账号当前的余额（元）：
						</td>
						<td  class="pn-fcontent">
							<input type="text" name="account.balance"
								value="<fmt:formatNumber value="${account.balance/100}" pattern="#.##" type="number"/>"
								readonly="true"
								style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px" />
						</td>
						<td class="pn-flabel pn-flabel-h">
							操作员编号：
						</td>
						<td  class="pn-fcontent">
							<input type="text" name="vAccountTrade.operatorID"
								value="${list[0].operatorID}"
								readonly="true"
								style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px" />
						</td>

					</tr>
					<tr>
					<td colspan="4" class="pn-fbutton"><input type="button" value=" 返 回 " onclick="history.back();"/>
					</td>
					</tr>






				</table>

			</form>
		</div>
	</body>
</html>
