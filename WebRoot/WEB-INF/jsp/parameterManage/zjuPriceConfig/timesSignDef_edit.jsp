<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- ʹ��JavaBean ����jsonrpc.jar -->
<jsp:useBean id="JSONRPCBridge" scope="session" class="com.metaparadigm.jsonrpc.JSONRPCBridge"/>
<jsp:useBean id="ajax" class="com.hgsoft.util.AjaxBean"></jsp:useBean>
<%
	JSONRPCBridge.registerObject("ajax",ajax);
%>
<html>
	<head>
		<title>�޸�ʱ���־��Ϣ</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<%@include file="../../include/common.jsp" %>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<!-- ����jsonrpc.js -->
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
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="zjuPriceConfig_updateTimesSignDef.do" >
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<tr>
						<td class="pn-flabel pn-flabel-h">�շ����ͣ�</td>
						<input readonly="readonly" type="hidden"  name="timesSignDef.feeRuleType" value="${timesSignDef.feeRuleType}" size="24"/>
						<td style="width: 430px;" class="pn-fcontent" id="_name"></td>
						 <script language="javascript">			    
	                             //�����У������շ�����ȡ�ó��������д������
	                             var feeRuleType=${timesSignDef.feeRuleType};
	                             jsonrpc = new JSONRpcClient("JSON-RPC");//JSON-RPC ��Ӧweb.xml�����URL
	                             var _name = jsonrpc.ajax.get_Name(feeRuleType);                          	 
	                           	 document.getElementById("_name").innerHTML=_name;
                         </script>
						<td class="pn-flabel pn-flabel-h">�����ͣ�</td>
						<td style="width: 430px;" class="pn-fcontent"><c:if test="${timesSignDef.dayType==1}">����������</c:if><input readonly="readonly" type="hidden" class="required isNo_NotOverValueInt" name="timesSignDef.dayType" value="${timesSignDef.dayType}" size="24"/></td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">��ʼʱ�䣺</td>
						<td class="pn-fcontent">${timesSignDef.startTime }<input readonly="readonly" size="24"  type="hidden" name="timesSignDef.startTime" value="${timesSignDef.startTime }" /></td>
				     	<td class="pn-flabel pn-flabel-h">ʱ���־��</td>
						<td  class="pn-fcontent">
						<c:if test="${timesSignDef.timesSign==0}">�������</c:if>
						<c:if test="${timesSignDef.timesSign==1}">ҹ�����</c:if>
						<input type="hidden" class="required isNo_NotOverValueInt" name="timesSignDef.timesSign" value="${timesSignDef.timesSign}" size="24"/></td>
						</tr>
					<tr>
					    <td class="pn-flabel pn-flabel-h">����ʱ�䣺</td>
						<td colspan="3" class="pn-fcontent"><input  size="24"  class="required maxlength8" type="text" name="timesSignDef.endTime" value="${timesSignDef.endTime }"  class="Wdate" onclick="WdatePicker({dateFmt:'HH:mm:ss'})" readonly="readonly"/><span style="color: red">&nbsp;*</span></td>
				    </tr>
					<tr>
					    <td  class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;ע��</td>
						<td  colspan="3" class="pn-fcontent">
						<textarea class="maxlength50 " name="timesSignDef.remark" rows="3" cols="52">${timesSignDef.remark}</textarea></td>
					</tr>
					<tr>
						<td colspan="4" class="pn-fbutton">
							<input type="submit" value=" �� �� "/>&nbsp;
						    <input type="reset" value=" �� �� "/>&nbsp;
						    <input type="button" value=" �� �� " onclick="return back()"/>
						</td>
						    
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>