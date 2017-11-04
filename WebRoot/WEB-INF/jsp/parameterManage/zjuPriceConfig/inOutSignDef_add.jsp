<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
	<head>
		<title>添加出入口标志信息</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<%@include file="../../include/common.jsp" %>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<script type="text/javascript">

		//设置出入口大门编号变量
		var _inGateNo,_outGateNo;
		
		if("${message}"=="hasInOutSignDef"){
			alert("已存在该进出口标志信息！");
		    }
		function back(){
			window.location.href = "zjuPriceConfig_inOutSignDef_list.do";
		}
		function compute(){
			if(document.getElementById('inOutSignDef_inGateNo').value==document.getElementById('inOutSignDef_outGateNo').value){
				$("#inOutSignDef_inOutSign").val("0");
				document.getElementById('_inOutSign').innerHTML="同门";
				//document.getElementById('inOutSignDef_inOutSign').value='0';		
			}else{
				$("#inOutSignDef_inOutSign").val("1");
				document.getElementById('_inOutSign').innerHTML="异门";
				//document.getElementById('inOutSignDef_inOutSign').value='1';
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
			<form id="dataform" method="post" action="zjuPriceConfig_saveInOutSignDef.do">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<tr>
						<td class="pn-flabel pn-flabel-h">入口大门编号：</td>
						<td class="pn-fcontent"><input id="inOutSignDef_inGateNo" class="required isNo_NotOverValueInt" type="text" name="inOutSignDef.inGateNo" value="${inOutSignDef.inGateNo}" size="24" onblur="compute();"/><span style="color: red">&nbsp;*</span></td>
						<td class="pn-flabel pn-flabel-h">出口大门编号：</td>
						<td class="pn-fcontent"><input id="inOutSignDef_outGateNo" class="required isNo_NotOverValueInt" type="text" name="inOutSignDef.outGateNo" value="${inOutSignDef.outGateNo}" size="24" onblur="compute();"/><span style="color: red">&nbsp;*</span></td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">进出口标志：</td>
						<input id="inOutSignDef_inOutSign" type="hidden" name="inOutSignDef.inOutSign" value="${inOutSignDef.inOutSign}" size="24" readonly="readonly"/>
						<td id="_inOutSign" colspan="3"  class="pn-fcontent"></td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">备&nbsp;&nbsp;注：</td>
						<td colspan="3"  class="pn-fcontent">
						<textarea class="maxlength16" name="inOutSignDef.remark" rows="3" cols="52">${inOutSignDef.remark}</textarea></td>
					</tr>
					<tr>
						<td colspan="4" class="pn-fbutton">
							<input type="submit" value=" 保 存 " />&nbsp;
						    <input type="reset" value=" 重 置 "/>&nbsp;
						    <input type="button" value=" 返 回 " onclick="return back()"/>
						</td>
						    
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>