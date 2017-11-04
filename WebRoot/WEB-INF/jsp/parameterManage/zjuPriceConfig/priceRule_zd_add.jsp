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
		<title>添加费率规则</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<%@include file="../../include/common.jsp" %>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<!-- 引入jsonrpc.js -->
		<script type="text/javascript" src="${basePath}/js/jsonrpc.js"></script>
		<script type="text/javascript">
		if("${message}"=="hasPriceRule_zd"){
			alert("已存在该费率规则！");
		    }
		function back(){
			window.location.href = "zjuPriceConfig_priceRule_zd_list.do";
			}
		</script>

	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="zjuPriceConfig_savePriceRule_zd.do" >
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<tr>
						<td class="pn-flabel pn-flabel-h">收费类型：</td>
						<td class="pn-fcontent">
						<!--<input type="text" class="required isNo_NotOverValueInt" name="priceRule_zd.feeRuleType" value="${priceRule_zd.feeRuleType}" size="24"/><span style="color: red">&nbsp;*</span>
						--><select class="required " id="priceRule_zd_feeRuleType" name="priceRule_zd.feeRuleType" style="width: 178px;height: 22px;">
						</select><span style="color: red">&nbsp;*</span></td>
						<td class="pn-flabel pn-flabel-h">车&nbsp;&nbsp;&nbsp;&nbsp;型：</td>
						<td class="pn-fcontent"><select class="required " style="width: 178px;height: 22px;" name="priceRule_zd.vehTypeNo">
						<option value="">- 请选择 -</option>
						<option value="1">摩托车</option>
						<option value="2">小车</option>
						<option value="3">大中型车</option>
						
						</select><span style="color: red">&nbsp;*</span></td></tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">收费金额：</td>
						<td class="pn-fcontent"><input type="text" class=" isNo_NotOverValueInt" name="priceRule_zd.feeOfOneCycle" value="${priceRule_zd.feeOfOneCycle}" size="24"/>（分）<span style="color: red">&nbsp;*</span></td>
					    <td class="pn-flabel pn-flabel-h">免费次数：</td>
						<td  class="pn-fcontent"><input type="text" class=" isNo_NotOverValueInt" name="priceRule_zd.freeTimes" value="${priceRule_zd.freeTimes}" size="24"/><span style="color: red">&nbsp;*</span></td>
						</tr>
					<tr>
					    <td class="pn-flabel pn-flabel-h">生效时间是否取整：</td>
						<td class="pn-fcontent">
							<select name="priceRule_zd.validateTrim"  class=" isNo_NotOverValueInt" style="width: 178px;height: 22px;">
								<option value="">- 请选择 -</option>
								<option value="0">0-不取整 </option>
								<option value="1">1-取整 </option>
							</select>
						</td>
					    <td class="pn-flabel pn-flabel-h">失效时间是否取整 ：</td>
						<td class="pn-fcontent">
							<select name="priceRule_zd.invalidateTrim" class=" isNo_NotOverValueInt" style="width: 178px;height: 22px;">
								<option value="">- 请选择 -</option>
								<option value="0">0-不取整 </option>
								<option value="1">1-取整 </option>
							</select>
							</td>
					    </tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">每次使用免费次数：</td>
						<td class="pn-fcontent"><input type="text" class=" isNo_NotOverValueInt" name="priceRule_zd.maxFreeTimesUsedEveryTimes" value="${priceRule_zd.maxFreeTimesUsedEveryTimes}" size="24"/></td>
						<td class="pn-flabel pn-flabel-h">最大收费金额：</td>
						<td class="pn-fcontent"><input type="text" class=" isInt" name="priceRule_zd.maxTotalFee" value="${priceRule_zd.maxTotalFee}" size="24"/>（分）</td>
					</tr>
					<tr>
					    <td width="20%" class="pn-flabel pn-flabel-h">备&nbsp;&nbsp;注：</td>
						<td  colspan="3" width="80%" class="pn-fcontent">
						<textarea class="maxlength50 " name="priceRule_zd.remark" rows="3" cols="50">${priceRule_zd.remark}</textarea></td>
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
			<br />
			<div>说明：<br />
			&nbsp;&nbsp;&nbsp;&nbsp;生效时间是否(按计费周期)取整：外来车<strong>&nbsp;->&nbsp;</strong>不取整；白天校内车过夜收费<strong>&nbsp;->&nbsp;</strong>取&nbsp;&nbsp;整；夜间校内车白天收费<strong>&nbsp;->&nbsp;</strong>取整。<br />
			&nbsp;&nbsp;&nbsp;&nbsp;失效时间是否(按计费周期)取整：外来车<strong>&nbsp;->&nbsp;</strong>不取整；白天校内车过夜收费<strong>&nbsp;->&nbsp;</strong>不取整；夜间校内车白天收费<strong>&nbsp;->&nbsp;</strong>取整。
			<br />
			</div>
		</div>
		<script language="javascript">
	//构造收费类型下拉列表
	jsonrpc = new JSONRpcClient("JSON-RPC");//JSON-RPC 对应web.xml里面的URL
	
	var result = jsonrpc.ajax.getFeeRuleType_Name();
	for (var i=0;i<result.length;i++){
		option =document.createElement("OPTION");
		option.value = result[i][0];
		option.text = result[i][1];
		document.getElementById("priceRule_zd_feeRuleType").options.add(option);
	}
</script>
	</body>
</html>