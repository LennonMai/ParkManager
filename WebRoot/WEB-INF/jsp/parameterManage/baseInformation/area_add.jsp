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
		<title>���������Ϣ</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<%@include file="../../include/common.jsp" %>
		<!-- ����jsonrpc.js -->
		<script type="text/javascript" src="${basePath}/js/jsonrpc.js"></script>
		<script type="text/javascript">
		function ishasAreaNo() {
			var areaNo = $("#areaNo").val();
			jQuery.post("baseInfo_ishasAreaNo.do?areaInformation.areaNo="+areaNo, function(data) {
				if(data == "hasAreaNo") {
					alert("��������Ѵ��ڣ�");
					$("#areaNo").val("");
		    		$("#areaNo").focus();
				}
			});
		}
		
		//caijunhua jquery�첽��֤���������Ƿ����
		function getAreaByName() {
			var areaName = $("#areaName").val();
			jQuery.post("baseInfo_getAreaByName.do?areaInformation.areaName="+areaName, function(data) {
				if(data == "fail") {
					alert("���������Ѵ��ڣ�");
					$("#areaName").val("");
		    		$("#areaName").focus();
				}
			});
		}
		
		function back(){
			window.location.href = "baseInfo_area_list.do";
		}	
		</script>

	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="baseInfo_saveAreaInfo.do" >
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
                    <tr><!-- ���б����б���ʾ�������ƣ�ʵ��ֵΪ���б��� -->
						<td class="pn-flabel pn-flabel-h">�������ƣ�</td>
						<td class="pn-fcontent">
						<select class="required" id="areaInformation_cityNo" name="areaInformation.cityNo" style="width: 207px;height: 22px;">
						</select><span style="color: red">&nbsp;*</span></td>
	
					    <td class="pn-flabel pn-flabel-h">������룺</td>
						<td class="pn-fcontent"><input type="text" class="required isNo_NotOverValue" id="areaNo" name="areaInformation.areaNo" value="${areaInformation.areaNo}" size="28" onblur="ishasAreaNo();"/><span style="color: red">&nbsp;*</span></td>
			    		</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">�������ƣ�</td>
						<td class="pn-fcontent"><input id="areaName" type="text" class="required maxlength20" onblur="getAreaByName();" name="areaInformation.areaName" value="${areaInformation.areaName}" size="28"/><span style="color: red">&nbsp;*</span></td>
						<td class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;&nbsp;&nbsp;����</td>
						<td class="pn-fcontent"><input type="text" class="maxlength30" name="areaInformation.areaDomain" value="${areaInformation.areaDomain}" size="28"/></td>
						</tr>
					<tr>
				    	<td class="pn-flabel pn-flabel-h">������IP��</td>
						<td class="pn-fcontent"><input type="text" class="isIP " name="areaInformation.areaServerIp" value="${areaInformation.areaServerIp}" size="28"/></td>
			    		<td class="pn-flabel pn-flabel-h">���������ƣ�</td>
						<td class="pn-fcontent"><input type="text" class="maxlength16" name="areaInformation.areaServerName" value="${areaInformation.areaServerName}" size="28"/></td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">���ݿ�����</td>
						<td class="pn-fcontent"><input type="text" class="maxlength16" name="areaInformation.areaDbname" value="${areaInformation.areaDbname}" size="28"/></td>
					    <td class="pn-flabel pn-flabel-h">���ݿ����룺</td>
						<td class="pn-fcontent"><input type="text" class="maxlength6" name="areaInformation.areaDbpassword" value="${areaInformation.areaDbpassword}" size="28"/></td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">���ݿ��û�����</td>
						<td colspan="4" class="pn-fcontent"><input type="text" class="maxlength8" name="areaInformation.areaDbuserName" value="${areaInformation.areaDbuserName}" size="28"/></td>
					    
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
<script language="javascript">
	//������б��������б�
	jsonrpc = new JSONRpcClient("JSON-RPC");//JSON-RPC ��Ӧweb.xml�����URL
	var result = jsonrpc.ajax.getCityNo_CityName();
	for (var i=0;i<result.length;i++){
		option =document.createElement("OPTION");
		option.value = result[i][0];
		option.text = result[i][1];
		//document.all.areaInformation_cityNo.options.add(option);
		document.getElementById("areaInformation_cityNo").options.add(option);
	}
</script>	
		</div>

	</body>
</html>