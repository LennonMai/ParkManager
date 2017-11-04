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
<script type="text/javascript">
	function doPrint() {
		bdhtml = window.document.body.innerHTML;
		sprnstr = "<!--startprint-->";
		eprnstr = "<!--endprint-->";
		prnhtml = bdhtml.substr(bdhtml.indexOf(sprnstr) + 17);
		prnhtml = prnhtml.substring(0, prnhtml.indexOf(eprnstr));
		window.document.body.innerHTML = prnhtml;
		window.print();
	}
/* 	function returnBack() {
		window.location = "parkCard_queryParkCardToManage.do";
	} */
</script>
<style>
.tb_print {
	border-top: black 1px solid;
	border-left: black 1px solid;
	font-size: 12px;
}

.tb_print tr td {
	border-bottom: black 1px solid;
	border-right: black 1px solid;
	height: 30px;
}

.tb_print tr th {
	border-bottom: black 1px solid;
	border-right: black 1px solid;
	height: 30px;
}
</style>
</head>
<body>
	<table width="100%" class="pn-ftable" cellpadding="3" cellspacing="3" border="0">
		<tr>
			<td class="pn-fcontent" align="center">
				<!-- <input type="button" value="返回" onclick="returnBack();"></input> -->
				<input name="b_print" type="button" class="ipt" onclick="doPrint();" value="打印" />
			</td>
		</tr>
	</table>
	<div style="margin: auto; width: 710px; margin-top: 30px;">
		<!--startprint-->
		<div id="div_print">
			<div style="margin: auto;">
				<p style="margin: auto; display: block; text-align: center; line-height: 30px; font-size: 20px">校园卡</p>
			</div>
			<div>
				<table id="tb_p" class="tb_print" width="100%" cellspacing="0" cellpadding="0">
					<thead>
						<tr>
							<th>车主姓名</th>
							<th>卡表面号</th>
							<th>车 牌 号</th>
							<th>用户类型</th>
							<th>有效日期</th>
							<th>操作员</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${list}" var="item">
							<tr align="center">
								<td>${item.Owner}</td>
								<td>${item.CardNo}</td>
								<td>${item.Vehplate}</td>
								<td>
									<c:forEach items="${userCardTypeList}" var="itemlistUserCardType">
										<c:if test="${item.userCardType==itemlistUserCardType.userCardType}">${itemlistUserCardType.typeName}</c:if>
									</c:forEach>
								</td>
								<td>
									<c:if test="${item.PayEndTime==null}">&nbsp;&nbsp;</c:if> 
									<c:if test="${item.PayEndTime!=null }">${item.PayEndTime}</c:if>
								</td>
								<td>${session.operator.name}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div style="margin: auto;">
				<br></br>
				<p style="margin: auto; display: block; text-align: right; line-height: 10px; font-size: 15px">
					<script language="JavaScript" type="text/javascript">
						today = new Date();
						var date;
						date = (today.getFullYear()) + "年" + (today.getMonth() + 1 ) + "月" + today.getDate() + "日" + " " + today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds() + "&nbsp;&nbsp;";
						document.write(date);
					</script>
				</p>
			</div>
		</div>
		<!--endprint-->
	</div>
</body>
</html>
