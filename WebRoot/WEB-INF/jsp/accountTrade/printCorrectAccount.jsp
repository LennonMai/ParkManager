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
				alert("���ĳɹ�");
				if("${result}"=="FAIL")
				alert("�����Ϳ����д˿���");
				if("${result}"=="FAIL5")
				alert("�˼�¼�ѱ��������������ٳ���");
			 function doPrint() { 
                     window.open("accountTrade_printCorrect.do?account.sys_id=${account.sys_id}&accountTrade.seqNo=${accountTrade.seqNo}&account.balance=${account.balance}&accountTrade.fee=${accountTrade.fee}&accountTrade.balance=${accountTrade.balance}&opTime=${opTime}&accountTrade.backoutedListNo=${accountTrade.backoutedListNo}&accountTrade.tradeTime=${accountTrade.tradeTime}")
                    } 
				
		</script>
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">
					��ǰλ�ã� ${currentPosition}
				</div>
				<form class="ropt" method="post">
					<!--  <input type="button" value=" �� �� " onclick="history.back();" />-->
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
							<input type="text" value="������Ϣ��ִ "
								style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px" />
							&nbsp;
						</td>
					</tr>
				</table>
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1"
					border="0" >

					<tr>
						<td class="pn-flabel pn-flabel-h">
							�˺ţ�
						</td>
						<td class="pn-fcontent">
							<input type="text" name="account.sys_id"
								value="${account.sys_id}" readonly="true"
								style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px" />
						</td>

					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">
							�˺���ţ�
						</td>
						<td class="pn-fcontent">
							<input type="text" name="accountTrade.seqNo"
								value="${accountTrade.seqNo}" readonly="true"
								style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px" />
						</td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">
							����ǰ��Ԫ����
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
							������Ԫ����
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
							��������Ԫ����
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
							��������¼����ʱ�䣺
						</td>
						<td class="pn-fcontent">
							<input type="text" name="opTime" value="${opTime}"
								readonly="true"
								style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px" />
						</td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">
							��������¼������ˮ�ߣ�
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
							����ʱ�䣺
						</td>
						<td class="pn-fcontent">
							<input type="text" name="accountTrade.tradeTime"
								value="${accountTrade.tradeTime}" readonly="true"
								style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px" />
						</td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">
							����Ա&nbsp;&nbsp;��
						</td>
						<td class="pn-fcontent">
							<input type="text" value="${operator.name}" readonly="true"
								style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px" />
						</td>
					</tr>
					<tr>
						<td class="pn-fbutton"></td>
						<td class="pn-fcontent">
							<input type="button" value=" ��ӡ��ִ " onclick="doPrint();" />
						</td>


					</tr>
				</table>

			</form>
		</div>
	</body>
</html>
