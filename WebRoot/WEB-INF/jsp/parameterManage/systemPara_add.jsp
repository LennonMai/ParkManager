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
		 if("${message}"=="hasSystemPara"){
			alert("�Ѵ��ڸ�ϵͳ������");
		    }
        //������ҳ
		function back(){
			window.location.href = "systemPara_list.do";
			}
		//��ѡ��"������"ʱ�����������������Ч
        function checkDisabled(){
			if(get("systemPara.paraClass").value=="-1"){
				get("systemPara_groupName").value="";
				get("systemPara_groupName").disabled=true ;
			}else{
				get("systemPara_groupName").disabled=false ;
			}
			
			if(get("systemPara.paraClass").value=="1"){
				get("systemPara_sendControl").disabled=false ;
			}else{
				get("systemPara_sendControl").value="";
				get("systemPara_sendControl").disabled=true ;
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
			<form id="dataform" method="post" action="systemPara_saveSystemPara.do" >
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<tr>
						<td class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;&nbsp;&nbsp;����</td>
						<td class="pn-fcontent"><input type="text" class="required maxlength32" name="systemPara.item" value="${systemPara.item}" size="24"/><span style="color: red">&nbsp;*</span></td>
					  	<td class="pn-flabel pn-flabel-h">�������ͣ�</td>
						<td class="pn-fcontent">
						<select class="required " name="systemPara.paraClass" style="display;  width: 180px;height: 24px;" onchange='checkDisabled();'>
						   <option value="" >- ��ѡ�� -</option>
						   <option value="-1" >������</option>
						   <option value="0">ȫ�ֲ���</option>
						   <option value="1">�·�����</option>
						   <option value="2">���������</option>
						</select><span style="color: red">&nbsp;*</span></td>
						</tr>
						
	     			<tr>
						<!-- ���ѡ�����-1(ϵͳ����)��������������������ظ����ѡ��-->
					    <!-- ���ѡ��Ĳ���-1(ϵͳ����)������Ҫѡ��������--> 
					   
					    <td class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;&nbsp;&nbsp;ֵ��</td>
						<td class="pn-fcontent"><input type="text" class="required  maxlength100"  name="systemPara.itemValue" value="${systemPara.itemValue}" size="24"/><span style="color: red">&nbsp;*</span></td>
					    <td class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
						<td class="pn-fcontent">
						<select class="required " id="systemPara_groupName" name="systemPara.groupName" style="width: 180px;height: 22px;">
						</select><span style="color: red">&nbsp;*</span></td>
					   
					</tr>
					<tr>
					    <td class="pn-flabel pn-flabel-h">�����·����ƣ�</td>
					    <td colspan="4" class="pn-fcontent">
						<select class="required " id="systemPara_sendControl" name="systemPara.sendControl" style="width: 178px;height: 22px;">
						   <option value="" selected="selected">- ��ѡ�� -</option>
						   <option value="0">���·�</option>
						   <option value="1">��Ч�·�</option>
						</select><span style="color: red">&nbsp;*</span></td>
					   
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
	jsonrpc = new JSONRpcClient("JSON-RPC");//JSON-RPC ��Ӧweb.xml�����URL
	var result = jsonrpc.ajax.getGroupName();
	for (var i=0;i<result.length;i++){
		option =document.createElement("OPTION");
		option.value = result[i][0];
		option.text = result[i][1];
		document.getElementById("systemPara_groupName").options.add(option);
	}
</script>
	</body>
</html>