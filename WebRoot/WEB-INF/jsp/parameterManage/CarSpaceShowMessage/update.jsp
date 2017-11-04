<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- ʹ��JavaBean ����jsonrpc.jar -->
<jsp:useBean id="JSONRPCBridge" scope="session" class="com.metaparadigm.jsonrpc.JSONRPCBridge"/>
<jsp:useBean id="ajax" class="com.hgsoft.util.AjaxBean"></jsp:useBean>
<%
	JSONRPCBridge.registerObject("ajax",ajax);
%>
<html>
	<head>
		<title>��ӳ�λ��ʾ��Ϣ</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/jquery.js"></script>
		<%@include file="../../include/common.jsp" %>
		<!-- ����jsonrpc.js -->
		<script type="text/javascript" src="${basePath}/js/jsonrpc.js"></script>
		<script type="text/javascript">			
			//��ȡ����
			function getGate(){
			(function($) { 
  				$(function() {
				$.ajax({
					type:"post",
					url:"lostCard_ajaxGate.do?parkNo="+document.getElementById('carSpaceShowMessage.parkNo').value,
					success:function(res){
						$("#carSpaceShowMessage_gateNo").empty();
						var op = $("<option value=''>-��ѡ��-</option>");		
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
			//��ȡ������Ϣ
			function getLane(){
			  (function($) { 
  			   $(function() {
				$.ajax({
					type:"post",
					url:"lostCard_ajaxLane.do?parkNo="+document.getElementById('carSpaceShowMessage.parkNo').value
					+ "&gateNo="+document.getElementById('carSpaceShowMessage_gateNo').value,
					success:function(res){
						$("#carSpaceShowMessage_laneNo").empty();
						var op = $("<option value=''>-��ѡ��-</option>");		
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
					    	alert("��С��������λ��Ϣ�Ѵ���."); 
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
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="carSpaceShowMessage_update.do">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">             
			    	 <tr>												
						<td class="pn-flabel pn-flabel-h">С����ţ�</td>
						<td class="pn-fcontent">
							<input type="text"  name="carSpaceShowMessage.parkNo" value="${carSpaceShowMessage.parkNo}" size="150px" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/>
						</td>
						<td class="pn-flabel pn-flabel-h">���ű�ţ�</td>
						<td class="pn-fcontent">
							<input type="text"  name="carSpaceShowMessage.gateNo" value="${carSpaceShowMessage.gateNo}" size="150px" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/>
						</td>
					</tr>
			    	<tr>
						<td class="pn-flabel pn-flabel-h">������ţ�</td>
						<td class="pn-fcontent">
							<input type="text"  name="carSpaceShowMessage.laneNo" value="${carSpaceShowMessage.laneNo}" size="150px" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/>
						</td>
						<td class="pn-flabel pn-flabel-h">�Ƿ���ʾ��</td>
						<td class="pn-fcontent">
						<select  class="required " name="carSpaceShowMessage.isShowPosition" style="width: 150px;height: 22px;">
						<c:choose>
							<c:when test="${carSpaceShowMessage.isShowPosition==0 }">
								<option value="0" selected="selected">��     ʾ</option>
								<option value="1">����ʾ</option>
							</c:when>
							<c:otherwise>
								<option value="1" selected="selected">����ʾ</option>
								<option value="0">��     ʾ</option>
							</c:otherwise>
						</c:choose>	
						</select></td>
					</tr>																    						
					<tr>	
						<td class="pn-flabel pn-flabel-h">��ʾ���ݣ�</td>
						<td colspan="4"  class="pn-fcontent"><input type="text"  name="carSpaceShowMessage.initShow" value="${carSpaceShowMessage.initShow}" size="110" class="maxlength100"/></td>
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