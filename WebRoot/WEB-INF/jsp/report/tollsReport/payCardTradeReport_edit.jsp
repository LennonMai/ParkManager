<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
				ids="";
				//判断是否有选择交易类型
			  	var a = 0;
			  	for(i=0;i<document.getElementsByName("tradeType").length;i++) {
			  		if(document.getElementsByName("tradeType")[i].checked==false) {
			  			a = a+1;
			  		}
			  	}
			  	var b = 5;
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
			    //返回如0,1,2字符串
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
		  	if(check() == false) {
			  	return false;
			} else {
			    window.open("tollsReport_payCardTradeReport.do?startTime="+get("startTime").value+"&endTime="+get("endTime").value+"&tradeType="+ids
			    	+"&account.cardNo="+get("account.cardNo").value+"&account.status="+get("account.status").value
		    		+"&car.vehPlate="+get("car.vehPlate").value+"&user.credentialsNo="+get("user.credentialsNo").value
		    		+"&user.userName="+get("user.userName").value+"&account.sys_id="+get("account.sys_id").value);
		      	//window.open("tollsReport_payCardTradeReport.do?startTime="+get("startTime").value+"&endTime="+get("endTime").value+"&tradeType="+ids,"","location=no,resizable=yes,scrollbars=yes,height=600,width=800,top=0,left=0");
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
			  	if(check() == false) {
				  	return false;
				} else {
					window.belowFrame.location.href="tollsReport_payCardTradeReport.do?startTime="+get("startTime").value+"&endTime="+get("endTime").value+"&tradeType="+ids
				    	+"&account.cardNo="+get("account.cardNo").value+"&account.status="+get("account.status").value
			    		+"&car.vehPlate="+get("car.vehPlate").value+"&user.credentialsNo="+get("user.credentialsNo").value
			    		+"&user.userName="+get("user.userName").value+"&account.sys_id="+get("account.sys_id").value;
			    }
		  }

		  
		  //生成PDF报表
		  function saveAndPrintPDF() {
		  	share();
		  	if(check() == false) {
			  	return false;
			} else {
		    	window.open("tollsReport_payCardTradeReportPDF.do?startTime="+get("startTime").value+"&endTime="+get("endTime").value+"&tradeType="+ids
		    		+"&account.cardNo="+get("account.cardNo").value+"&account.status="+get("account.status").value
		    		+"&car.vehPlate="+get("car.vehPlate").value+"&user.credentialsNo="+get("user.credentialsNo").value
		    		+"&user.userName="+get("user.userName").value+"&account.sys_id="+get("account.sys_id").value);
		    }
		  }
		  //校验
		  function check() {
		  	//校验日期
		  	if(get("startTime").value == null || get("startTime").value == "" || get("endTime").value == null || get("endTime").value == "" ) {
		      	alert("统计时间不能为空");
		      	return false;
		    }
		    if(get("startTime").value > get("endTime").value) {
		      	alert("开始时间必须早于或等于结束时间");
		    	return false;
		    }
		    //对用户账号的验证
			if(get("account.sys_id").value != "") {
				var phone =/^\d+$/;
				var temp = document.getElementsByName("account.sys_id")[0];
				if(!phone.test(temp.value)) {
			    	alert("用户账户为数字，请输入有效的用户账号");
			        get("account.sys_id").focus();
			        return false;
		        }
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
			
			//alert("相差天数: " + days);   
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
						<td width="20%" class="pn-flabel pn-flabel-h">统计时间范围：</td>
						<td style="white-space:nowrap;" width="30%" class="pn-fcontent">
							 <input type="text" name="startTime" class="Wdate" onClick="WdatePicker()"> - <input type="text" name="endTime" value="${endTime }"  class="Wdate" onClick="WdatePicker()">
						</td>
						<td width="20%" class="pn-flabel pn-flabel-h">卡&nbsp;&nbsp;号：</td>
						<td width="30%" class="pn-fcontent">
							<input type="text" name="account.cardNo" value="${account.cardNo}" />
						</td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">交易类型：</td>
						<td width="30%" class="pn-fcontent">
							<input type="checkbox" name="tradeType" value="0" checked="checked" />消费
							<input type="checkbox" name="tradeType" value="1" checked="checked" />冲值
							<input type="checkbox" name="tradeType" value="2" checked="checked" />冲正
							<input type="checkbox" name="tradeType" value="3" checked="checked" />销户
							<input type="checkbox" name="tradeType" value="4" checked="checked" />其他
							&nbsp;<font style="color:red">*</font>
						</td>
						<td width="20%" class="pn-flabel pn-flabel-h">车牌号：</td>
						<td width="30%" class="pn-fcontent">
							<input type="text" name="car.vehPlate" value="${car.vehPlate}"/>
						</td>
					</tr>
					<tr>
						<c:if test="${sysparamconf2.pvalue!=1}">
						<td width="20%" class="pn-flabel pn-flabel-h">账户状态：</td>
						<td width="30%" class="pn-fcontent">
							<select name="account.status" style="width:150px">
								<option value="" <c:if test="${account.status==null}">selected</c:if>>请选择</option>
							    <option value="0" <c:if test="${account.status==0}">selected</c:if>>有效</option>
								<option value="1" <c:if test="${account.status==1}">selected</c:if>>挂失 </option>
								<option value="2" <c:if test="${account.status==2}">selected</c:if>>预销户</option>
							    <option value="3" <c:if test="${account.status==3}">selected</c:if>>余额不足</option>
								<option value="5" <c:if test="${account.status==5}">selected</c:if>>已销户</option>
							    <option value="6" <c:if test="${account.status==6}">selected</c:if>>余额过低</option>
								<option value="7" <c:if test="${account.status==7}">selected</c:if>>黑名单</option>
								<option value="4" <c:if test="${account.status==4}">selected</c:if>>其他 </option>
							</select>
						</td>
						</c:if>
						<c:if test="${sysparamconf2.pvalue==1}">
						<td width="20%" class="pn-flabel pn-flabel-h">账户状态：</td>
						<td width="30%" class="pn-fcontent">
							<select name="account.status" style="width:150px">
								<option value="" <c:if test="${account.status==null}">selected</c:if>>请选择</option>
							    <option value="0" <c:if test="${account.status==0}">selected</c:if>>有效</option>
								<option value="1" <c:if test="${account.status==1}">selected</c:if>>挂失 </option>
								<option value="2" <c:if test="${account.status==2}">selected</c:if>>预销户</option>							  
								<option value="5" <c:if test="${account.status==5}">selected</c:if>>已销户</option>							
								<option value="7" <c:if test="${account.status==7}">selected</c:if>>黑名单</option>
								<option value="4" <c:if test="${account.status==4}">selected</c:if>>其他 </option>
							</select>
						</td>
						</c:if>
						<td width="20%" class="pn-flabel pn-flabel-h">证件号码：</td>
						<td width="30%" class="pn-fcontent">
							<input type="text" name="user.credentialsNo" value="${user.credentialsNo}"/>
						</td>
					</tr>
					
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">用&nbsp;户&nbsp;名：</td>
						<td width="30%" class="pn-fcontent">
							<input type="text" name="user.userName" value="${user.userName}"/>
						</td>	
						<td width="20%" class="pn-flabel pn-flabel-h">用户账号：</td>
						<td width="30%" class="pn-fcontent">
							<input type="text" name="account.sys_id" value="${account.sys_id}" />
						</td>
					</tr>
					<tr align="center">
						<td style="padding-top: 5px;padding-bottom: 5px;" colspan="4" class="pn-fcontent">
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