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
		<script type="text/javascript" src="${basePath}/js/jquery.js"></script>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<script type="text/javascript">
			//打印
			function doPrint() {
				// 获得body的html
				bdhtml=window.document.body.innerHTML;
				// 打印开始的标志
				sprnstr="<!--startprint-->";
				// 打印结束的标志
				eprnstr="<!--endprint-->";
				// 从打印开始的位置截取到末尾
				prnhtml=bdhtml.substr(bdhtml.indexOf(sprnstr)+17);
				// 从开始截取到打印结束的位置
				prnhtml=prnhtml.substring(0,prnhtml.indexOf(eprnstr));
				// 替换html
				window.document.body.innerHTML=prnhtml;
				// 打印
				window.print();
			}
		</script>
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form name="tableForm" method="post" action="generateSum_queryGateSum.do" >
				
			<!-- ${fn:length(list)} 显示list长度-->
			<!--startprint-->
			<div align="center"><font size="5">大门总合计数</font></div>
			<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th>区&nbsp;&nbsp;域</th>
						<th>小&nbsp;&nbsp;区</th>
						<th>大&nbsp;&nbsp;门</th>
						<th>工班日期</th>
						<th>记录数</th>
						<th>通行费</th>
						<th>是否合计</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
							<td>${item.AreaName }</td>
							<td>${item.ParkName }</td>
							<td>${item.GateName }</td>
							<td>${item.SquadDate}</td>
							<td>${item.RecordCnt }</td>
							<td>${item.MoneySummation }</td>
							<td>${item.StationYNSum }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<!--endprint-->
				<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input type="button" value=" 返 回 " onclick="history.back();"/>&nbsp;
						<input type="button" value=" 打 印 " onclick="doPrint();"/>
						</td>
					</tr>
				</table>
			<!--<jsp:include page="../../../include/pager.jsp"/>-->
			</form>
		</div>
	</body>
</html>