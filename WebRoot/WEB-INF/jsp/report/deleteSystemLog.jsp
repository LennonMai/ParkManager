<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
	<head>
		<title></title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/dtree.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<script type="text/javascript">
		if("${message}"=="delSuccess"){
			alert(" 删除日志成功 ！  ");
			}
		
		function check() {
			if(get("delStartTime").value == "" && get("delEndTime").value == "" ) {
				alert(" 请选择时间范围 ！ ");
				return false;
				  }
		    if(get("delStartTime").value != "" && get("delEndTime").value != "" ) {
			    if(get("delStartTime").value > get("delEndTime").value) {
			      	alert("开始时间必须早于或等于结束时间  ");
			    	return false;
			    }
			}    
		    else {
		      	return true;
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
			<form name="tableForm" method="post" action="report_delSystemLog.do" onsubmit="return check();">
				<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
					<tr >
						<td class="pn-flabel pn-flabel-h" style="width:416px;white-space:nowrap;padding-left:5px;padding-right:5px;">选择时间范围：</td>
						<td class="pn-fcontent">
						  <input size="22" type="text" name="delStartTime" value="<fmt:formatDate value="${delStartTime }" pattern="yyyy-MM-dd HH:mm:ss" />" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})""> - <input size="22" type="text" name="delEndTime" value="<fmt:formatDate value="${delEndTime }" pattern="yyyy-MM-dd HH:mm:ss" />" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"">
						</td>
					</tr>
					<tr style="padding-top: 6px;padding-bottom: 3px;">
						<td colspan="4" class="pn-fbutton">
						<input type="submit" value="&nbsp;删 除 &nbsp;"/>&nbsp;&nbsp;
						<input type="button" value="&nbsp;返 回 &nbsp;" onclick="history.back();"/>&nbsp;	
						</td>
					</tr>
				</table>

        </form>
		</div>
	</body>
</html>