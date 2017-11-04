<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
	<head>
		<title>修改出入口标志信息</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
			<%@include file="../../include/common.jsp" %>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<script type="text/javascript">
		
		function back(){
			window.location.href = "zjuPriceConfig_inOutSignDef_list.do";
		}
		function compute(){
			if(document.getElementById('inOutSignDef_inGateNo').value==document.getElementById('inOutSignDef_outGateNo').value){
				document.getElementById('inOutSignDef_inOutSign').value='0';
			}else{
				document.getElementById('inOutSignDef_inOutSign').value='1';
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
			<form id="dataform" method="post" action="zjuPriceConfig_updateInOutSignDef.do" >
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<tr>
						<td class="pn-flabel pn-flabel-h">入口大门编号：</td>
						<td style="width: 430px;" class="pn-fcontent">${inOutSignDef.inGateNo}<input id="inOutSignDef_inGateNo" type="hidden" name="inOutSignDef.inGateNo" value="${inOutSignDef.inGateNo}" size="24" onblur="compute();"/></td>
						<td class="pn-flabel pn-flabel-h">出口大门编号：</td>
						<td style="width: 430px;" class="pn-fcontent">${inOutSignDef.outGateNo}<input id="inOutSignDef_outGateNo" type="hidden" name="inOutSignDef.outGateNo" value="${inOutSignDef.outGateNo}" size="24" onblur="compute();"/></td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">进出口标志：</td>
						<td style="width: 430px;" colspan="3" style="width: 430px;" class="pn-fcontent">
						<c:if test="${inOutSignDef.inOutSign==0}">同门</c:if>
						<c:if test="${inOutSignDef.inOutSign==1}">异门</c:if>
						<input id="inOutSignDef_inOutSign"  type="hidden" name="inOutSignDef.inOutSign" value="${inOutSignDef.inOutSign}" size="24" readonly="readonly"/></td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">备&nbsp;&nbsp;注：</td>
						<td colspan="3"  class="pn-fcontent">
						<textarea class="maxlength16" name="inOutSignDef.remark" rows="3" cols="52">${inOutSignDef.remark}</textarea></td>
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
	</body>
</html>