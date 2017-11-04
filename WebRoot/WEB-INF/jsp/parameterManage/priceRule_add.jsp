<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- ʹ��JavaBean ����jsonrpc.jar -->
<jsp:useBean id="JSONRPCBridge" scope="session" class="com.metaparadigm.jsonrpc.JSONRPCBridge"/>
<jsp:useBean id="ajax" class="com.hgsoft.util.AjaxBean"></jsp:useBean>
<%
	JSONRPCBridge.registerObject("ajax",ajax);
%>
<html>
	<head>
		<title>��ӳ�������</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<%@include file="../include/common.jsp" %>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<!-- ����jsonrpc.js -->
		<script type="text/javascript" src="${basePath}/js/jsonrpc.js"></script>
		<script type="text/javascript">
		if("${message}"=="hasPriceRule"){
			alert("�Ѵ��ڸó������ʣ�");
		    }
		function back(){
			window.location.href = "priceRule_list.do";
		}
		function check(){
			if(document.getElementById('priceRule_endRange').value != ""){
				var max = document.getElementById('priceRule_endRange').value;
				var min = document.getElementById('priceRule_startRange').value;
				if(parseInt(min) > parseInt(max)){
					alert("��Сʱ�䲻�ܴ������ʱ��");
					return false;
				}
			}
			return true;
		}		
		</script>

	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="priceRule_savePriceRule.do" onsubmit="return check();">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
                    <tr>
						<td class="pn-flabel pn-flabel-h">С�����ƣ�</td><!--ʵ��ȡֵ ��С�����룬��ʾС������ -->
						<td class="pn-fcontent"><select class="required " id="priceRule_parkNo" name="priceRule.parkNo" style="width: 206px;height: 22px;">
						</select><span style="color: red">&nbsp;*</span></td>
			    		<td class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;&nbsp;&nbsp;�ͣ�</td>
						<td class="pn-fcontent"><select style="width: 206px;height: 22px;"  class="required " name="priceRule.vehTypeNo">
						<option value="">- ��ѡ�� -</option>
						<option value="1">Ħ�г�</option>
						<option value="2">С��</option>
						<option value="3">���ͳ�</option>
						<option value="4">�����ͳ�</option>
						</select><span style="color: red">&nbsp;*</span></td>
						</tr>
					<tr>
						 <td class="pn-flabel pn-flabel-h">��Сʱ�䣺</td>
						<td class="pn-fcontent"><input type="text" class="required isNo_NotOverValueInt" id="priceRule_startRange" name="priceRule.startRange" value="${priceRule.startRange}" size="28"/><span style="color: red">&nbsp;*</span></td>
						<td class="pn-flabel pn-flabel-h">�շ����ͣ�</td>
						<td class="pn-fcontent">
						<select style="width: 206px;height: 22px;"  class="required " name="priceRule.feeTypeNo">
						<%--  <option value="1">�����շ�</option>
						<option value="2">�޿��շ�</option>
						<option value="3">�����շ�</option>
						<option value="4">�Ż��շ�</option>
						--%>
						<option value="2">ͬ���շ�</option>
						<option value="3">�����շ�</option>
						<option value="4">�Ż��շ�</option>
						</select><span style="color: red">&nbsp;*</span></td>
					   </tr>
	     			<tr>
						<td class="pn-flabel pn-flabel-h">���ʱ�䣺</td>
						<td class="pn-fcontent"><input type="text" class="isNo_NotOverValueInt" id="priceRule_endRange" name="priceRule.endRange" value="${priceRule.endRange}" size="28"/></td>
						<td class="pn-flabel pn-flabel-h">ʱ�������</td>
						<td class="pn-fcontent"><input type="text" class="isNo_NotOverValueInt" name="priceRule.allowStay" value="${priceRule.allowStay}" size="28"/></td>
					</tr>	
					<tr>
						<td class="pn-flabel pn-flabel-h">�շѻ�����</td>
						<td class="pn-fcontent"><input type="text" class="isNo_NotOverValueInt" name="priceRule.baseFee" value="${priceRule.baseFee}" size="28"/></td>
						<td class="pn-flabel pn-flabel-h">ʱ������</td>
						<td class="pn-fcontent"><input type="text" class="isNo_NotOverValueInt" name="priceRule.stayAdd" value="${priceRule.stayAdd}" size="28"/></td>
					</tr>	
					<tr>
						<td class="pn-flabel pn-flabel-h">�շ�������</td>
						<td class="pn-fcontent"><input type="text" class="isNo_NotOverValueInt" name="priceRule.addFee" value="${priceRule.addFee}" size="28"/></td>
						<td class="pn-flabel pn-flabel-h">�����ʣ�</td>
						<td class="pn-fcontent"><input type="text" class="isNo_NotOverValueInt" name="priceRule.maxFee" value="${priceRule.maxFee}" size="28"/></td>
					</tr>	
					<tr>
						<td class="pn-flabel pn-flabel-h">����ʱ�䣺</td>
						<td class="pn-fcontent"><input size="28" type="text" class="required "  name="priceRule.startTime" value="<fmt:formatDate value="${priceRule.startTime }" pattern="yyyy-MM-dd HH:mm:ss" />" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})""/><span style="color: red">&nbsp;*</span></td>
					    <td class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;&nbsp;&nbsp;�ã�</td>
						<td class="pn-fcontent"><input type="text" class=" isNo_NotOverValueInt" name="priceRule.backUp1" value="${priceRule.backUp1}" size="28"/></td>
					</tr>	
					<tr>
						<td class="pn-flabel pn-flabel-h">�汾�ţ�</td>
						<td colspan="4"  class="pn-fcontent"><input type="text" class="required versonNoFormat" name="priceRule.verNo" value="${priceRule.verNo}" size="28"/><span style="color: red">&nbsp;*</span></td>
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
	var result = jsonrpc.ajax.getParkNo_ParkName();
	for (var i=0;i<result.length;i++){
		option =document.createElement("OPTION");
		option.value = result[i][0];
		option.text = result[i][1];
		document.getElementById("priceRule_parkNo").options.add(option);
	}
</script>
	</body>
</html>