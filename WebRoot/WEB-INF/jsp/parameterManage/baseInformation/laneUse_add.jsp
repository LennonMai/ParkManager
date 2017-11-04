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
		<title>添加有用车道</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/jquery.js"></script>
			<%@include file="../../include/common.jsp" %>
		<!-- 引入jsonrpc.js -->
		<script type="text/javascript" src="${basePath}/js/jsonrpc.js"></script>
		<script type="text/javascript">
		
		//验证有用车道编码是否存在
	    function ishasLaneUseNo() {
	    	var laneUseNo = $("#laneUseNo").val();
	    	jQuery.post("baseInfo_ishasLaneUseNo.do?laneUse.laneNo="+laneUseNo, function(data){
	    		if(data == "hasLaneUseNo") {
	    			alert("有用车道编码已存在！");
	    			$("#laneUseNo").val("");
		    		$("#laneUseNo").focus();
	    		}	
	    	});
	    }
		
	    //验证有用车道IP是否存在
	    function ishasLaneUseIP() {
	    	var laneUseIP = $("#laneUseIP").val();
	    	jQuery.post("baseInfo_ishasLaneUseIP.do?laneUse.laneComputerIp="+laneUseIP, function(data){
	    		if(data == "hasLaneUseIP") {
	    			alert("计算机IP地址已存在！");
	    			$("#laneUseIP").val("");
		    		$("#laneUseIP").focus();
	    		}	
	    	});
	    }
		
			function back(){
				window.location.href = "baseInfo_laneUse_list.do";
			}
			//获取小区
			function ajaxInitPark(){
			  (function($) { 
  			   $(function() {
				$.ajax({
					type:"post",
					url:"baseInfo_ajaxInitPark.do?areaNo="+document.getElementById('laneUse_areaNo').value,
					success:function(res){
						$("#laneUse_parkNo").empty();
						var op = $("<option value=''>- 请选择 -</option>");		
						$("#laneUse_parkNo").append(op);
						$(res).find("parks > park").each(function(){								
						var op = $("<option value=" + $(this).attr("id") + ">" 
								+ $(this).attr("name") + "</option>");
						$("#laneUse_parkNo").append(op);	
					});
					}
				});
			   });
			  })(jQuery);
			}
			//获取大门
			function ajaxInitGate(){
			(function($) { 
  				$(function() {
				$.ajax({
					type:"post",
					url:"baseInfo_ajaxInitGate.do?parkNo="+document.getElementById('laneUse_parkNo').value,
					success:function(res){
						$("#laneUse_gateNo").empty();
						var op = $("<option value=''>- 请选择 -</option>");		
						$("#laneUse_gateNo").append(op);
						$(res).find("gates > gate").each(function(){								
						var op = $("<option value=" + $(this).attr("id") + ">" 
								+ $(this).attr("name") + "</option>");
						$("#laneUse_gateNo").append(op);	
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
			<form id="dataform" method="post" action="baseInfo_saveLaneUse.do">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">             
			    	 <tr>
						<td class="pn-flabel pn-flabel-h">区域名称：</td>
						<td class="pn-fcontent">
						<select id="laneUse_areaNo" class="required " name="laneUse.areaNo" style="width: 206px;height: 22px;" onchange="ajaxInitPark();">
						</select><span style="color: red">&nbsp;*</span></td>
						
						<td class="pn-flabel pn-flabel-h">小区名称：</td>
						<td class="pn-fcontent">
						<select id="laneUse_parkNo" class="required " name="laneUse.parkNo" style="width: 206px;height: 22px;" onchange="ajaxInitGate();">
							<option value="">- 请选择 -</option>
						</select><span style="color: red">&nbsp;*</span></td>
						</tr>
			    	<tr>
						<td class="pn-flabel pn-flabel-h">大门名称：</td>
						<td class="pn-fcontent">
						<select id="laneUse_gateNo" class="required " name="laneUse.gateNo" style="width: 206px;height: 22px;">
							<option value="">- 请选择 -</option>
						</select><span style="color: red">&nbsp;*</span></td>
						<td class="pn-flabel pn-flabel-h">车道编码：</td>
						<td class="pn-fcontent"><input id="laneUseNo" type="text" class="required isNo_NotOverValue" name="laneUse.laneNo" value="${laneUse.laneNo}" size="28" onblur="ishasLaneUseNo();"/><span style="color: red">&nbsp;*</span></td>
			    	</tr>	
			    	
					<tr>
					<td class="pn-flabel pn-flabel-h">是否启用：</td>
						<td class="pn-fcontent">
						<select class="required " name="laneUse.isUse" style="width: 206px;height: 22px;">
						   <option value="" selected="selected">- 请选择 -</option>
			               <option value="0">不启用</option>
			               <option value="1">启用</option>		          
		                </select><span style="color: red">*</span></td>
						<td class="pn-flabel pn-flabel-h">计算机IP地址：</td>
						<td class="pn-fcontent"><input type="text" class="required isIP" id="laneUseIP" name="laneUse.laneComputerIp" value="${laneUse.laneComputerIp}" size="28" onblur="ishasLaneUseIP()"/><span style="color: red">&nbsp;*</span></td>
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
		document.getElementById("laneUse_areaNo").options.add(option);
	}

</script>	
	</body>
</html>