<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 使用JavaBean 引入jsonrpc.jar -->
<jsp:useBean id="JSONRPCBridge" scope="session" class="com.metaparadigm.jsonrpc.JSONRPCBridge"/>
<jsp:useBean id="ajax" class="com.hgsoft.util.AjaxBean"></jsp:useBean>
<%
	JSONRPCBridge.registerObject("ajax",ajax);
%>
<html>
	<head>
		<title>添加大门信息</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/jquery.js"></script>
		<%@include file="../../include/common.jsp" %>
		<!-- 引入jsonrpc.js -->
		<script type="text/javascript" src="${basePath}/js/jsonrpc.js"></script>
		<script type="text/javascript">

			function back(){
				window.location.href = "baseInfo_gateway_list.do";
			}
			function ishasGateNo() {
				var gateNo = $("#gatewayInformation_gateNo").val();
				if(gateNo!=99){
					jQuery.post("baseInfo_ishasGateNo.do?gatewayInformation.gateNo="+gateNo, function(data) {
						if(data == "hasGateNo") {
							$("#gatewayInformation_gateNo").val("");
				    		$("#gatewayInformation_gateNo").focus();
							alert("大门编码已存在！");
						}
					});
					}
				else{//管理中心写定为99，所以大门编码不能为99
					$("#gatewayInformation_gateNo").val("");
		    		$("#gatewayInformation_gateNo").focus();
		    		alert("不可添加[99]为大门编码！");
					}
				
			}
			//caijunhua jquery异步验证大门名称是否存在
			function getGateByName() {
				var gateName = $("#gatewayInformation_gateName").val();
				jQuery.post("baseInfo_getGateByName.do?gatewayInformation.gateName="+gateName, function(data) {
					if(data == "fail") {
					    alert("大门名称已存在！");
						$("#gatewayInformation_gateName").val("");
			    		$("#gatewayInformation_gateName").focus();
						
					}
				});
			}
			
			//获取小区
			function getPark(){
			  (function($) { 
  			   $(function() {
				$.ajax({
					type:"post",
					url:"lostCard_ajaxPark.do?areaNo="+document.getElementById('gatewayInformation_areaNo').value,
					success:function(res){
						$("#gatewayInformation_parkNo").empty();
						var op = $("<option value=''>- 请选择 -</option>");		
						$("#gatewayInformation_parkNo").append(op);
						$(res).find("parks > park").each(function(){								
						var op = $("<option value=" + $(this).attr("id") + ">" 
								+ $(this).attr("name") + "</option>");
						$("#gatewayInformation_parkNo").append(op);	
					});
					}
				});
			   });
			  })(jQuery);
			}
		</script>

	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="baseInfo_saveGatewayInfo.do" >
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
                    <tr>
						<td class="pn-flabel pn-flabel-h">区域名称：</td>
						<td class="pn-fcontent">
						<select id="gatewayInformation_areaNo" class="required" name="gatewayInformation.areaNo" style="width: 208px;height: 22px;" onchange="getPark();">
						</select><span style="color: red">&nbsp;*</span></td>
						<td class="pn-flabel pn-flabel-h">小区名称：</td>
						<td class="pn-fcontent">
						<select id="gatewayInformation_parkNo" class="required" name="gatewayInformation.parkNo" style="width: 208px;height: 22px;">
							<option value="">- 请选择 -</option>
						</select><span style="color: red">&nbsp;*</span></td>
						</tr>
			    	<tr>
						<td class="pn-flabel pn-flabel-h">大门编码：</td>
						<td class="pn-fcontent"><input type="text" id="gatewayInformation_gateNo" class="required isNo_NotOverValue" name="gatewayInformation.gateNo" value="${gatewayInformation.gateNo}" size="28" onblur="ishasGateNo();"/><span style="color: red">&nbsp;*</span></td>
			    		<td class="pn-flabel pn-flabel-h">大门名称：</td>
						<td class="pn-fcontent"><input id="gatewayInformation_gateName" type="text" class="required maxlength20" onblur="getGateByName();" name="gatewayInformation.gateName" value="${gatewayInformation.gateName}" size="28"/><span style="color: red">&nbsp;*</span></td>
			    		</tr>	
					<tr>
						<td class="pn-flabel pn-flabel-h">大门全称：</td>
						<td colspan="4"  class="pn-fcontent"><input type="text"  class="maxlength20"  name="gatewayInformation.gateAllName" value="${gatewayInformation.gateAllName}" size="28"/></td>
						</tr>
					<tr>	
						<td class="pn-flabel pn-flabel-h">备&nbsp;&nbsp;注：</td>
						<td colspan="4"  class="pn-fcontent">
							<textarea class="maxlength50" name="gatewayInformation.remark" rows="3" cols="40">${gatewayInformation.remark}</textarea>
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
	//构造区域编码下拉列表
	jsonrpc = new JSONRpcClient("JSON-RPC");//JSON-RPC 对应web.xml里面的URL
	var result1 = jsonrpc.ajax.getAreaNo_AreaName();
	for (var i=0;i<result1.length;i++){
		option =document.createElement("OPTION");
		option.value = result1[i][0];
		option.text = result1[i][1];
		//document.all.areaInformation_cityNo.options.add(option);
		document.getElementById("gatewayInformation_areaNo").options.add(option);
	}
	//构造小区编码下拉列表
	//var result2 = jsonrpc.ajax.getParkNo_ParkName();
	//for (var i=0;i<result2.length;i++){
		//option =document.createElement("OPTION");
		//option.value = result2[i][0];
		//option.text = result2[i][1];
		//document.all.areaInformation_cityNo.options.add(option);
		//document.getElementById("gatewayInformation_parkNo").options.add(option);
	//}
	
</script>	
	</body>
</html>