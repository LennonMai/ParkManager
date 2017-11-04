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
		<title>������ó���</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/jquery.js"></script>
			<%@include file="../../include/common.jsp" %>
		<!-- ����jsonrpc.js -->
		<script type="text/javascript" src="${basePath}/js/jsonrpc.js"></script>
		<script type="text/javascript">
		
		//��֤���ó��������Ƿ����
	    function ishasLaneUseNo() {
	    	var laneUseNo = $("#laneUseNo").val();
	    	jQuery.post("baseInfo_ishasLaneUseNo.do?laneUse.laneNo="+laneUseNo, function(data){
	    		if(data == "hasLaneUseNo") {
	    			alert("���ó��������Ѵ��ڣ�");
	    			$("#laneUseNo").val("");
		    		$("#laneUseNo").focus();
	    		}	
	    	});
	    }
		
	    //��֤���ó���IP�Ƿ����
	    function ishasLaneUseIP() {
	    	var laneUseIP = $("#laneUseIP").val();
	    	jQuery.post("baseInfo_ishasLaneUseIP.do?laneUse.laneComputerIp="+laneUseIP, function(data){
	    		if(data == "hasLaneUseIP") {
	    			alert("�����IP��ַ�Ѵ��ڣ�");
	    			$("#laneUseIP").val("");
		    		$("#laneUseIP").focus();
	    		}	
	    	});
	    }
		
			function back(){
				window.location.href = "baseInfo_laneUse_list.do";
			}
			//��ȡС��
			function ajaxInitPark(){
			  (function($) { 
  			   $(function() {
				$.ajax({
					type:"post",
					url:"baseInfo_ajaxInitPark.do?areaNo="+document.getElementById('laneUse_areaNo').value,
					success:function(res){
						$("#laneUse_parkNo").empty();
						var op = $("<option value=''>- ��ѡ�� -</option>");		
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
			//��ȡ����
			function ajaxInitGate(){
			(function($) { 
  				$(function() {
				$.ajax({
					type:"post",
					url:"baseInfo_ajaxInitGate.do?parkNo="+document.getElementById('laneUse_parkNo').value,
					success:function(res){
						$("#laneUse_gateNo").empty();
						var op = $("<option value=''>- ��ѡ�� -</option>");		
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
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="baseInfo_saveLaneUse.do">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">             
			    	 <tr>
						<td class="pn-flabel pn-flabel-h">�������ƣ�</td>
						<td class="pn-fcontent">
						<select id="laneUse_areaNo" class="required " name="laneUse.areaNo" style="width: 206px;height: 22px;" onchange="ajaxInitPark();">
						</select><span style="color: red">&nbsp;*</span></td>
						
						<td class="pn-flabel pn-flabel-h">С�����ƣ�</td>
						<td class="pn-fcontent">
						<select id="laneUse_parkNo" class="required " name="laneUse.parkNo" style="width: 206px;height: 22px;" onchange="ajaxInitGate();">
							<option value="">- ��ѡ�� -</option>
						</select><span style="color: red">&nbsp;*</span></td>
						</tr>
			    	<tr>
						<td class="pn-flabel pn-flabel-h">�������ƣ�</td>
						<td class="pn-fcontent">
						<select id="laneUse_gateNo" class="required " name="laneUse.gateNo" style="width: 206px;height: 22px;">
							<option value="">- ��ѡ�� -</option>
						</select><span style="color: red">&nbsp;*</span></td>
						<td class="pn-flabel pn-flabel-h">�������룺</td>
						<td class="pn-fcontent"><input id="laneUseNo" type="text" class="required isNo_NotOverValue" name="laneUse.laneNo" value="${laneUse.laneNo}" size="28" onblur="ishasLaneUseNo();"/><span style="color: red">&nbsp;*</span></td>
			    	</tr>	
			    	
					<tr>
					<td class="pn-flabel pn-flabel-h">�Ƿ����ã�</td>
						<td class="pn-fcontent">
						<select class="required " name="laneUse.isUse" style="width: 206px;height: 22px;">
						   <option value="" selected="selected">- ��ѡ�� -</option>
			               <option value="0">������</option>
			               <option value="1">����</option>		          
		                </select><span style="color: red">*</span></td>
						<td class="pn-flabel pn-flabel-h">�����IP��ַ��</td>
						<td class="pn-fcontent"><input type="text" class="required isIP" id="laneUseIP" name="laneUse.laneComputerIp" value="${laneUse.laneComputerIp}" size="28" onblur="ishasLaneUseIP()"/><span style="color: red">&nbsp;*</span></td>
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
		document.getElementById("laneUse_areaNo").options.add(option);
	}

</script>	
	</body>
</html>