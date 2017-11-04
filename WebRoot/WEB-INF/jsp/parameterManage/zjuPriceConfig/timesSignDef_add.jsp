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
		<title>添加时间标志信息</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<%@include file="../../include/common.jsp" %>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<!-- 引入jsonrpc.js -->
		<script type="text/javascript" src="${basePath}/js/jsonrpc.js"></script>
		<script type="text/javascript">
		if("${message}"=="hasTimesSignDef"){
			alert("已存在该时间标志信息！");
		    }
		function back(){
			window.location.href = "zjuPriceConfig_timesSignDef_list.do";
			}

		</script>

	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="zjuPriceConfig_saveTimesSignDef.do" >
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<tr>
						<td class="pn-flabel pn-flabel-h">收费类型：</td>
						<td class="pn-fcontent"><!--<input type="text" class="required isNo_NotOverValueInt" name="timesSignDef.feeRuleType" value="${timesSignDef.feeRuleType}" size="24"/><span style="color: red">&nbsp;*</span>
						--><select class="required " id="timesSignDef_feeRuleType" name="timesSignDef.feeRuleType" style="width: 180px;height: 22px;">
						</select><span style="color: red">&nbsp;*</span></td>
						<td class="pn-flabel pn-flabel-h">日类型：</td>
						<td class="pn-fcontent">
						<select class="required " id="timesSignDef.dayType" name="timesSignDef.dayType" style="width: 180px;height: 22px;">
						<option value="1">正常工作日</option>
						</select><span style="color: red">&nbsp;*</span></td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">开始时间：</td>
						<td class="pn-fcontent"><input  size="24" class="required maxlength8" type="text" name="timesSignDef.startTime" value="${timesSignDef.startTime }"  class="Wdate" onclick="WdatePicker({dateFmt:'HH:mm:ss'})" readonly="readonly"/><span style="color: red">&nbsp;*</span></td>
				     	<td class="pn-flabel pn-flabel-h">时间标志：</td>
						<td  class="pn-fcontent">
						<!--<input type="text" class="required isNo_NotOverValueInt" name="timesSignDef.timesSign" value="${timesSignDef.timesSign}" size="24"/>
						-->
						<select name="timesSignDef.timesSign" class="required" style="width: 180px;height: 22px;">
						    <option value="">- 请选择 -</option>
							<option value="0">白天费率</option>
							<option value="1">夜间费率</option>
						</select>
						<span style="color: red">&nbsp;*</span></td>
						</tr>
					<tr>
					    <td class="pn-flabel pn-flabel-h">结束时间：</td>
						<td colspan="3" class="pn-fcontent"><input  size="24"  class="required maxlength8" type="text" name="timesSignDef.endTime" value="${timesSignDef.endTime }"  class="Wdate" onclick="WdatePicker({dateFmt:'HH:mm:ss'})" readonly="readonly"/><span style="color: red">&nbsp;*</span></td>
				    </tr>
					<tr>
					    <td  class="pn-flabel pn-flabel-h">备&nbsp;&nbsp;注：</td>
						<td  colspan="3" class="pn-fcontent">
						<textarea class="maxlength50 " name="timesSignDef.remark" rows="3" cols="52">${timesSignDef.remark}</textarea></td>
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
		document.getElementById("timesSignDef_feeRuleType").options.add(option);
	}
</script>
	</body>
</html>