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
		<title>添加车道费率</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<%@include file="../include/common.jsp" %>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<!-- 引入jsonrpc.js -->
		<script type="text/javascript" src="${basePath}/js/jsonrpc.js"></script>
		<script type="text/javascript">
		if("${message}"=="hasPriceRule"){
			alert("已存在该车道费率！");
		    }
		function back(){
			window.location.href = "priceRule_list.do";
		}
		function check(){
			if(document.getElementById('priceRule_endRange').value != ""){
				var max = document.getElementById('priceRule_endRange').value;
				var min = document.getElementById('priceRule_startRange').value;
				if(parseInt(min) > parseInt(max)){
					alert("最小时间不能大于最大时间");
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
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="priceRule_savePriceRule.do" onsubmit="return check();">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
                    <tr>
						<td class="pn-flabel pn-flabel-h">小区名称：</td><!--实际取值 是小区编码，显示小区名称 -->
						<td class="pn-fcontent"><select class="required " id="priceRule_parkNo" name="priceRule.parkNo" style="width: 206px;height: 22px;">
						</select><span style="color: red">&nbsp;*</span></td>
			    		<td class="pn-flabel pn-flabel-h">车&nbsp;&nbsp;&nbsp;&nbsp;型：</td>
						<td class="pn-fcontent"><select style="width: 206px;height: 22px;"  class="required " name="priceRule.vehTypeNo">
						<option value="">- 请选择 -</option>
						<option value="1">摩托车</option>
						<option value="2">小车</option>
						<option value="3">大型车</option>
						<option value="4">超大型车</option>
						</select><span style="color: red">&nbsp;*</span></td>
						</tr>
					<tr>
						 <td class="pn-flabel pn-flabel-h">最小时间：</td>
						<td class="pn-fcontent"><input type="text" class="required isNo_NotOverValueInt" id="priceRule_startRange" name="priceRule.startRange" value="${priceRule.startRange}" size="28"/><span style="color: red">&nbsp;*</span></td>
						<td class="pn-flabel pn-flabel-h">收费类型：</td>
						<td class="pn-fcontent">
						<select style="width: 206px;height: 22px;"  class="required " name="priceRule.feeTypeNo">
						<%--  <option value="1">正常收费</option>
						<option value="2">无卡收费</option>
						<option value="3">异门收费</option>
						<option value="4">优惠收费</option>
						--%>
						<option value="2">同门收费</option>
						<option value="3">异门收费</option>
						<option value="4">优惠收费</option>
						</select><span style="color: red">&nbsp;*</span></td>
					   </tr>
	     			<tr>
						<td class="pn-flabel pn-flabel-h">最大时间：</td>
						<td class="pn-fcontent"><input type="text" class="isNo_NotOverValueInt" id="priceRule_endRange" name="priceRule.endRange" value="${priceRule.endRange}" size="28"/></td>
						<td class="pn-flabel pn-flabel-h">时间基数：</td>
						<td class="pn-fcontent"><input type="text" class="isNo_NotOverValueInt" name="priceRule.allowStay" value="${priceRule.allowStay}" size="28"/></td>
					</tr>	
					<tr>
						<td class="pn-flabel pn-flabel-h">收费基数：</td>
						<td class="pn-fcontent"><input type="text" class="isNo_NotOverValueInt" name="priceRule.baseFee" value="${priceRule.baseFee}" size="28"/></td>
						<td class="pn-flabel pn-flabel-h">时间间隔：</td>
						<td class="pn-fcontent"><input type="text" class="isNo_NotOverValueInt" name="priceRule.stayAdd" value="${priceRule.stayAdd}" size="28"/></td>
					</tr>	
					<tr>
						<td class="pn-flabel pn-flabel-h">收费增量：</td>
						<td class="pn-fcontent"><input type="text" class="isNo_NotOverValueInt" name="priceRule.addFee" value="${priceRule.addFee}" size="28"/></td>
						<td class="pn-flabel pn-flabel-h">最大费率：</td>
						<td class="pn-fcontent"><input type="text" class="isNo_NotOverValueInt" name="priceRule.maxFee" value="${priceRule.maxFee}" size="28"/></td>
					</tr>	
					<tr>
						<td class="pn-flabel pn-flabel-h">启用时间：</td>
						<td class="pn-fcontent"><input size="28" type="text" class="required "  name="priceRule.startTime" value="<fmt:formatDate value="${priceRule.startTime }" pattern="yyyy-MM-dd HH:mm:ss" />" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})""/><span style="color: red">&nbsp;*</span></td>
					    <td class="pn-flabel pn-flabel-h">备&nbsp;&nbsp;&nbsp;&nbsp;用：</td>
						<td class="pn-fcontent"><input type="text" class=" isNo_NotOverValueInt" name="priceRule.backUp1" value="${priceRule.backUp1}" size="28"/></td>
					</tr>	
					<tr>
						<td class="pn-flabel pn-flabel-h">版本号：</td>
						<td colspan="4"  class="pn-fcontent"><input type="text" class="required versonNoFormat" name="priceRule.verNo" value="${priceRule.verNo}" size="28"/><span style="color: red">&nbsp;*</span></td>
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
	//构造区域编码下拉列表
	jsonrpc = new JSONRpcClient("JSON-RPC");//JSON-RPC 对应web.xml里面的URL
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