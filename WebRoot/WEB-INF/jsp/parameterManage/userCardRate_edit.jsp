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
		<title>�޸��û�������</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<%@include file="../include/common.jsp" %>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<!-- ����jsonrpc.js -->
		<script type="text/javascript" src="${basePath}/js/jsonrpc.js"></script>
		<script type="text/javascript">
		function back(){
			window.location.href = "userCardRate_list.do";
			}


		</script>

	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="userCardRate_updateUserCardRate.do" >
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<tr>
						<td class="pn-flabel pn-flabel-h">�汾�ţ�</td>
						<td style="width: 430px;" class="pn-fcontent">${userCardRate.version}<input readonly="readonly" type="hidden"  name="userCardRate.version" value="${userCardRate.version}" size="28"/></td>
						<td class="pn-flabel pn-flabel-h">�û������ͣ�</td>
						<td class="pn-fcontent">
						<select style="width: 206px;height: 22px;"  class="required " name="userCardRate.userCardType">
								<option value="" <c:if test="${userCardRate.userCardType==null}">selected</c:if>>��ѡ��</option>
							    <c:forEach items="${uctList}" var="item">
									<option value="${item.userCardType}" <c:if test="${userCardRate.userCardType==item.userCardType}">selected</c:if>>${item.typeName}</option>
							   </c:forEach> 
						</select><span style="color: red">&nbsp;*</span>
						</td>
					</tr>
	     			<tr>
						<td class="pn-flabel pn-flabel-h">��¼�ţ�</td>
						<td style="width: 430px;" class="pn-fcontent">${userCardRate.recNo}<input readonly="readonly" type="hidden" name="userCardRate.recNo" value="${userCardRate.recNo}" size="28"/></td>
					    <td class="pn-flabel pn-flabel-h">����&nbsp;&nbsp;��</td>
						<td class="pn-fcontent"><input type="text" class="required isNo_NotOverValueInt" name="userCardRate.money" value="${userCardRate.money}" size="28"/><span style="color: red">&nbsp;*</span></td>
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
	<script language="javascript">
		//jsonrpc = new JSONRpcClient("JSON-RPC");//JSON-RPC ��Ӧweb.xml�����URL
		//var result = jsonrpc.ajax.getParkNo_ParkName();
		//}
	</script>
	</body>
</html>