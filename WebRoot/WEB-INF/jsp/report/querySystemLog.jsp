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
		if("${message}"=="overMaxCount"){
			alert("导出的日志数据超过50000条，请缩短时间范围！");
			}
		
		function check() {
		    /*if(get("startTime1").value == null || get("startTime1").value == "" || get("endTime1").value == null || get("endTime1").value == "" ) {
		      	alert("查询时间不能为空");
		      	return false;
		    }*/
		    if(get("startTime1").value != "" && get("endTime1").value != "" ) {
			    if(get("startTime1").value > get("endTime1").value) {
			      	alert("开始时间必须早于或等于结束时间");
			    	return false;
			    }
			}    
		    else {
		      	return true;
		    }  	
		}
         
		//导入Excel日志
		function importSystemLog(){
			  window.location.href = "report_importSystemLog.do";
			}

		//导出日志到Excel
		function logToExcel(){
			var startTime=get("data_startTime").value;
			var endTime=get("data_endTime").value;
			if(get("data_startTime").value == "" && get("data_endTime").value == "" ) {
				alert("请输入导出日志时间范围");
				get("data_startTime").focus();
				}
			else if(get("data_startTime").value != "" || get("data_endTime").value != "" ) {
			    if(get("data_startTime").value != "" && get("data_endTime").value != ""){
			    	if(get("data_startTime").value > get("data_endTime").value) {
				      	alert("开始时间必须早于或等于结束时间");
				      	get("data_startTime").focus();
				    	return false;
				    }
				    else {
					    //alert(startTime+"--"+endTime);
				    	window.location.href = "report_logToExcel.do?data_startTime="+startTime+"&data_endTime="+endTime;
				      	return true;
				    }
				    }		    
			    else {
				    //alert(startTime+"--"+endTime);
			        window.location.href = "report_logToExcel.do?data_startTime="+startTime+"&data_endTime="+endTime;
			      	return true;
			    }
			}    
  	
			}
		function delSystemLog(){
			window.location.href = "report_toDelSystemLog.do";
		}
		</script>
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form name="tableForm" method="post" action="report_querySystemLog.do" onsubmit="return check();">
				<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
					<tr>
						<td class="pn-flabel pn-flabel-h">日志内容：</td>
						<td class="pn-fcontent">
						  <input type="text" name="systemlog.logData" value="${systemlog.logData}" />
						</td>
						<td class="pn-flabel pn-flabel-h">用户名：</td>
						<td class="pn-fcontent">
						  <input type="text" name="admin.username" value="${admin.username}" />
						</td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">日志类型：</td>
						<td class="pn-fcontent">
						  <select name="systemlog.logType" style="width:150px">
						  		<option value="" <c:if test="${systemlog.logType==null}">selected</c:if>>所有类型</option>
						  		<option value="0" <c:if test="${systemlog.logType==0}">selected</c:if>>登录登出</option>
								<option value="1" <c:if test="${systemlog.logType==1}">selected</c:if>>操作</option>
								<option value="2" <c:if test="${systemlog.logType==2}">selected</c:if>>异常错误</option>
							    
						  </select>
						</td>
						<td class="pn-flabel pn-flabel-h">备注：</td>
						<td class="pn-fcontent">
						  <input type="text" name="systemlog.remark" value="${systemlog.remark}" />
						</td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h" style="white-space:nowrap;padding-left:5px;padding-right:5px;">查询时间范围：</td>
						<td class="pn-fcontent">
						  <input type="text" name="startTime1" value="<fmt:formatDate value="${startTime1 }" pattern="yyyy-MM-dd HH:mm:ss" />" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})""> - <input type="text" name="endTime1" value="<fmt:formatDate value="${endTime1 }" pattern="yyyy-MM-dd HH:mm:ss" />" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"">
						</td>
						<td class="pn-flabel pn-flabel-h" style="white-space:nowrap;padding-left:5px;padding-right:5px;">影响范围：</td>
						<td class="pn-fcontent">
						  <input type="text" name="systemlog.coverage" value="${systemlog.coverage}" />
						</td>
					</tr>
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input type="submit" value="&nbsp;查 询&nbsp;" />&nbsp;
						<input type="reset" value="&nbsp;重 置&nbsp;"/>&nbsp;
						<input type="button" value="&nbsp;删 除&nbsp;" onclick="delSystemLog()"/>	
						</td>
					</tr>
				</table>
			<!-- ${fn:length(list)} 显示list长度-->
			<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">时&nbsp;&nbsp;间</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">日志类型</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">用户名</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">日志内容</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">影响范围</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">备&nbsp;&nbsp;注</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;"><fmt:formatDate value="${item.logTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.logTypeString}</td>
							<td><c:forEach items="${adminList}" var="adminItem"><c:if test="${item.operatorID==adminItem.id}">${adminItem.username}</c:if></c:forEach></td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.logData}</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.coverage}</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.remark}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<jsp:include page="../include/pager.jsp"/>
			
        <div class=pn-sp>
		<input type="button" name="" style="padding-left: 5px;padding-right: 5px;padding-bottom: 1px;padding-top: 2px;"  value="导入Excel数据" onclick="importSystemLog();" /> 	
	    <input type="button" name="" style="padding-left: 5px;padding-right: 5px;padding-bottom: 1px;padding-top: 2px;" value="将日志导出Excel" onclick="logToExcel();"/> 
	    <td class="pn-flabel pn-flabel-h" style="white-space:nowrap;padding-left:5px;padding-right:5px;">导出日志时间范围：</td>
		<td class="pn-fcontent">
			 <input type="text" name="data_startTime" value="<fmt:formatDate value="${data_startTime }" pattern="yyyy-MM-dd HH:mm:ss" />" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})""> - <input type="text" name="data_endTime" value="<fmt:formatDate value="${data_endTime }" pattern="yyyy-MM-dd HH:mm:ss" />" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"">
		</td>
	    <div class="clear"></div>
        </div>
        </form>
		</div>
	</body>
</html>