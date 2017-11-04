<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 使用JavaBean 引入jsonrpc.jar -->
<jsp:useBean id="JSONRPCBridge" scope="session" class="com.metaparadigm.jsonrpc.JSONRPCBridge"/>
<jsp:useBean id="ajax" class="com.hgsoft.util.AjaxBean"></jsp:useBean>
<%
	JSONRPCBridge.registerObject("ajax",ajax);
%>
<html>
	<head>
		<title>添加系统参数</title>
		<%@include file="../include/common.jsp" %>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<!-- 引入jsonrpc.js -->
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
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="systemPara_updateSystemPara.do">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<tr>
						<td class="pn-flabel pn-flabel-h">键&nbsp;&nbsp;&nbsp;&nbsp;名：</td>
						<td class="pn-fcontent">${systemPara.item}<input readonly="readonly" type="hidden" name="systemPara.item" value="${systemPara.item}" size="24"/></td>
					  	<td class="pn-flabel pn-flabel-h">参数类型：</td>
						<td class="pn-fcontent">
							<c:if test="${systemPara.paraClass==-1}">
								<select name="systemPara.paraClass"
									style="width: 178px; height: 24px;" disabled="disabled"
									onfocus="this.defOpt=this.selectedIndex"
									onchange="this.selectedIndex=this.defOpt;">
									<option value="-1" selected="selected">
										组别参数
									</option>
									<option value="0">
										全局参数
									</option>
									<option value="1">
										下发参数
									</option>
									<option value="2">
										卡管理参数
									</option>
								</select>
							</c:if>
							<c:if test="${systemPara.paraClass==0}">
								<select name="systemPara.paraClass"
									style="width: 178px; height: 24px;" disabled="disabled"
									onfocus="this.defOpt=this.selectedIndex"
									onchange="this.selectedIndex=this.defOpt;">
									<option value="-1">
										组别参数
									</option>
									<option value="0" selected="selected">
										全局参数
									</option>
									<option value="1">
										下发参数
									</option>
									<option value="2">
										卡管理参数
									</option>
								</select>
							</c:if>
							<c:if test="${systemPara.paraClass==1}">
								<select name="systemPara.paraClass"
									style="width: 178px; height: 24px;" disabled="disabled"
									onfocus="this.defOpt=this.selectedIndex"
									onchange="this.selectedIndex=this.defOpt;">
									<option value="-1">
										组别参数
									</option>
									<option value="0">
										全局参数
									</option>
									<option value="1" selected="selected">
										下发参数
									</option>
									<option value="2">
										卡管理参数
									</option>
								</select>
							</c:if>
							<c:if test="${systemPara.paraClass==2}">
								<select name="systemPara.paraClass"
									style="width: 178px; height: 24px;" disabled="disabled"
									onfocus="this.defOpt=this.selectedIndex"
									onchange="this.selectedIndex=this.defOpt;">
									<option value="-1">
										组别参数
									</option>
									<option value="0">
										全局参数
									</option>
									<option value="1">
										下发参数
									</option>
									<option value="2" selected="selected">
										卡管理参数
									</option>
								</select>
							</c:if>
						</td>
					</tr>
						
	     			<tr>
					    <td class="pn-flabel pn-flabel-h">键&nbsp;&nbsp;&nbsp;&nbsp;值：</td>
						<td class="pn-fcontent"><input type="text" class="required  maxlength100"  name="systemPara.itemValue" value="${systemPara.itemValue}" size="24"/><span style="color: red">&nbsp;*</span></td>
					    <td class="pn-flabel pn-flabel-h">组&nbsp;&nbsp;&nbsp;&nbsp;别：</td>
						<td class="pn-fcontent">
							<select id="systemPara_groupName"  name="systemPara.groupName" disabled="disabled" style="width: 178px;height: 24px;"onfocus="this.defOpt=this.selectedIndex" onchange="this.selectedIndex=this.defOpt;">
							   <option value="${systemPara.groupName}">${systemPara.groupName}</option>  
							</select>
						</td>
					</tr>
					<tr>
					   <td class="pn-flabel pn-flabel-h">参数下发控制：</td>
					    <td class="pn-fcontent">
					    <c:if test="${systemPara.paraClass==1}">
					    <select class="required " id="systemPara_sendControl" name="systemPara.sendControl" style="width: 178px;height: 22px;">
						   <option value="" <c:if test="${systemPara.sendControl==null}">selected="selected"</c:if> >- 请选择 -</option>
						   <option value="0" <c:if test="${systemPara.sendControl==0}">selected="selected"</c:if> >不下发</option>
						   <option value="1" <c:if test="${systemPara.sendControl==1}">selected="selected"</c:if> >有效下发</option>
						</select><span style="color: red">&nbsp;*</span>
					    </c:if>
					     <c:if test="${systemPara.paraClass!=1}">
					     <select disabled="disabled" id="systemPara_sendControl" name="systemPara.sendControl" style="width: 178px;height: 22px;">
						   <option value="" selected="selected">- 请选择 -</option>
						   <option value="0">否</option>
						   <option value="1">是</option>
						</select>
					    </c:if>
						</td>
						<td class="pn-flabel pn-flabel-h">项 顺 序：</td>
						<td class="pn-fcontent">${systemPara.itemOrder}<input readonly="readonly" type="hidden" size="24" name="systemPara.itemOrder" value="${systemPara.itemOrder}"></input></td>
						
					</tr>
					<tr>
						<td colspan="4" class="pn-fbutton">
							<input type="submit" value=" 保 存 "/>&nbsp;
						    <input type="reset" value=" 重 置 "/>&nbsp;
						    <input type="button" value=" 返 回 " onclick="return back()"/>
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
	jsonrpc = new JSONRpcClient("JSON-RPC");//JSON-RPC 对应web.xml里面的URL
	var result = jsonrpc.ajax.getGroupName();
	for (var i=0;i<result.length;i++){
		option =document.createElement("OPTION");
		//过滤"",和与systemPara.groupName相同的选项
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