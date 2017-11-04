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
		<title>��ӳ�����Ϣ</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/jquery.js"></script>
			<%@include file="../../include/common.jsp" %>
		<!-- ����jsonrpc.js -->
		<script type="text/javascript" src="${basePath}/js/jsonrpc.js"></script>
		<script type="text/javascript">
		//��֤���������Ƿ����
	    function ishasLaneNo() {
	    	var laneNo = $("#laneNo").val();
	    	jQuery.post("baseInfo_ishasLaneNo.do?laneInformation.laneNo="+laneNo, function(data){
	    		if(data == "hasLaneNo") {
	    			alert("���������Ѵ��ڣ�");
	    			$("#laneNo").val("");
		    		$("#laneNo").focus();
	    		}	
	    	});
	    }
		
	    //��֤����IP�Ƿ����
	    function ishasLaneIP() {
	    	var laneIP = $("#laneIP").val();
	    	jQuery.post("baseInfo_ishasLaneIP.do?laneInformation.laneComputerIp="+laneIP, function(data){
	    		if(data == "hasLaneIP") {
	    			alert("�����IP��ַ�Ѵ��ڣ�");
	    			$("#laneIP").val("");
		    		$("#laneIP").focus();
	    		}	
	    	});
	    }
		
			function back(){
				window.location.href = "baseInfo_lane_list.do";
			}
			//��ȡС��
			function getPark(){
			  (function($) { 
  			   $(function() {
				$.ajax({
					type:"post",
					url:"lostCard_ajaxPark.do?areaNo="+document.getElementById('laneInformation_areaNo').value,
					success:function(res){
						$("#laneInformation_parkNo").empty();
						var op = $("<option value=''>- ��ѡ�� -</option>");		
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
			//��ȡ����
			function getGate(){
			(function($) { 
  				$(function() {
				$.ajax({
					type:"post",
					url:"lostCard_ajaxGate.do?parkNo="+document.getElementById('laneInformation_parkNo').value,
					success:function(res){
						$("#laneInformation_gateNo").empty();
						var op = $("<option value=''>- ��ѡ�� -</option>");		
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
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="baseInfo_saveLaneInfo.do">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">             
			    	 <tr>
						<td class="pn-flabel pn-flabel-h">�������ƣ�</td>
						<td class="pn-fcontent">
						<select id="laneInformation_areaNo" class="required " name="laneInformation.areaNo" style="width: 206px;height: 22px;" onchange="getPark();">
						</select><span style="color: red">&nbsp;*</span></td>
						
						<td class="pn-flabel pn-flabel-h">С�����ƣ�</td>
						<td class="pn-fcontent">
						<select id="laneInformation_parkNo" class="required " name="laneInformation.parkNo" style="width: 206px;height: 22px;" onchange="getGate();">
							<option value="">- ��ѡ�� -</option>
						</select><span style="color: red">&nbsp;*</span></td>
						</tr>
			    	<tr>
						<td class="pn-flabel pn-flabel-h">�������ƣ�</td>
						<td class="pn-fcontent">
						<select id="laneInformation_gateNo" class="required " name="laneInformation.gateNo" style="width: 206px;height: 22px;">
							<option value="">- ��ѡ�� -</option>
						</select><span style="color: red">&nbsp;*</span></td>
						<td class="pn-flabel pn-flabel-h">�������ͣ�</td>
						<td class="pn-fcontent"><c:if test="${laneInformation.laneTypeNo==null}">
						<select class="required " name="laneInformation.laneTypeNo" style="width: 206px;height: 22px;">
						   <option value="" selected="selected">- ��ѡ�� -</option>
			               <option value="1">���</option>
			               <option value="2">����</option>		          
		                </select>
		                </c:if>
		                <c:if test="${laneInformation.laneTypeNo==1}">
						<select class="required " name="laneInformation.laneTypeNo" style="width: 206px;height: 22px;">
						   <option value="" >- ��ѡ�� -</option>
			               <option value="1" selected="selected">���</option>
			               <option value="2">����</option>			          
		                </select>
		                </c:if>
		                 <c:if test="${laneInformation.laneTypeNo==2}">
						<select class="required " name="laneInformation.laneTypeNo" style="width: 206px;height: 22px;">
						   <option value="" >- ��ѡ�� -</option>
			               <option value="1">���</option>
			               <option value="2" selected="selected">����</option>			          
		                </select>
		                </c:if><span style="color: red">*</span></td>
						</tr>	
			    	
					<tr>
						<td class="pn-flabel pn-flabel-h">�������룺</td>
						<td class="pn-fcontent"><input id="laneNo" type="text" class="required isNo_NotOverValue" name="laneInformation.laneNo" value="${laneInformation.laneNo}" size="28" onblur="ishasLaneNo();"/><span style="color: red">&nbsp;*</span></td>
			    		<td class="pn-flabel pn-flabel-h">���������</td>
						<td class="pn-fcontent"><input type="text" class="maxlength16" name="laneInformation.laneComputerName" value="${laneInformation.laneComputerName}" size="28"/></td>
						</tr>
					<tr>	
						<td class="pn-flabel pn-flabel-h">�����IP��ַ��</td>
						<td class="pn-fcontent"><input type="text" class="required isIP" id="laneIP" name="laneInformation.laneComputerIp" value="${laneInformation.laneComputerIp}" size="28"/><span style="color: red">&nbsp;*</span></td>
						<td class="pn-flabel pn-flabel-h">���úϼƣ�</td>
						<td class="pn-fcontent">
							<select class="required " name="laneInformation.isUse" style="width: 206px;height: 22px;">
				               <option value="1" selected="selected">����</option>
				               <option value="0">������</option>			          
			                </select>
							<span style="color: red">&nbsp;*</span>
						</td>
					 <%-- 
						<td colspan="4"  class="pn-fcontent"><input type="text" class="required isIP" id="laneIP" name="laneInformation.laneComputerIp" value="${laneInformation.laneComputerIp}" size="28" onblur="ishasLaneIP()"/><span style="color: red">&nbsp;*</span></td>
					 --%>
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
	//�����������������б�
	jsonrpc = new JSONRpcClient("JSON-RPC");//JSON-RPC ��Ӧweb.xml�����URL

	var result1 = jsonrpc.ajax.getAreaNo_AreaName();
	for (var i=0;i<result1.length;i++){
		option =document.createElement("OPTION");
		option.value = result1[i][0];
		option.text = result1[i][1];
		document.getElementById("laneInformation_areaNo").options.add(option);
	}
	//����С�����������б�
	//var result2 = jsonrpc.ajax.getParkNo_ParkName();
	//for (var i=0;i<result2.length;i++){
		//option =document.createElement("OPTION");
		//option.value = result2[i][0];
		//option.text = result2[i][1];
		//document.getElementById("laneInformation_parkNo").options.add(option);
	//}
	//����������������б�
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