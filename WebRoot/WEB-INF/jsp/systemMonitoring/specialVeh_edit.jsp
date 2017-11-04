<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
	<head>
		<title>特殊车辆管理</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<%@include file="../include/common.jsp" %>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		
		<script type="text/javascript">
		function back(){
			window.location.href = "specialVeh_list.do";
			}
		
		</script>

	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="specialVeh_update.do" >
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<tr>
						<td class="pn-flabel pn-flabel-h">车牌号：</td>
						<td style="width: 435px;" class="pn-fcontent"><input type="hidden" name="specialVeh.vehPlate" value="${specialVeh.vehPlate}" size="28" />${specialVeh.vehPlate}</td>
						<td  class="pn-flabel pn-flabel-h">特殊类型：</td>
						<td  class="pn-fcontent">
						<select class="required" id="specialVeh_specialType" name="specialVeh.specialType" style="width:178px;height: 22px;">
							<c:forEach items="${stList}" var="item">
								 <option value="${item.typeCode}" <c:if test="${item.typeCode==specialVeh.specialType}">selected="selected"</c:if>>${item.typeName}</option>
							</c:forEach>
						</select>
						</td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">卡&nbsp;&nbsp;号：</td>
						<td style="width: 435px;" class="pn-fcontent"><input type="hidden" name="specialVeh.cardNo" value="${specialVeh.cardNo}" size="28" />${specialVeh.cardNo}</td>
						<td  class="pn-flabel pn-flabel-h">车道类型：</td>
						<td  class="pn-fcontent">
						<select class="required" name="specialVeh.lanetype" style="width: 178px;height: 22px;;">
						   <option value="1" <c:if test="${specialVeh.lanetype==1}">selected="selected"</c:if>>入口</option>
						   <option value="2" <c:if test="${specialVeh.lanetype==2}">selected="selected"</c:if>>出口</option>
						   <option value="0" <c:if test="${specialVeh.lanetype==0}">selected="selected"</c:if>>出入口</option>
						</select>
					</td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">提示信息：</td>
						<td colspan="3" class="pn-fcontent">
						<textarea class="required maxlength24" name="specialVeh.info" rows="3" cols="40">${specialVeh.info}</textarea>
						<span style="color: red">&nbsp;*</span></td>
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