<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
	<head>
		<title>����շ�����Ӱ��</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<%@include file="../include/common.jsp" %>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<script type="text/javascript">
			if("${message}"=="hasPricepasstype"){
				alert("�Ѵ��ڸ��շ�����Ӱ��");
		    }
			function back(){
				window.location.href = "pricepasstype_list.do";
			}
		</script>
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="pricepasstype_savePricepasstype.do">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<tr>
						<td class="pn-flabel pn-flabel-h">С����ţ�</td>
						<td class="pn-fcontent"><input type="text" class="required isNo_smallint" name="pricepasstype.parkNo" value="${pricepasstype.parkNo}" size="28"/><span style="color: red">&nbsp;*</span></td>
						<td class="pn-flabel pn-flabel-h">��ڴ��źţ�</td>
						<td class="pn-fcontent"><input type="text" class="required isNo_smallint" name="pricepasstype.inGateNo" value="${pricepasstype.inGateNo}" size="28"/><span style="color: red">&nbsp;*</span></td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">���ڴ��źţ�</td>
						<td class="pn-fcontent"><input type="text" class="required isNo_smallint" name="pricepasstype.outGateNo" value="${pricepasstype.outGateNo}" size="28"/><span style="color: red">&nbsp;*</span></td>
						<td class="pn-flabel pn-flabel-h">�汾�ţ�</td>
						<td class="pn-fcontent"><input type="text" class="required isNo_smallint" name="pricepasstype.verNo" value="${pricepasstype.verNo}" size="28"/><span style="color: red">&nbsp;*</span></td>
					</tr>
	     			<tr>
					    <td class="pn-flabel pn-flabel-h">�շ����ͣ�</td>
						<td colspan="4" class="pn-fcontent">
							<select style="width: 206px;height: 22px;"  class="required " name="pricepasstype.feeType">
								<option value="">- ��ѡ�� -</option>
								<option value="2" <c:if test="${pricepasstype.feeType==2}">selected="selected"</c:if>>ͬ��</option>
								<option value="3" <c:if test="${pricepasstype.feeType==3}">selected="selected"</c:if>>����</option>
								<option value="4" <c:if test="${pricepasstype.feeType==4}">selected="selected"</c:if>>�Żݳ�</option>
							</select><span style="color: red">&nbsp;*</span>
						</td>
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