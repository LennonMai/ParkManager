<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
	<head>
		<title>修改补光灯时间信息</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<%@include file="../../include/common.jsp" %>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<script type="text/javascript">
		
		function isTime(str){
			//格式为： HH:MM:SS  	
            var a=str.match(/^(\d{1,2})(:)?(\d{1,2})\2(\d{1,2})$/); 
            //alert(a);
            if (a==null){return false;} 
            if (a[1]>24 || a[3]>60 || a[4]>60) {return false;} 
		}
		function back(){
			window.location.href = "baseInfo_supplyLight_list.do";
			}	
		</script>

	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="baseInfo_updateSupplyLight.do">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<tr>
						<td class="pn-flabel pn-flabel-h">开始时间：</td>
						<!-- <td class="pn-fcontent"><input class="required maxlength8" style="width: 201px;" type="text" name="supplyLightInformation.startTime" value="${supplyLightInformation.startTime }" readonly="readonly"/> -->
						<td style="width: 430px;" class="pn-fcontent">${supplyLightInformation.startTime }</td>
				     	<td class="pn-flabel pn-flabel-h">结束时间：</td>
						<td class="pn-fcontent"><input class="required maxlength8" style="width: 201px;" type="text" name="supplyLightInformation.endTime"  value="${supplyLightInformation.endTime }"  class="Wdate" onclick="WdatePicker({dateFmt:'HH:mm:ss'})" readonly="readonly"/><span style="color: red">&nbsp;*</span></td>
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