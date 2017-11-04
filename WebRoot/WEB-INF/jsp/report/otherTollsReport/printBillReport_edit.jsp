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
		  	
			var ids="";
			function share() {
				ids = "";
				//判断是否有选择交易类型
			  	var a = 0;
			  	for(i=0;i<document.getElementsByName("tradeType").length;i++) {
			  		if(document.getElementsByName("tradeType")[i].checked==false) {
			  			a = a+1;
			  		}
			  	}
			  	var b = 2;
			  	if(a==b) {
			  		alert("请选择交易类型");
			  		return false;
			  	}
			  	
			  	//拼接选取的字符串值
			  	for(i=0;i<document.getElementsByName("tradeType").length;i++) {
			  		if(document.getElementsByName("tradeType")[i].checked==true) {
			  			ids=ids+document.getElementsByName("tradeType")[i].value+",";
			  		} else {
			  			//如果没选将值设为-1
			  			ids=ids+"-1"+",";
			  		}
			    }
			    //返回如0,1字符串
			    ids=ids.substring(0,ids.length-1);
			}
		  //生成HTML报表
		  function saveAndPrint(){
		  	share();
		    //计算相差天数
			var countDay = compTime(get("startTime").value, get("endTime").value);
			if(countDay > 10) {
				if(confirm("所选日期超过10天，采用HTML方式生成报表可能需要较长时间，是否采用PDF方式生成报表？")) {
				  	saveAndPrintPDF();
				  	return true;
			  	}
		  	} 
		  	if(checkTime() == false) {
			  	return false;
			} else {
			    window.open("otherTollsReport_printBillReport.do?startTime="+get("startTime").value+"&endTime="+get("endTime").value+"&tradeType="+ids);
		      	//window.open("otherTollsReport_printBillReport.do?startTime="+get("startTime").value+"&endTime="+get("endTime").value+"&tradeType="+ids,"","location=no,resizable=yes,scrollbars=yes,height=600,width=800,top=0,left=0");
		    }
		  }


		//生成当前页面HTML报表
		  function saveAndPrintCurrentPage(){
				share();
			    //计算相差天数
				var countDay = compTime(get("startTime").value, get("endTime").value);
				if(countDay > 10) {
					if(confirm("所选日期超过10天，采用HTML方式生成报表可能需要较长时间，是否采用PDF方式生成报表？")) {
					  	saveAndPrintPDF();
					  	return true;
				  	}
			  	} 
			  	if(checkTime() == false) {
				  	return false;
				} else {
					window.belowFrame.location.href="otherTollsReport_printBillReport.do?startTime="+get("startTime").value+"&endTime="+get("endTime").value+"&tradeType="+ids;
			      	//window.open("otherTollsReport_printBillReport.do?startTime="+get("startTime").value+"&endTime="+get("endTime").value+"&tradeType="+ids,"","location=no,resizable=yes,scrollbars=yes,height=600,width=800,top=0,left=0");
			    }
		  }
		  
		  //生成PDF报表
		  function saveAndPrintPDF() {
		  	share();
		  	if(checkTime() == false) {
			  	return false;
			} else {
		    	window.open("otherTollsReport_printBillReportPDF.do?startTime="+get("startTime").value+"&endTime="+get("endTime").value+"&tradeType="+ids);
		    }
		  }
		  //校验日期
		  function checkTime() {
		  	if(get("startTime").value == null || get("startTime").value == "" || get("endTime").value == null || get("endTime").value == "" ) {
		      	alert("统计时间不能为空");
		      	return false;
		    }
		    if(get("startTime").value > get("endTime").value) {
		      	alert("开始时间必须早于或等于结束时间");
		    	return false;
		    }
		  }
		  //计算日期差
		  function compTime(beginTime,endTime){
		  	var s1 = beginTime.replace(/-/g, "/");
			var s2 = endTime.replace(/-/g, "/");
			d1 = new Date(s1);
			d2 = new Date(s2);
			
			var time= d2.getTime() - d1.getTime();
			var days = parseInt(time / (1000 * 60 * 60 * 24));
			
			return days;
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
					<tr>
						<td width="40%" class="pn-flabel pn-flabel-h">统计时间范围：</td>
						<td width="60%" class="pn-fcontent">
						   <input type="text" name="startTime" class="Wdate" onClick="WdatePicker()"> - <input type="text" name="endTime" value="${endTime }"  class="Wdate" onClick="WdatePicker()">
						</td>
					</tr>
					<tr>
						<td width="40%" class="pn-flabel pn-flabel-h">交易类型：</td>
						<td width="60%" class="pn-fcontent">
						  <input type="checkbox" name="tradeType" value="0" checked="checked" />消费
						  <input type="checkbox" name="tradeType" value="1" checked="checked" />冲值
						  &nbsp;<font style="color:red">*</font>
						</td>
					</tr>
					<tr align="center">
						<td style="padding-top: 5px;padding-bottom: 5px;" colspan="2" class="pn-fcontent">
						  <input type="button" value="生成HTML报表" onclick="return saveAndPrint()">&nbsp;
						  <input type="button" value="生成PDF报表" onclick="return saveAndPrintPDF()">&nbsp;
						  <input type="button" value="&nbsp;查&nbsp;&nbsp;询&nbsp;" onclick="return saveAndPrintCurrentPage()">
						</td>
					</tr>
				</table>
			</div>
			<iframe id="iframe" frameborder="0" src="" name="belowFrame" scrolling="auto"  width="100%">
			</iframe>
		</div>
	</body>
</html>