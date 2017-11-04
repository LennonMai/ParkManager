<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
	<head>
		<title>添加停车位</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<%@include file="../../include/common.jsp" %>
		<script type="text/javascript">
		
		function sub(){
			if($("#dataform").valid()){
				var carType = $("#carType").val();
				var carSmallType = $("#carSmallType").val();
				if(carType==null || carType=="" || carSmallType==null || carSmallType==""){
					return false;
				}
				jQuery.post("carSmallType_isHasCarSmallType.do?carSmallType.carType="+carType+"&carSmallType.carSmallType="+carSmallType, function(data) {
					if(data == "hasCarSmallType") {
						alert("该车辆类型下的停车位编码已存在！");
						$("#carSmallType").val("");
			    		$("#carSmallType").focus();
			    		return false;
					}else{
						document.getElementById("dataform").submit();
					}
				});
			}
			
		}
		
		function back(){
			window.location.href = "carSmallType_getCarSmallTypeList.do";
		}	
		</script>

	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="carSmallType_save.do" >
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
				<tr> 
						<td class="pn-flabel pn-flabel-h">车辆类型：</td>
						<td class="pn-fcontent">
						<select class="required isNo_smallint" style="width:150px" id="carType"  name="carSmallType.carType">
							<option value="">请选择</option>
							<c:forEach items="${carTypelist}" var="carType">
								<option value="${carType.carType}">${carType.carTypeName}</option>
							</c:forEach>
						</select>
						<span style="color: red">&nbsp;*</span></td>
					    <td class="pn-flabel pn-flabel-h"> </td>
						<td class="pn-fcontent"> </td>
			    	</tr>
                    <tr> 
						<td class="pn-flabel pn-flabel-h">停车位编码：</td>
						<td class="pn-fcontent">
						<input class="required isNo_smallint" id="carSmallType"  name="carSmallType.carSmallType" />
						<span style="color: red">&nbsp;*</span></td>
	
					    <td class="pn-flabel pn-flabel-h">停车位名称：</td>
						<td class="pn-fcontent">
						<input type="text" class="required maxlength20" id="carSmallName" name="carSmallType.carSmallName"/>
						<span style="color: red">&nbsp;*</span></td>
			    	</tr>
					<tr>
						<td colspan="4" class="pn-fbutton">
							<input type="button" value=" 保 存 " onclick="sub()"/>&nbsp;
						    <input type="reset" value=" 重 置 "/>&nbsp;
						    <input type="button" value=" 返 回 " onclick="return back()"/>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>