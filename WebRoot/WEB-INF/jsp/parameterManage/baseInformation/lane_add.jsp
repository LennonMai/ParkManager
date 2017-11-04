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
		<title>添加车道信息</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/jquery.js"></script>
			<%@include file="../../include/common.jsp" %>
		<!-- 引入jsonrpc.js -->
		<script type="text/javascript" src="${basePath}/js/jsonrpc.js"></script>
		<script type="text/javascript">
		//验证车道编码是否存在
	    function ishasLaneNo() {
	    	var laneNo = $("#laneNo").val();
	    	jQuery.post("baseInfo_ishasLaneNo.do?laneInformation.laneNo="+laneNo, function(data){
	    		if(data == "hasLaneNo") {
	    			alert("车道编码已存在！");
	    			$("#laneNo").val("");
		    		$("#laneNo").focus();
	    		}	
	    	});
	    }
		
	    //验证车道IP是否存在
	    function ishasLaneIP() {
	    	var laneIP = $("#laneIP").val();
	    	jQuery.post("baseInfo_ishasLaneIP.do?laneInformation.laneComputerIp="+laneIP, function(data){
	    		if(data == "hasLaneIP") {
	    			alert("计算机IP地址已存在！");
	    			$("#laneIP").val("");
		    		$("#laneIP").focus();
	    		}	
	    	});
	    }
		
			function back(){
				window.location.href = "baseInfo_lane_list.do";
			}
			//获取小区
			function getPark(){
			  (function($) { 
  			   $(function() {
				$.ajax({
					type:"post",
					url:"lostCard_ajaxPark.do?areaNo="+document.getElementById('laneInformation_areaNo').value,
					success:function(res){
						$("#laneInformation_parkNo").empty();
						var op = $("<option value=''>- 请选择 -</option>");		
						$("#laneInformation_parkNo").append(op);
						$(res).find("parks > park").each(function(){								
						var op = $("<option value=" + $(this).attr("id") + ">" 
								+ $(this).attr("name") + "</option>");
						$("#laneInformation_parkNo").append(op);	
					});
					}
				});
			   });
			  })(jQuery);
			}
			//获取大门
			function getGate(){
			(function($) { 
  				$(function() {
				$.ajax({
					type:"post",
					url:"lostCard_ajaxGate.do?parkNo="+document.getElementById('laneInformation_parkNo').value,
					success:function(res){
						$("#laneInformation_gateNo").empty();
						var op = $("<option value=''>- 请选择 -</option>");		
						$("#laneInformation_gateNo").append(op);
						$(res).find("gates > gate").each(function(){								
						var op = $("<option value=" + $(this).attr("id") + ">" 
								+ $(this).attr("name") + "</option>");
						$("#laneInformation_gateNo").append(op);	
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
			<form id="dataform" method="post" action="baseInfo_saveLaneInfo.do">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">             
			    	 <tr>
						<td class="pn-flabel pn-flabel-h">区域名称：</td>
						<td class="pn-fcontent">
						<select id="laneInformation_areaNo" class="required " name="laneInformation.areaNo" style="width: 206px;height: 22px;" onchange="getPark();">
						</select><span style="color: red">&nbsp;*</span></td>
						
						<td class="pn-flabel pn-flabel-h">小区名称：</td>
						<td class="pn-fcontent">
						<select id="laneInformation_parkNo" class="required " name="laneInformation.parkNo" style="width: 206px;height: 22px;" onchange="getGate();">
							<option value="">- 请选择 -</option>
						</select><span style="color: red">&nbsp;*</span></td>
						</tr>
			    	<tr>
						<td class="pn-flabel pn-flabel-h">大门名称：</td>
						<td class="pn-fcontent">
						<select id="laneInformation_gateNo" class="required " name="laneInformation.gateNo" style="width: 206px;height: 22px;">
							<option value="">- 请选择 -</option>
						</select><span style="color: red">&nbsp;*</span></td>
						<td class="pn-flabel pn-flabel-h">车道类型：</td>
						<td class="pn-fcontent"><c:if test="${laneInformation.laneTypeNo==null}">
						<select class="required " name="laneInformation.laneTypeNo" style="width: 206px;height: 22px;">
						   <option value="" selected="selected">- 请选择 -</option>
			               <option value="1">入口</option>
			               <option value="2">出口</option>		          
		                </select>
		                </c:if>
		                <c:if test="${laneInformation.laneTypeNo==1}">
						<select class="required " name="laneInformation.laneTypeNo" style="width: 206px;height: 22px;">
						   <option value="" >- 请选择 -</option>
			               <option value="1" selected="selected">入口</option>
			               <option value="2">出口</option>			          
		                </select>
		                </c:if>
		                 <c:if test="${laneInformation.laneTypeNo==2}">
						<select class="required " name="laneInformation.laneTypeNo" style="width: 206px;height: 22px;">
						   <option value="" >- 请选择 -</option>
			               <option value="1">入口</option>
			               <option value="2" selected="selected">出口</option>			          
		                </select>
		                </c:if><span style="color: red">*</span></td>
						</tr>	
			    	
					<tr>
						<td class="pn-flabel pn-flabel-h">车道编码：</td>
						<td class="pn-fcontent"><input id="laneNo" type="text" class="required isNo_NotOverValue" name="laneInformation.laneNo" value="${laneInformation.laneNo}" size="28" onblur="ishasLaneNo();"/><span style="color: red">&nbsp;*</span></td>
			    		<td class="pn-flabel pn-flabel-h">计算机名：</td>
						<td class="pn-fcontent"><input type="text" class="maxlength16" name="laneInformation.laneComputerName" value="${laneInformation.laneComputerName}" size="28"/></td>
						</tr>
					<tr>	
						<td class="pn-flabel pn-flabel-h">计算机IP地址：</td>
						<td class="pn-fcontent"><input type="text" class="required isIP" id="laneIP" name="laneInformation.laneComputerIp" value="${laneInformation.laneComputerIp}" size="28"/><span style="color: red">&nbsp;*</span></td>
						<td class="pn-flabel pn-flabel-h">启用合计：</td>
						<td class="pn-fcontent">
							<select class="required " name="laneInformation.isUse" style="width: 206px;height: 22px;">
				               <option value="1" selected="selected">启用</option>
				               <option value="0">不启用</option>			          
			                </select>
							<span style="color: red">&nbsp;*</span>
						</td>
					 <%-- 
						<td colspan="4"  class="pn-fcontent"><input type="text" class="required isIP" id="laneIP" name="laneInformation.laneComputerIp" value="${laneInformation.laneComputerIp}" size="28" onblur="ishasLaneIP()"/><span style="color: red">&nbsp;*</span></td>
					 --%>
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
	//构造区域名称下拉列表
	jsonrpc = new JSONRpcClient("JSON-RPC");//JSON-RPC 对应web.xml里面的URL

	var result1 = jsonrpc.ajax.getAreaNo_AreaName();
	for (var i=0;i<result1.length;i++){
		option =document.createElement("OPTION");
		option.value = result1[i][0];
		option.text = result1[i][1];
		document.getElementById("laneInformation_areaNo").options.add(option);
	}
	//构造小区名称下拉列表
	//var result2 = jsonrpc.ajax.getParkNo_ParkName();
	//for (var i=0;i<result2.length;i++){
		//option =document.createElement("OPTION");
		//option.value = result2[i][0];
		//option.text = result2[i][1];
		//document.getElementById("laneInformation_parkNo").options.add(option);
	//}
	//构造大门名称下拉列表
	//var result3 = jsonrpc.ajax.getGateNo_GateName();
	//for (var i=0;i<result3.length;i++){
		//option =document.createElement("OPTION");
		//option.value = result3[i][0];
		//option.text = result3[i][1];
		//document.getElementById("laneInformation_gateNo").options.add(option);
	//}
</script>	
	</body>
</html>