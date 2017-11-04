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
		<title>�޸��������</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<%@include file="../../include/common.jsp" %>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<!-- ����jsonrpc.js -->
		<script type="text/javascript" src="${basePath}/js/jsonrpc.js"></script>
		<script type="text/javascript">
		if("${message}"=="hasFreeDays"){
			alert("�Ѵ��ڸ�������ڣ�");
		    }
		function back(){
			window.location.href = "zjuPriceConfig_freeDays_list.do";
		}
		function check(){
			if(document.getElementById('freeDays_type').value==1){
				if(document.getElementById('freeDays.value').value.trim()==""){
					alert("������ڲ���Ϊ��");
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
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="zjuPriceConfig_updateFreeDays.do" onsubmit="return check()">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<tr>
						<td class="pn-flabel pn-flabel-h">�շ����ͣ�</td>
						<input readonly="readonly" type="hidden"  name="freeDays.feeRuleType" value="${freeDays.feeRuleType}" size="25"/>
						<td  style="width: 430px;" id="feeRuleType" class="pn-fcontent"></td>
							<script language="javascript">			    
	                             //�����У������շ�����ȡ�ó��������д������
	                             var feeRuleType=${freeDays.feeRuleType};
	                             jsonrpc = new JSONRpcClient("JSON-RPC");//JSON-RPC ��Ӧweb.xml�����URL
	                             var _name = jsonrpc.ajax.get_Name(feeRuleType);                          	 
	                             //document.write("<td style='word-break:break-all;padding-left:5px;padding-right:5px;' id='${item.parkNo}+${item.feeTypeNo}+${item.vehTypeNo}+${item.startRange}'></td>");                         		                        
		                         document.getElementById("feeRuleType").innerHTML=_name;
                        </script>
						<td class="pn-flabel pn-flabel-h">���ͣ�</td>
						<td class="pn-fcontent">
						<select style="width: 185px;height: 22px;" id="freeDays_type" name="freeDays.type" class="required ">
							<c:if test="${freeDays.type == 0}">
								<option value="0" selected="selected">0 -����</option>
							</c:if>
							<c:if test="${freeDays.type == 1}">
								<option value="1">1 -�գ�Date��</option>
							</c:if>	
						</select><span style="color: red">&nbsp;*</span></td>	
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">������ڣ�</td>
						<td colspan="4" class="pn-fcontent">
							<c:if test="${freeDays.type == 0}">
								<select style="width: 185px;height: 22px;" id="freeWeek" name="freeWeek">
									<option value="1" <c:if test="${freeDays.value eq '1         ' }"> selected="selected" </c:if>>����һ</option>
									<option value="2" <c:if test="${freeDays.value eq '2         ' }"> selected="selected" </c:if>>���ڶ�</option>
									<option value="3" <c:if test="${freeDays.value eq '3         ' }"> selected="selected" </c:if>>������</option>
									<option value="4" <c:if test="${freeDays.value eq '4         ' }"> selected="selected" </c:if>>������</option>
									<option value="5" <c:if test="${freeDays.value eq '5         ' }"> selected="selected" </c:if>>������</option>
									<option value="6" <c:if test="${freeDays.value eq '6         ' }"> selected="selected" </c:if>>������</option>
									<option value="7" <c:if test="${freeDays.value eq '7         ' }"> selected="selected" </c:if>>������</option>
								</select>
							</c:if>
							<c:if test="${freeDays.type == 1}">
								<input type="text" id="freeDay" name="freeDays.value" value="${freeDays.value}" size="25" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
							</c:if></td>
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