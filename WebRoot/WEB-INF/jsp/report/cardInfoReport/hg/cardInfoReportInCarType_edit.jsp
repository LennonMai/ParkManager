<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
	<head>
		<title></title>
		<%@include file="../../../include/common.jsp" %>
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
		  /*
		  //生成HTML报表
		  function saveAndPrint() {
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
				var carType = document.getElementById("carType").value;
				var parkingSpace = document.getElementById("parkingSpace").value;
				var startTime = get("startTime").value;
				var endTime = get("endTime").value;
			    window.open("cardInfoReport_cardInfoReportInCarType.do?startTime="
						+startTime+"&endTime="+endTime+"&param_parkReport.pvalue=${param_parkReport.pvalue}"
						+"&carType="+carType+"&parkingSpace="+parkingSpace);
		    }
		  }
		*/
		
		/**生成HTML报表
		  *	flag ：0表示在当前页生成html报表,1表示打开新的窗口
		*/
		  function saveAndPrint(flag){
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
					var carType = document.getElementById("carType").value;
					var parkingSpace = document.getElementById("parkingSpace").value;
					var startTime = get("startTime").value;
					var endTime = get("endTime").value;
					var url = "cardInfoReport_cardInfoReportInCarType.do?startTime="
						+startTime+"&endTime="+endTime+"&param_parkReport.pvalue=${param_parkReport.pvalue}"
						+"&carType="+carType+"&parkingSpace="+parkingSpace;
					if(flag=='0'){
						window.belowFrame.location.href=url;
					}else{
						 window.open(url);
					}
			    }
		  }
		  
		  //生成PDF报表
		  function saveAndPrintPDF(){
		  	if(checkTime() == false) {
			  	return false;
			} else {
				var carType = document.getElementById("carType").value;
				var parkingSpace = document.getElementById("parkingSpace").value;
				var startTime = get("startTime").value;
				var endTime = get("endTime").value;
		    	window.open("cardInfoReport_cardInfoReportInCarTypePDF.do?startTime="+startTime+
		    			"&endTime="+endTime+"&param_parkReport.pvalue=${param_parkReport.pvalue}"+
		    			"&carType="+carType+"&parkingSpace="+parkingSpace
		    			);
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
		  
		  function getCarSmallType(){
				var carType = document.getElementsByName("carType")[0].value; 
				$.ajax({
					type:"post",
					url:"cardInfoReport_findCarSmallType.do?carType="+carType,
					success:function(res){
						$("#parkingSpace").empty();
						var op = $("<option value=''>请选择</option>");		
						$("#parkingSpace").append(op);
						$(res).find("CarSmallTypes > CarSmallType").each(function(){
							var o = $("<option value="+$(this).attr("id") +">"
									+$(this).attr("name")+"</option>");
							$("#parkingSpace").append(o);
						});
					}
				});
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
						<td width="20%" class="pn-flabel pn-flabel-h" >统计时间范围：</td>
						<td width="60%" class="pn-fcontent" colspan="3">
						  <input type="text" name="startTime" class="Wdate" onClick="WdatePicker()"> - <input type="text" name="endTime" value="${endTime }" class="Wdate" onClick="WdatePicker()">
						  &nbsp;<font style="color:red">*</font>
						</td>
					</tr>
					
					<tr>						
						<td class="pn-flabel pn-flabel-h">车辆类型：</td>
						<td class="pn-fcontent">
							<select name="carType" id="carType" style="width:150px" onchange="getCarSmallType()">
								<option value="" <c:if test="${carType==null}">selected</c:if>>请选择</option>
							    <c:forEach items="${listCarType}" var="item">
									<option value="${item.carType}" <c:if test="${carType==item.carType}">selected</c:if>>${item.carTypeName}</option>
								</c:forEach>  
						</select>
						</td>
						 <td class="pn-flabel pn-flabel-h">停&nbsp;车&nbsp;位：</td>
					   	 <td class="pn-fcontent">
							<select name="parkingSpace" id="parkingSpace" style="width:150px" >
								<option value=""  <c:if test="${parkingSpace==null}">selected</c:if>>请选择</option>
							</select>
						</td>
					</tr>
					
					<tr align="center">
						<td style="padding-top: 5px;padding-bottom: 5px;"  colspan="4" class="pn-fcontent">
						  <input type="button" value="生成HTML报表" onclick="return saveAndPrint('1')">&nbsp;
						  <input type="button" value="生成PDF报表" onclick="return saveAndPrintPDF()">&nbsp;
						  <input type="button" value="&nbsp;查&nbsp;&nbsp;询&nbsp;" onclick="return saveAndPrint('0')">
					</td>
					</tr>
				</table>
			</div>
			<iframe id="iframe" frameborder="0" src="" name="belowFrame" scrolling="auto"  width="100%" style="height: 500px">
			</iframe>
		</div>
	</body>
</html>