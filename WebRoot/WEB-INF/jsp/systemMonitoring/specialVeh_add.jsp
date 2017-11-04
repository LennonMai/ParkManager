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
		if("${message}"=="exitSpecialVeh"){
			alert("已存在该车牌号！");
			}
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
			<form id="dataform" method="post" action="specialVeh_save.do" >
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<tr>
						<td class="pn-flabel pn-flabel-h">车牌号：</td>
						<td class="pn-fcontent"><input type="text" class="required maxlength12"  name="specialVeh.vehPlate" value="${specialVeh.vehPlate}" size="28" /><span style="color: red">&nbsp;*</span></td>
						<td  class="pn-flabel pn-flabel-h">特殊类型：</td>
						<td  class="pn-fcontent">
						<select class="required" id="specialVeh_specialType" name="specialVeh.specialType" style="width:178px;height: 22px;">
						 <option value="">- 请选择 -</option>
						<c:forEach items="${stList}" var="item">
								 <option value="${item.typeCode}" >${item.typeName}</option>
							</c:forEach>
						</select><span style="color: red">&nbsp;*</span>
						</td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">卡&nbsp;&nbsp;号：</td>
						<td class="pn-fcontent"><input type="text" class="numberDeleteNull cardNomaxlength20"  name="specialVeh.cardNo" value="${specialVeh.cardNo}" size="28" /></td>
						<td  class="pn-flabel pn-flabel-h">车道类型：</td>
						<td  class="pn-fcontent">
						<select class="required" name="specialVeh.lanetype" style="width: 178px;height: 22px;;">
						   <option value="">- 请选择 -</option>
						   <option value="1" >入口</option>
						   <option value="2" >出口</option>
						   <option value="0" >出入口</option>
						</select><span style="color: red">&nbsp;*</span>
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