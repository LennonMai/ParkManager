<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
	<head>
		<title></title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/dtree.css"/>
		<script type="text/javascript" src="${basePath}/js/jquery.js"></script>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<script type="text/javascript">
		  window.onload = function() {
		  	  var ifr_height = $(window).height() - $("#div1").height() - $("#div2").height() - 30;
		  	  var iframe = $("#iframe").height(ifr_height);
		  }
		  function changeSize() {
		  	  var ifr_height = $(window).height() - $("#div1").height() - $("#div2").height() - 30;
		  	  var iframe = $("#iframe").height(ifr_height);
		  }
		  
		  //生成HTML报表
		  function saveAndPrint() {
			    window.open("cardInfoReport_cardDynamicReport.do");
		  }
		  //生成当前HTML报表
		  function saveAndPrintCurrentPage() {
			  window.belowFrame.location.href="cardInfoReport_cardDynamicReport.do";
		  }
		  //生成PDF报表
		  function saveAndPrintPDF(){
		    	window.open("cardInfoReport_cardDynamicReportPDF.do");
		  }
		</script>
	</head>
	<body onResize="changeSize()">
		<div class="body-box">
			<div id="div1" class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<div id="div2">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<tr align="center">
						<td style="padding-top: 5px;padding-bottom: 5px;"  colspan="2" class="pn-fcontent">
						  <input type="button" value="生成HTML报表" onclick="return saveAndPrint()">&nbsp;
						  <input type="button" value="生成PDF报表" onclick="return saveAndPrintPDF()">&nbsp;
						  <input type="button" value="&nbsp;查&nbsp;&nbsp;询&nbsp;" onclick="return saveAndPrintCurrentPage()">
					</td>
					</tr>
				</table>
			</div>
			<iframe id="iframe" frameborder="0" src="" name="belowFrame" scrolling="auto"  width="100%" style="height: 500px">
			</iframe>
		</div>
	</body>
</html>