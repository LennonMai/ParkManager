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
		<title>添加基本费率</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<%@include file="../../include/common.jsp" %>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<!-- 引入jsonrpc.js -->
		<script type="text/javascript" src="${basePath}/js/jsonrpc.js"></script>
		<script type="text/javascript">
		if("${message}"=="haszju_PriceBase"){
			alert("已存在该费率！");
		    }
		function back(){
			window.location.href = "zjuPriceConfig_priceBase_list.do";
			}
		</script>

	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="zjuPriceConfig_savePriceBase.do" >
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					 <tr>
						<td class="pn-flabel pn-flabel-h">费率版本：</td>
						<td class="pn-fcontent"><input type="text" class="required versonNoFormat" name="zju_PriceBase.verNo" value="${zju_PriceBase.verNo}" size="24"/><span style="color: red">&nbsp;*</span></td>
					    <td class="pn-flabel pn-flabel-h">时间段标志：</td>
						<td class="pn-fcontent"><!--<input type="text" class="required isNo_NotOverValueInt" name="zju_PriceBase.timesSign" value="${zju_PriceBase.timesSign}" size="24"/>
					    -->
					    <select class="required " id="zju_PriceBase_timesSign" name="zju_PriceBase.timesSign" style="width: 178px;height: 22px;">
							<option value="">- 请选择 -</option>
							<option value="0">白天费率</option>
							<option value="1">夜间费率</option>
						</select><span style="color: red">&nbsp;*</span></td>
					   	</tr>
					 <tr>
					   	<td class="pn-flabel pn-flabel-h">优惠类型：</td>
						<td class="pn-fcontent"><!--<input type="text" class="required isNo_NotOverValueInt" name="zju_PriceBase.rebateType" value="${zju_PriceBase.rebateType}" size="24"/><span style="color: red">&nbsp;*</span>
						--><select class="required " id="zju_PriceBase.rebateType" name="zju_PriceBase.rebateType" style="width: 178px;height: 22px;">
						<option value="0">无优惠</option>
						</select><span style="color: red">&nbsp;*</span></td>
					   
					    <td class="pn-flabel pn-flabel-h">进出口标志：</td>
						<td class="pn-fcontent"><!--<input type="text" class="required isNo_NotOverValueInt" name="zju_PriceBase.inOutSign" value="${zju_PriceBase.inOutSign}" size="24"/>		
					    -->
					    <select class="required " id="zju_PriceBase_inOutSign" name="zju_PriceBase.inOutSign" style="width: 178px;height: 22px;">
							<option value="">- 请选择 -</option>
							<option value="0">同门</option>
							<option value="1">异门</option>
						</select><span style="color: red">&nbsp;*</span></td>
					 </tr>
					 <tr>
						<td class="pn-flabel pn-flabel-h">车&nbsp;&nbsp;&nbsp;&nbsp;型：</td>
						<td class="pn-fcontent"><select class="required " style="height: 22px;width: 178px;" name="zju_PriceBase.vehTypeNo">
						<option value="">- 请选择 -</option>
						<option value="1">摩托车</option>
						<option value="2">小车</option>
						<option value="3">大中型车</option>
						</select><span style="color: red">&nbsp;*</span></td>
					    <td class="pn-flabel pn-flabel-h">允许停留时间：</td>
						<td class="pn-fcontent"><input type="text" class=" isNo_NotOverValueInt" name="zju_PriceBase.allowStayTime" value="${zju_PriceBase.allowStayTime}" size="24"/>&nbsp;分钟</td>
					</tr>	
					<tr>
	     			    <td class="pn-flabel pn-flabel-h">首段停留时间：</td>
						<td class="pn-fcontent"><input type="text" class=" isNo_NotOverValueInt" name="zju_PriceBase.baseFeeTime" value="${zju_PriceBase.baseFeeTime}" size="24"/>&nbsp;分钟</td>
					    <td class="pn-flabel pn-flabel-h">首段收费金额：</td>
						<td class="pn-fcontent"><input type="text" class=" isNo_NotOverValueInt" name="zju_PriceBase.baseFee" value="${zju_PriceBase.baseFee}" size="24"/>&nbsp;分</td>
						</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">单位收费时间：</td>
						<td class="pn-fcontent"><input type="text" class="required isNo_NotOverValueInt" name="zju_PriceBase.stayAdd" value="${zju_PriceBase.stayAdd}" size="24"/>&nbsp;分钟<span style="color: red">&nbsp;*</span></td>
					    <td class="pn-flabel pn-flabel-h">单位收费金额：</td>
						<td class="pn-fcontent"><input type="text" class="required isNo_NotOverValueInt" name="zju_PriceBase.addFee" value="${zju_PriceBase.addFee}" size="24"/>&nbsp;分<span style="color: red">&nbsp;*</span></td>
					</tr>				
					<tr>
						<td class="pn-flabel pn-flabel-h">单位起算时间：</td>
						<td class="pn-fcontent"><input type="text" class=" isNo_NotOverValueInt" name="zju_PriceBase.addStart" value="${zju_PriceBase.addStart}" size="24"/>&nbsp;分钟</td>
						<td class="pn-flabel pn-flabel-h">最多收费金额：</td>
						<td class="pn-fcontent"><input type="text" class="required isNo_NotOverValueInt" name="zju_PriceBase.maxFee" value="${zju_PriceBase.maxFee}" size="24"/>&nbsp;分<span style="color: red">&nbsp;*</span></td>
		            </tr>    
					<tr>
						<td class="pn-flabel pn-flabel-h">最大停留时间：</td>
						<td class="pn-fcontent"><input type="text" class=" isNo_NotOverValueInt" name="zju_PriceBase.maxTime" value="${zju_PriceBase.maxTime}" size="24"/>&nbsp;分钟</td>
						<td class="pn-flabel pn-flabel-h">计算费率控制：</td>
						<td class="pn-fcontent"><input type="text" class=" isNo_NotOverValueInt" name="zju_PriceBase.sumFeeCtr" value="${zju_PriceBase.sumFeeCtr}" size="24"/></td>
					</tr>	
					<tr>
						<td class="pn-flabel pn-flabel-h">启&nbsp;用&nbsp;时&nbsp;间&nbsp;：</td>
						<td class="pn-fcontent"><input size="24" type="text" class="required " name="zju_PriceBase.startTime" value="<fmt:formatDate value="${zju_PriceBase.startTime }" pattern="yyyy-MM-dd HH:mm:ss" />" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})""/><span style="color: red">&nbsp;*</span></td>
				     	<td class="pn-flabel pn-flabel-h">周期最大收费时间：</td>
						<td class="pn-fcontent"><input type="text" class=" isNo_NotOverValueInt" name="zju_PriceBase.maxFeeTime" value="${zju_PriceBase.maxFeeTime}" size="24"/>&nbsp;分钟</td>
					
				    </tr> 
					<tr>
					    <td class="pn-flabel pn-flabel-h">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;用1&nbsp;：</td>
						<td class="pn-fcontent"><input type="text" class=" maxlength16"  name="zju_PriceBase.backup1" value="${zju_PriceBase.backup1}" size="24"/></td>
					    <td class="pn-flabel pn-flabel-h">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;用2&nbsp;：</td>
						<td class="pn-fcontent"><input type="text" class=" maxlength16"  name="zju_PriceBase.backup2" value="${zju_PriceBase.backup2}" size="24"/></td>
					   </tr>    						
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注&nbsp;&nbsp;：</td>
						<td colspan="3"  width="80%" class="pn-fcontent">
						<textarea class=" maxlength50"  name="zju_PriceBase.remark" rows="3" cols="50">${zju_PriceBase.remark}</textarea></td>
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
	
	/**jsonrpc = new JSONRpcClient("JSON-RPC");//JSON-RPC 对应web.xml里面的URL
	//构造时间标志下拉列表
	var result = jsonrpc.ajax.getTimesSign();
	for (var i=0;i<result.length;i++){
		option =document.createElement("OPTION");
		option.value = result[i][0];
		option.text = result[i][1];
		document.getElementById("zju_PriceBase_timesSign").options.add(option);
	}
	//构造出入口标志下拉列表
	var result = jsonrpc.ajax.getInOutSign();
	for (var i=0;i<result.length;i++){
		option =document.createElement("OPTION");
		option.value = result[i][0];
		option.text = result[i][1];
		document.getElementById("zju_PriceBase_inOutSign").options.add(option);
	}**/
</script>
	</body>
</html>