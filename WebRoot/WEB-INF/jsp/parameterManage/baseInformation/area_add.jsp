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
		<title>添加区域信息</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<%@include file="../../include/common.jsp" %>
		<!-- 引入jsonrpc.js -->
		<script type="text/javascript" src="${basePath}/js/jsonrpc.js"></script>
		<script type="text/javascript">
		function ishasAreaNo() {
			var areaNo = $("#areaNo").val();
			jQuery.post("baseInfo_ishasAreaNo.do?areaInformation.areaNo="+areaNo, function(data) {
				if(data == "hasAreaNo") {
					alert("区域编码已存在！");
					$("#areaNo").val("");
		    		$("#areaNo").focus();
				}
			});
		}
		
		//caijunhua jquery异步验证区域名称是否存在
		function getAreaByName() {
			var areaName = $("#areaName").val();
			jQuery.post("baseInfo_getAreaByName.do?areaInformation.areaName="+areaName, function(data) {
				if(data == "fail") {
					alert("区域名称已存在！");
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
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="baseInfo_saveAreaInfo.do" >
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
                    <tr><!-- 城市编码列表，显示城市名称，实际值为城市编码 -->
						<td class="pn-flabel pn-flabel-h">城市名称：</td>
						<td class="pn-fcontent">
						<select class="required" id="areaInformation_cityNo" name="areaInformation.cityNo" style="width: 207px;height: 22px;">
						</select><span style="color: red">&nbsp;*</span></td>
	
					    <td class="pn-flabel pn-flabel-h">区域编码：</td>
						<td class="pn-fcontent"><input type="text" class="required isNo_NotOverValue" id="areaNo" name="areaInformation.areaNo" value="${areaInformation.areaNo}" size="28" onblur="ishasAreaNo();"/><span style="color: red">&nbsp;*</span></td>
			    		</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">区域名称：</td>
						<td class="pn-fcontent"><input id="areaName" type="text" class="required maxlength20" onblur="getAreaByName();" name="areaInformation.areaName" value="${areaInformation.areaName}" size="28"/><span style="color: red">&nbsp;*</span></td>
						<td class="pn-flabel pn-flabel-h">域&nbsp;&nbsp;&nbsp;&nbsp;名：</td>
						<td class="pn-fcontent"><input type="text" class="maxlength30" name="areaInformation.areaDomain" value="${areaInformation.areaDomain}" size="28"/></td>
						</tr>
					<tr>
				    	<td class="pn-flabel pn-flabel-h">服务器IP：</td>
						<td class="pn-fcontent"><input type="text" class="isIP " name="areaInformation.areaServerIp" value="${areaInformation.areaServerIp}" size="28"/></td>
			    		<td class="pn-flabel pn-flabel-h">服务器名称：</td>
						<td class="pn-fcontent"><input type="text" class="maxlength16" name="areaInformation.areaServerName" value="${areaInformation.areaServerName}" size="28"/></td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">数据库名：</td>
						<td class="pn-fcontent"><input type="text" class="maxlength16" name="areaInformation.areaDbname" value="${areaInformation.areaDbname}" size="28"/></td>
					    <td class="pn-flabel pn-flabel-h">数据库密码：</td>
						<td class="pn-fcontent"><input type="text" class="maxlength6" name="areaInformation.areaDbpassword" value="${areaInformation.areaDbpassword}" size="28"/></td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">数据库用户名：</td>
						<td colspan="4" class="pn-fcontent"><input type="text" class="maxlength8" name="areaInformation.areaDbuserName" value="${areaInformation.areaDbuserName}" size="28"/></td>
					    
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
<script language="javascript">
	//构造城市编码下拉列表
	jsonrpc = new JSONRpcClient("JSON-RPC");//JSON-RPC 对应web.xml里面的URL
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