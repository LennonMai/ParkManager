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
		<title>���ϵͳ����</title>
		<%@include file="../include/common.jsp" %>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<!-- ����jsonrpc.js -->
		<script type="text/javascript" src="${basePath}/js/jsonrpc.js"></script>
		<script type="text/javascript">	
		function back(){
			window.location.href = "systemPara_list.do";
			}
		 
       </script>

	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="systemPara_updateSystemPara.do">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<tr>
						<td class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;&nbsp;&nbsp;����</td>
						<td class="pn-fcontent">${systemPara.item}<input readonly="readonly" type="hidden" name="systemPara.item" value="${systemPara.item}" size="24"/></td>
					  	<td class="pn-flabel pn-flabel-h">�������ͣ�</td>
						<td class="pn-fcontent">
							<c:if test="${systemPara.paraClass==-1}">
								<select name="systemPara.paraClass"
									style="width: 178px; height: 24px;" disabled="disabled"
									onfocus="this.defOpt=this.selectedIndex"
									onchange="this.selectedIndex=this.defOpt;">
									<option value="-1" selected="selected">
										������
									</option>
									<option value="0">
										ȫ�ֲ���
									</option>
									<option value="1">
										�·�����
									</option>
									<option value="2">
										���������
									</option>
								</select>
							</c:if>
							<c:if test="${systemPara.paraClass==0}">
								<select name="systemPara.paraClass"
									style="width: 178px; height: 24px;" disabled="disabled"
									onfocus="this.defOpt=this.selectedIndex"
									onchange="this.selectedIndex=this.defOpt;">
									<option value="-1">
										������
									</option>
									<option value="0" selected="selected">
										ȫ�ֲ���
									</option>
									<option value="1">
										�·�����
									</option>
									<option value="2">
										���������
									</option>
								</select>
							</c:if>
							<c:if test="${systemPara.paraClass==1}">
								<select name="systemPara.paraClass"
									style="width: 178px; height: 24px;" disabled="disabled"
									onfocus="this.defOpt=this.selectedIndex"
									onchange="this.selectedIndex=this.defOpt;">
									<option value="-1">
										������
									</option>
									<option value="0">
										ȫ�ֲ���
									</option>
									<option value="1" selected="selected">
										�·�����
									</option>
									<option value="2">
										���������
									</option>
								</select>
							</c:if>
							<c:if test="${systemPara.paraClass==2}">
								<select name="systemPara.paraClass"
									style="width: 178px; height: 24px;" disabled="disabled"
									onfocus="this.defOpt=this.selectedIndex"
									onchange="this.selectedIndex=this.defOpt;">
									<option value="-1">
										������
									</option>
									<option value="0">
										ȫ�ֲ���
									</option>
									<option value="1">
										�·�����
									</option>
									<option value="2" selected="selected">
										���������
									</option>
								</select>
							</c:if>
						</td>
					</tr>
						
	     			<tr>
					    <td class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;&nbsp;&nbsp;ֵ��</td>
						<td class="pn-fcontent"><input type="text" class="required  maxlength100"  name="systemPara.itemValue" value="${systemPara.itemValue}" size="24"/><span style="color: red">&nbsp;*</span></td>
					    <td class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
						<td class="pn-fcontent">
							<select id="systemPara_groupName"  name="systemPara.groupName" disabled="disabled" style="width: 178px;height: 24px;"onfocus="this.defOpt=this.selectedIndex" onchange="this.selectedIndex=this.defOpt;">
							   <option value="${systemPara.groupName}">${systemPara.groupName}</option>  
							</select>
						</td>
					</tr>
					<tr>
					   <td class="pn-flabel pn-flabel-h">�����·����ƣ�</td>
					    <td class="pn-fcontent">
					    <c:if test="${systemPara.paraClass==1}">
					    <select class="required " id="systemPara_sendControl" name="systemPara.sendControl" style="width: 178px;height: 22px;">
						   <option value="" <c:if test="${systemPara.sendControl==null}">selected="selected"</c:if> >- ��ѡ�� -</option>
						   <option value="0" <c:if test="${systemPara.sendControl==0}">selected="selected"</c:if> >���·�</option>
						   <option value="1" <c:if test="${systemPara.sendControl==1}">selected="selected"</c:if> >��Ч�·�</option>
						</select><span style="color: red">&nbsp;*</span>
					    </c:if>
					     <c:if test="${systemPara.paraClass!=1}">
					     <select disabled="disabled" id="systemPara_sendControl" name="systemPara.sendControl" style="width: 178px;height: 22px;">
						   <option value="" selected="selected">- ��ѡ�� -</option>
						   <option value="0">��</option>
						   <option value="1">��</option>
						</select>
					    </c:if>
						</td>
						<td class="pn-flabel pn-flabel-h">�� ˳ ��</td>
						<td class="pn-fcontent">${systemPara.itemOrder}<input readonly="readonly" type="hidden" size="24" name="systemPara.itemOrder" value="${systemPara.itemOrder}"></input></td>
						
					</tr>
					<tr>
						<td colspan="4" class="pn-fbutton">
							<input type="submit" value=" �� �� "/>&nbsp;
						    <input type="reset" value=" �� �� "/>&nbsp;
						    <input type="button" value=" �� �� " onclick="return back()"/>
						   	<input type="hidden" name="pager.pageSize" value="${pager.pageSize}" />
							<input type="hidden" name="pager.currentPage" value="${pager.currentPage }" />
						</td>
						    
					</tr>
				</table>
				<input type="hidden" name="systemPara.paraClass" value="${systemPara.paraClass }"/>
				<input type="hidden" name="systemPara.groupName" value="${systemPara.groupName }"/>
			</form>
		</div>
<script language="javascript">
	jsonrpc = new JSONRpcClient("JSON-RPC");//JSON-RPC ��Ӧweb.xml�����URL
	var result = jsonrpc.ajax.getGroupName();
	for (var i=0;i<result.length;i++){
		option =document.createElement("OPTION");
		//����"",����systemPara.groupName��ͬ��ѡ��
		//alert(get("systemPara.groupName").value+"--"+result[i][0]);
		if(get("systemPara.groupName").value!=result[i][0]&&result[i][0]!=""){
		option.value = result[i][0];
		option.text = result[i][1];
		document.getElementById("systemPara_groupName").options.add(option);
		}
	}
</script>
	</body>
</html>