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
		<title>��Ӵ�����Ϣ</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/jquery.js"></script>
		<%@include file="../../include/common.jsp" %>
		<!-- ����jsonrpc.js -->
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
							alert("���ű����Ѵ��ڣ�");
						}
					});
					}
				else{//��������д��Ϊ99�����Դ��ű��벻��Ϊ99
					$("#gatewayInformation_gateNo").val("");
		    		$("#gatewayInformation_gateNo").focus();
		    		alert("�������[99]Ϊ���ű��룡");
					}
				
			}
			//caijunhua jquery�첽��֤���������Ƿ����
			function getGateByName() {
				var gateName = $("#gatewayInformation_gateName").val();
				jQuery.post("baseInfo_getGateByName.do?gatewayInformation.gateName="+gateName, function(data) {
					if(data == "fail") {
					    alert("���������Ѵ��ڣ�");
						$("#gatewayInformation_gateName").val("");
			    		$("#gatewayInformation_gateName").focus();
						
					}
				});
			}
			
			//��ȡС��
			function getPark(){
			  (function($) { 
  			   $(function() {
				$.ajax({
					type:"post",
					url:"lostCard_ajaxPark.do?areaNo="+document.getElementById('gatewayInformation_areaNo').value,
					success:function(res){
						$("#gatewayInformation_parkNo").empty();
						var op = $("<option value=''>- ��ѡ�� -</option>");		
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
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="baseInfo_saveGatewayInfo.do" >
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
                    <tr>
						<td class="pn-flabel pn-flabel-h">�������ƣ�</td>
						<td class="pn-fcontent">
						<select id="gatewayInformation_areaNo" class="required" name="gatewayInformation.areaNo" style="width: 208px;height: 22px;" onchange="getPark();">
						</select><span style="color: red">&nbsp;*</span></td>
						<td class="pn-flabel pn-flabel-h">С�����ƣ�</td>
						<td class="pn-fcontent">
						<select id="gatewayInformation_parkNo" class="required" name="gatewayInformation.parkNo" style="width: 208px;height: 22px;">
							<option value="">- ��ѡ�� -</option>
						</select><span style="color: red">&nbsp;*</span></td>
						</tr>
			    	<tr>
						<td class="pn-flabel pn-flabel-h">���ű��룺</td>
						<td class="pn-fcontent"><input type="text" id="gatewayInformation_gateNo" class="required isNo_NotOverValue" name="gatewayInformation.gateNo" value="${gatewayInformation.gateNo}" size="28" onblur="ishasGateNo();"/><span style="color: red">&nbsp;*</span></td>
			    		<td class="pn-flabel pn-flabel-h">�������ƣ�</td>
						<td class="pn-fcontent"><input id="gatewayInformation_gateName" type="text" class="required maxlength20" onblur="getGateByName();" name="gatewayInformation.gateName" value="${gatewayInformation.gateName}" size="28"/><span style="color: red">&nbsp;*</span></td>
			    		</tr>	
					<tr>
						<td class="pn-flabel pn-flabel-h">����ȫ�ƣ�</td>
						<td colspan="4"  class="pn-fcontent"><input type="text"  class="maxlength20"  name="gatewayInformation.gateAllName" value="${gatewayInformation.gateAllName}" size="28"/></td>
						</tr>
					<tr>	
						<td class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;ע��</td>
						<td colspan="4"  class="pn-fcontent">
							<textarea class="maxlength50" name="gatewayInformation.remark" rows="3" cols="40">${gatewayInformation.remark}</textarea>
						</td>
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
	//����������������б�
	jsonrpc = new JSONRpcClient("JSON-RPC");//JSON-RPC ��Ӧweb.xml�����URL
	var result1 = jsonrpc.ajax.getAreaNo_AreaName();
	for (var i=0;i<result1.length;i++){
		option =document.createElement("OPTION");
		option.value = result1[i][0];
		option.text = result1[i][1];
		//document.all.areaInformation_cityNo.options.add(option);
		document.getElementById("gatewayInformation_areaNo").options.add(option);
	}
	//����С�����������б�
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