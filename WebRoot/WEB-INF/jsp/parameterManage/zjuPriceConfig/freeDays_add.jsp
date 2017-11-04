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
		<title>����������</title>
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
			<form id="dataform" method="post" action="zjuPriceConfig_saveFreeDays.do" onsubmit="return check()">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<tr>
						<td class="pn-flabel pn-flabel-h">�շ����ͣ�</td>
						<td class="pn-fcontent"><!--<input size="25" type="text" class="required isNo_NotOverValueInt" name="freeDays.feeRuleType" value="${freeDays.feeRuleType}" size="24"/>
						--><select class="required " id="freeDays_feeRuleType" name="freeDays.feeRuleType" style="width: 185px;height: 22px;">
						</select><span style="color: red">&nbsp;*</span></td>
						<td class="pn-flabel pn-flabel-h">���ͣ�</td>
						<td class="pn-fcontent">
						<select style="width: 185px;height: 22px;" id="freeDays_type" name="freeDays.type" class="required " onchange="toChange(this);">
							<option value="">- ��ѡ�� -</option>
							<option value="0">0 -����</option>
							<option value="1">1 -�գ�Date��</option>		
						</select><span style="color: red">&nbsp;*</span></td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">������ڣ�</td>
						<td colspan="4" class="pn-fcontent">
							<select id="freeWeek" name="freeWeek" style="display: none;width: 185px;height: 22px;">
								<option value="1" selected="selected">  ����һ</option>
								<option value="2">  ���ڶ�</option>
								<option value="3">  ������</option>
								<option value="4">  ������</option>
								<option value="5">  ������</option>
								<option value="6">  ������</option>
								<option value="7">  ������</option>
							</select>
							<input type="text" id="freeDay" name="freeDays.value" value="${freeDays.value}" size="25" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="display: none;" readonly="readonly"/>
						</td>
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
	//�����շ����������б�
	jsonrpc = new JSONRpcClient("JSON-RPC");//JSON-RPC ��Ӧweb.xml�����URL
	
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