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
			function check(){
				var v="succuss";
				var valParkNo=(document.getElementsByName("carSpaceShowMessage.parkNo")[0].value);
				var valGateNo=(document.getElementsByName("carSpaceShowMessage.gateNo")[0].value);
				var valLaneNo=(document.getElementsByName("carSpaceShowMessage.laneNo")[0].value);
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
		</script>
		
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="carSpaceShowMessage_save.do" onsubmit="return check();">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">             
			    	 <tr>												
						<td class="pn-flabel pn-flabel-h">С�����ƣ�</td>
						<td class="pn-fcontent">
							<select name="carSpaceShowMessage.parkNo" id ="carSpaceShowMessage.parkNo" style="width: 150px;height: 22px;" class="required " onchange="getGate();">
									<option value="">-��ѡ��-</option>
									<c:forEach items="${parkList}" var="item">
										<option value="${item.parkNo }"<c:if test="${item.parkNo==parkNo }"> selected="selected" </c:if>>${item.parkName }</option>
									</c:forEach>
							</select><span style="color: red">&nbsp;*</span></td>
						<td class="pn-flabel pn-flabel-h">�������ƣ�</td>
						<td class="pn-fcontent">
						<select id="carSpaceShowMessage_gateNo" class="required " name="carSpaceShowMessage.gateNo" style="width: 150px;height: 22px;" onchange="getLane();">
							<option value="">-��ѡ��-</option>
						</select><span style="color: red">&nbsp;*</span></td>
					</tr>
			    	<tr>
						<td class="pn-flabel pn-flabel-h">������ţ�</td>
						<td class="pn-fcontent">
						<select id="carSpaceShowMessage_laneNo" class="required " name="carSpaceShowMessage.laneNo" style="width: 150px;height: 22px;">
							<option value="">-��ѡ��-</option>
						</select><span style="color: red">&nbsp;*</span></td>
						<td class="pn-flabel pn-flabel-h">�Ƿ���ʾ��</td>
						<td class="pn-fcontent">
						<select  class="required " name="carSpaceShowMessage.isShowPosition" style="width: 150px;height: 22px;">
							<option value="0">��     ʾ</option>
							<option value="1">����ʾ</option>
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