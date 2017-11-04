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
		<script type="text/javascript">
			if("${result}"=="SUCCESS")
				alert("更改成功");
				if("${result}"=="FAIL")
				alert("此类型卡已有此卡号");
				if("${result}"=="FAIL5")
				alert("此记录已被冲正过，不能再冲正");
			 function doPrint() { 
                     window.open("accountTrade_printCorrect.do?account.sys_id=${account.sys_id}&accountTrade.seqNo=${accountTrade.seqNo}&account.balance=${account.balance}&accountTrade.fee=${accountTrade.fee}&accountTrade.balance=${accountTrade.balance}&opTime=${opTime}&accountTrade.backoutedListNo=${accountTrade.backoutedListNo}&accountTrade.tradeTime=${accountTrade.tradeTime}")
                    } 
				
		</script>
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">
					当前位置： ${currentPosition}
				</div>
				<form class="ropt" method="post">
					<!--  <input type="button" value=" 返 回 " onclick="history.back();" />-->
					<input style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/>
				</form>
				<div class="clear"></div>
			</div>
			<form method="post" action="">
				<!--  <form method="post" action="car_save.do" onsubmit="return check();">-->
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1"
					border="0"  style="background-color: #FFFFFF;">
					<tr>
						<td colspan="4" class="pn-fbutton">
							<input type="text" value="冲正信息回执 "
								style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px" />
							&nbsp;
						</td>
					</tr>
				</table>
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

					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">
							账号序号：
						</td>
						<td class="pn-fcontent">
							<input type="text" name="accountTrade.seqNo"
								value="${accountTrade.seqNo}" readonly="true"
								style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px" />
						</td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">
							冲正前余额（元）：
						</td>
						<td class="pn-fcontent">
							<input type="text" name="account.balance"
								value="<fmt:formatNumber value="${account.balance/100}" pattern="#.##" type="number"/>"
								readonly="true"
								style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px" />
						</td>
					</tr>

					<tr>
						<td class="pn-flabel pn-flabel-h">
							冲正金额（元）：
						</td>
						<td class="pn-fcontent">
							<input type="text" name="accountTrade.fee"
								value="<fmt:formatNumber value="${accountTrade.fee/100}" pattern="#.##" type="number"/>"
								readonly="true"
								style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px" />
						</td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">
							冲正后余额（元）：
						</td>
						<td class="pn-fcontent">
							<input type="text" name="accountTrade.balance"
								value="<fmt:formatNumber value="${accountTrade.balance/100}" pattern="#.##" type="number"/>"
								readonly="true"
								style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px" />
						</td>
					</tr>

					<tr>
						<td class="pn-flabel pn-flabel-h">
							被冲正记录交易时间：
						</td>
						<td class="pn-fcontent">
							<input type="text" name="opTime" value="${opTime}"
								readonly="true"
								style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px" />
						</td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">
							被冲正记录交易流水线：
						</td>
						<td class="pn-fcontent">
							<input type="text" name="accountTrade.backoutedListNo"
								value="${accountTrade.backoutedListNo}" size="30"
								readonly="true"
								style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px" />
						</td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">
							冲正时间：
						</td>
						<td class="pn-fcontent">
							<input type="text" name="accountTrade.tradeTime"
								value="${accountTrade.tradeTime}" readonly="true"
								style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px" />
						</td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">
							操作员&nbsp;&nbsp;：
						</td>
						<td class="pn-fcontent">
							<input type="text" value="${operator.name}" readonly="true"
								style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px" />
						</td>
					</tr>
					<tr>
						<td class="pn-fbutton"></td>
						<td class="pn-fcontent">
							<input type="button" value=" 打印回执 " onclick="doPrint();" />
						</td>


					</tr>
				</table>

			</form>
		</div>
	</body>
</html>
