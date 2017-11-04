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
		<title>修改时间标志信息</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<%@include file="../../include/common.jsp" %>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<!-- 引入jsonrpc.js -->
		<script type="text/javascript" src="${basePath}/js/jsonrpc.js"></script>
		<script type="text/javascript">
		
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
			<form id="dataform" method="post" action="zjuPriceConfig_updateTimesSignDef.do" >
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<tr>
						<td class="pn-flabel pn-flabel-h">收费类型：</td>
						<input readonly="readonly" type="hidden"  name="timesSignDef.feeRuleType" value="${timesSignDef.feeRuleType}" size="24"/>
						<td style="width: 430px;" class="pn-fcontent" id="_name"></td>
						 <script language="javascript">			    
	                             //构造列，根据收费类型取得车辆类别名写进列中
	                             var feeRuleType=${timesSignDef.feeRuleType};
	                             jsonrpc = new JSONRpcClient("JSON-RPC");//JSON-RPC 对应web.xml里面的URL
	                             var _name = jsonrpc.ajax.get_Name(feeRuleType);                          	 
	                           	 document.getElementById("_name").innerHTML=_name;
                         </script>
						<td class="pn-flabel pn-flabel-h">日类型：</td>
						<td style="width: 430px;" class="pn-fcontent"><c:if test="${timesSignDef.dayType==1}">正常工作日</c:if><input readonly="readonly" type="hidden" class="required isNo_NotOverValueInt" name="timesSignDef.dayType" value="${timesSignDef.dayType}" size="24"/></td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">开始时间：</td>
						<td class="pn-fcontent">${timesSignDef.startTime }<input readonly="readonly" size="24"  type="hidden" name="timesSignDef.startTime" value="${timesSignDef.startTime }" /></td>
				     	<td class="pn-flabel pn-flabel-h">时间标志：</td>
						<td  class="pn-fcontent">
						<c:if test="${timesSignDef.timesSign==0}">白天费率</c:if>
						<c:if test="${timesSignDef.timesSign==1}">夜间费率</c:if>
						<input type="hidden" class="required isNo_NotOverValueInt" name="timesSignDef.timesSign" value="${timesSignDef.timesSign}" size="24"/></td>
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
	</body>
</html>