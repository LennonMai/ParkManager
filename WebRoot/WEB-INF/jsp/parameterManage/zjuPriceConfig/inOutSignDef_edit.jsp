<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
	<head>
		<title>�޸ĳ���ڱ�־��Ϣ</title>
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
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="zjuPriceConfig_updateInOutSignDef.do" >
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<tr>
						<td class="pn-flabel pn-flabel-h">��ڴ��ű�ţ�</td>
						<td style="width: 430px;" class="pn-fcontent">${inOutSignDef.inGateNo}<input id="inOutSignDef_inGateNo" type="hidden" name="inOutSignDef.inGateNo" value="${inOutSignDef.inGateNo}" size="24" onblur="compute();"/></td>
						<td class="pn-flabel pn-flabel-h">���ڴ��ű�ţ�</td>
						<td style="width: 430px;" class="pn-fcontent">${inOutSignDef.outGateNo}<input id="inOutSignDef_outGateNo" type="hidden" name="inOutSignDef.outGateNo" value="${inOutSignDef.outGateNo}" size="24" onblur="compute();"/></td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">�����ڱ�־��</td>
						<td style="width: 430px;" colspan="3" style="width: 430px;" class="pn-fcontent">
						<c:if test="${inOutSignDef.inOutSign==0}">ͬ��</c:if>
						<c:if test="${inOutSignDef.inOutSign==1}">����</c:if>
						<input id="inOutSignDef_inOutSign"  type="hidden" name="inOutSignDef.inOutSign" value="${inOutSignDef.inOutSign}" size="24" readonly="readonly"/></td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;ע��</td>
						<td colspan="3"  class="pn-fcontent">
						<textarea class="maxlength16" name="inOutSignDef.remark" rows="3" cols="52">${inOutSignDef.remark}</textarea></td>
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
	</body>
</html>