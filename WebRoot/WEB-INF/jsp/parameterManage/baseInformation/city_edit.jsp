<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<title>编辑城市信息</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<%@include file="../../include/common.jsp" %>
		<script type="text/javascript">
		var record=null; 
		
		if("${result}" == "FAIL") {
			record="fail";
			alert("城市名称已存在！");
		}
		function back(){
			window.location.href = "baseInfo_city_list.do";
		}
		</script>

	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="baseInfo_updateCityInfo.do?cityName=${cityInformation.cityName }" >
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">城市编码：</td>
						<td width="80%" class="pn-fcontent">${cityInformation.cityNo}<input readonly="readonly"  type="hidden" name="cityInformation.cityNo" value="${cityInformation.cityNo}" size="28"/></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">城市名称：</td>
						<td width="80%" class="pn-fcontent"><input type="text" class="required maxlength20"  name="cityInformation.cityName" value="${cityInformation.cityName}" size="28"/><span style="color: red">&nbsp;*</span></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">备&nbsp;&nbsp;注：</td>
						<td width="80%" class="pn-fcontent">
						<textarea class="maxlength100" name="cityInformation.remark" rows="3" cols="40">${cityInformation.remark}</textarea></td>
					</tr>
					<tr>
						<td colspan="2" class="pn-fbutton">
							<input type="submit" value=" 保 存 "/> &nbsp;
						    <input type="reset"" value=" 重 置 " /> &nbsp;
						    <input type="button" value=" 返 回 " onclick="return back()"/></td>
					</tr>
				</table>
			</form>
		</div>
		<script type="text/javascript">
		if(record == "fail") {
			get("cityInformation.cityName").focus();
		}
		</script>
	</body>
</html>