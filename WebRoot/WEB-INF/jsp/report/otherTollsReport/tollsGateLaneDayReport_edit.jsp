<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
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
		  function saveAndPrint(){
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
			     window.open("otherTollsReport_tollsGateLaneDayReport.do?startTime="+get("startTime").value+"&endTime="+get("endTime").value);
		      	//window.open("otherTollsReport_tollsTradeDayReport.do?startTime="+get("startTime").value+"&endTime="+get("endTime").value,"","location=no,resizable=yes,scrollbars=yes,height=600,width=800,top=0,left=0");
		    }
		  }

		  //生成当前页面HTML报表
		  function saveAndPrintCurrentPage(){
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
				     window.belowFrame.location.href="otherTollsReport_tollsGateLaneDayReport.do?startTime="+get("startTime").value+"&endTime="+get("endTime").value;
			      	//window.open("otherTollsReport_tollsTradeDayReport.do?startTime="+get("startTime").value+"&endTime="+get("endTime").value,"","location=no,resizable=yes,scrollbars=yes,height=600,width=800,top=0,left=0");
			    }
		  }
		  
		  //生成PDF报表
		  function saveAndPrintPDF() {
		  	if(checkTime() == false) {
			  	return false;
			} else {
		    	window.open("otherTollsReport_tollsGateLaneDayReportPDF.do?startTime="+get("startTime").value+"&endTime="+get("endTime").value);
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
		  function compTime(beginTime,endTime) {
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
						<td style="padding-top: 5px;padding-bottom: 5px;" width="40%" class="pn-flabel pn-flabel-h">统计时间范围：</td>
						<td style="padding-top: 5px;padding-bottom: 5px;" width="60%" class="pn-fcontent">
						  <input type="text" name="startTime" class="Wdate" onClick="WdatePicker()"> - <input type="text" name="endTime" value="${endTime }" class="Wdate" onClick="WdatePicker()">
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