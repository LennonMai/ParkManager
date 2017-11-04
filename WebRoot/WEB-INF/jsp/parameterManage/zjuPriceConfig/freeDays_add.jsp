<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 使用JavaBean 引入jsonrpc.jar -->
<jsp:useBean id="JSONRPCBridge" scope="session" class="com.metaparadigm.jsonrpc.JSONRPCBridge"/>
<jsp:useBean id="ajax" class="com.hgsoft.util.AjaxBean"></jsp:useBean>
<%
	JSONRPCBridge.registerObject("ajax",ajax);
%>
<html>
	<head>
		<title>添加免费日期</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<%@include file="../../include/common.jsp" %>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<!-- 引入jsonrpc.js -->
		<script type="text/javascript" src="${basePath}/js/jsonrpc.js"></script>
		<script type="text/javascript">
		if("${message}"=="hasFreeDays"){
			alert("已存在该免费日期！");
		    }
		
		function back(){
			window.location.href = "zjuPriceConfig_freeDays_list.do";
		}
		function toChange(obj){
			if(obj.value==""){
				document.getElementById('freeWeek').style.display = "none";
				document.getElementById('freeDay').style.display = "none";
			}
			if(obj.value==0){
				document.getElementById('freeWeek').style.display = "inline";
				document.getElementById('freeDay').style.display = "none";
			}
			if(obj.value==1){
				document.getElementById('freeWeek').style.display = "none";
				document.getElementById('freeDay').style.display = "inline";
			}
		}
		function check(){
			if(document.getElementById('freeDays_type').value==1){
				if(document.getElementById('freeDays.value').value==""){
					alert("免费日期不能为空");
					return false;
				}
			}
			return true;
		}
		</script>

	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="zjuPriceConfig_saveFreeDays.do" onsubmit="return check()">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<tr>
						<td class="pn-flabel pn-flabel-h">收费类型：</td>
						<td class="pn-fcontent"><!--<input size="25" type="text" class="required isNo_NotOverValueInt" name="freeDays.feeRuleType" value="${freeDays.feeRuleType}" size="24"/>
						--><select class="required " id="freeDays_feeRuleType" name="freeDays.feeRuleType" style="width: 185px;height: 22px;">
						</select><span style="color: red">&nbsp;*</span></td>
						<td class="pn-flabel pn-flabel-h">类型：</td>
						<td class="pn-fcontent">
						<select style="width: 185px;height: 22px;" id="freeDays_type" name="freeDays.type" class="required " onchange="toChange(this);">
							<option value="">- 请选择 -</option>
							<option value="0">0 -星期</option>
							<option value="1">1 -日（Date）</option>		
						</select><span style="color: red">&nbsp;*</span></td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">免费日期：</td>
						<td colspan="4" class="pn-fcontent">
							<select id="freeWeek" name="freeWeek" style="display: none;width: 185px;height: 22px;">
								<option value="1" selected="selected">  星期一</option>
								<option value="2">  星期二</option>
								<option value="3">  星期三</option>
								<option value="4">  星期四</option>
								<option value="5">  星期五</option>
								<option value="6">  星期六</option>
								<option value="7">  星期日</option>
							</select>
							<input type="text" id="freeDay" name="freeDays.value" value="${freeDays.value}" size="25" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="display: none;" readonly="readonly"/>
						</td>
					</tr>
					<tr>
						<td colspan="4" class="pn-fbutton">
							<input type="submit" value=" 保 存 "/>&nbsp;
						    <input type="reset" value=" 重 置 "/>&nbsp;
						    <input type="button" value=" 返 回 " onclick="return back()"/>
						</td>
						    
					</tr>
				</table>
			</form>
		</div>
<script language="javascript">
	//构造收费类型下拉列表
	jsonrpc = new JSONRpcClient("JSON-RPC");//JSON-RPC 对应web.xml里面的URL
	
	var result = jsonrpc.ajax.getFeeRuleType_Name();
	for (var i=0;i<result.length;i++){
		option =document.createElement("OPTION");
		option.value = result[i][0];
		option.text = result[i][1];
		document.getElementById("freeDays_feeRuleType").options.add(option);
	}
</script>
	</body>
</html>