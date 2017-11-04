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
		 if("${message}"=="hasSystemPara"){
			alert("已存在该系统参数！");
		    }
        //返回首页
		function back(){
			window.location.href = "systemPara_list.do";
			}
		//当选择"组别参数"时，设置组别下拉框无效
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
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="systemPara_saveSystemPara.do" >
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<tr>
						<td class="pn-flabel pn-flabel-h">键&nbsp;&nbsp;&nbsp;&nbsp;名：</td>
						<td class="pn-fcontent"><input type="text" class="required maxlength32" name="systemPara.item" value="${systemPara.item}" size="24"/><span style="color: red">&nbsp;*</span></td>
					  	<td class="pn-flabel pn-flabel-h">参数类型：</td>
						<td class="pn-fcontent">
						<select class="required " name="systemPara.paraClass" style="display;  width: 180px;height: 24px;" onchange='checkDisabled();'>
						   <option value="" >- 请选择 -</option>
						   <option value="-1" >组别参数</option>
						   <option value="0">全局参数</option>
						   <option value="1">下发参数</option>
						   <option value="2">卡管理参数</option>
						</select><span style="color: red">&nbsp;*</span></td>
						</tr>
						
	     			<tr>
						<!-- 如果选择的是-1(系统参数)，则是添加组别参数，隐藏该组别选项-->
					    <!-- 如果选择的不是-1(系统参数)，则需要选择组别参数--> 
					   
					    <td class="pn-flabel pn-flabel-h">键&nbsp;&nbsp;&nbsp;&nbsp;值：</td>
						<td class="pn-fcontent"><input type="text" class="required  maxlength100"  name="systemPara.itemValue" value="${systemPara.itemValue}" size="24"/><span style="color: red">&nbsp;*</span></td>
					    <td class="pn-flabel pn-flabel-h">组&nbsp;&nbsp;&nbsp;&nbsp;别：</td>
						<td class="pn-fcontent">
						<select class="required " id="systemPara_groupName" name="systemPara.groupName" style="width: 180px;height: 22px;">
						</select><span style="color: red">&nbsp;*</span></td>
					   
					</tr>
					<tr>
					    <td class="pn-flabel pn-flabel-h">参数下发控制：</td>
					    <td colspan="4" class="pn-fcontent">
						<select class="required " id="systemPara_sendControl" name="systemPara.sendControl" style="width: 178px;height: 22px;">
						   <option value="" selected="selected">- 请选择 -</option>
						   <option value="0">不下发</option>
						   <option value="1">有效下发</option>
						</select><span style="color: red">&nbsp;*</span></td>
					   
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
<script language="javascript">
	jsonrpc = new JSONRpcClient("JSON-RPC");//JSON-RPC 对应web.xml里面的URL
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