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
		<title>添加车位显示信息</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/jquery.js"></script>
		<%@include file="../../include/common.jsp" %>
		<!-- 引入jsonrpc.js -->
		<script type="text/javascript" src="${basePath}/js/jsonrpc.js"></script>
		<script type="text/javascript">			
			//获取大门
			function getGate(){
			(function($) { 
  				$(function() {
				$.ajax({
					type:"post",
					url:"lostCard_ajaxGate.do?parkNo="+document.getElementById('carSpaceShowMessage.parkNo').value,
					success:function(res){
						$("#carSpaceShowMessage_gateNo").empty();
						var op = $("<option value=''>-请选择-</option>");		
						$("#carSpaceShowMessage_gateNo").append(op);
						$(res).find("gates > gate").each(function(){								
						var op = $("<option value=" + $(this).attr("id") + ">" 
								+ $(this).attr("name") + "</option>");
						$("#carSpaceShowMessage_gateNo").append(op);	
					});
					}
				});
				 });
				})(jQuery);
			}
			//获取大门信息
			function getLane(){
			  (function($) { 
  			   $(function() {
				$.ajax({
					type:"post",
					url:"lostCard_ajaxLane.do?parkNo="+document.getElementById('carSpaceShowMessage.parkNo').value
					+ "&gateNo="+document.getElementById('carSpaceShowMessage_gateNo').value,
					success:function(res){
						$("#carSpaceShowMessage_laneNo").empty();
						var op = $("<option value=''>-请选择-</option>");		
						$("#carSpaceShowMessage_laneNo").append(op);
						$(res).find("lanes > lane").each(function(){								
						var op = $("<option value=" + $(this).attr("id") + ">" 
								+ $(this).attr("name") + "</option>");
						$("#carSpaceShowMessage_laneNo").append(op);	
					});
					}
				});
			   });
			  })(jQuery);
			}
			function back(){
				window.location.href = "carSpaceShowMessage_list.do";
			}
			<%--function check(){
				var v="succuss";
				var valParkNo=(document.getElementsByName("carSpaceShowMessage.parkNo")[0].value);
				var valGateNo=(document.getElementsByName("carSpaceShowMessage.gateNo")[0].value);
				var valLaneNo=(document.getElementsByName("carSpaceShowMessage.laneNo")[0].value);
				var valParkNoTemp=(document.getElementsByName("parkNo")[0].value);
				var valGateNoTemp=(document.getElementsByName("gateNo")[0].value);
				var valLaneNoTemp=(document.getElementsByName("laneNo")[0].value);
				if(valParkNo!=valParkNoTemp || valGateNo!=valGateNoTemp || valLaneNo!=valLaneNoTemp){
					jQuery.ajax({type:"post",url:"carSpaceShowMessage_ajaxExist.do?carSpaceShowMessage.parkNo="+valParkNo+"&carSpaceShowMessage.gateNo="+valGateNo+"&carSpaceShowMessage.laneNo="+valLaneNo,async:false, success:function(data,textStatus){	   
					    if(data=="fail"){   
					    	v="fail";
					    	alert("此小区车道车位信息已存在."); 
					    }
					 }
					});	
					if(v=="fail"){
						return false;
					}
				}			 					 
			}--%>
		</script>
		
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="carSpaceShowMessage_update.do">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">             
			    	 <tr>												
						<td class="pn-flabel pn-flabel-h">小区编号：</td>
						<td class="pn-fcontent">
							<input type="text"  name="carSpaceShowMessage.parkNo" value="${carSpaceShowMessage.parkNo}" size="150px" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/>
						</td>
						<td class="pn-flabel pn-flabel-h">大门编号：</td>
						<td class="pn-fcontent">
							<input type="text"  name="carSpaceShowMessage.gateNo" value="${carSpaceShowMessage.gateNo}" size="150px" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/>
						</td>
					</tr>
			    	<tr>
						<td class="pn-flabel pn-flabel-h">车道编号：</td>
						<td class="pn-fcontent">
							<input type="text"  name="carSpaceShowMessage.laneNo" value="${carSpaceShowMessage.laneNo}" size="150px" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/>
						</td>
						<td class="pn-flabel pn-flabel-h">是否显示：</td>
						<td class="pn-fcontent">
						<select  class="required " name="carSpaceShowMessage.isShowPosition" style="width: 150px;height: 22px;">
						<c:choose>
							<c:when test="${carSpaceShowMessage.isShowPosition==0 }">
								<option value="0" selected="selected">显     示</option>
								<option value="1">不显示</option>
							</c:when>
							<c:otherwise>
								<option value="1" selected="selected">不显示</option>
								<option value="0">显     示</option>
							</c:otherwise>
						</c:choose>	
						</select></td>
					</tr>																    						
					<tr>	
						<td class="pn-flabel pn-flabel-h">显示内容：</td>
						<td colspan="4"  class="pn-fcontent"><input type="text"  name="carSpaceShowMessage.initShow" value="${carSpaceShowMessage.initShow}" size="110" class="maxlength100"/></td>
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