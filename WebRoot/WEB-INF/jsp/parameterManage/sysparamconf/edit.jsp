<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<title>参数编辑</title>
		<%@include file="../../include/common.jsp" %>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		
		<script type="text/javascript">
			function back(){
				window.location.href = "paramconf_list.do";
				}
		</script>

	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="paramconf_update.do?sysparamconf.sys_id=${sysparamconf.sys_id}" >
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">参数名：</td>
						<td width="80%" class="pn-fcontent">${sysparamconf.pname}<input type="hidden" readonly="readonly"  name="sysparamconf.pname" value="${sysparamconf.pname}" size="24" /></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">参数值：</td>
						<td width="80%" class="pn-fcontent"><input type="text" class="required maxlength200" name="sysparamconf.pvalue" value="${sysparamconf.pvalue}" size="24"/><span style="color: red">&nbsp;*</span></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">类&nbsp;&nbsp;型：</td>
						<td width="80%" class="pn-fcontent">
						<c:if test="${sysparamconf.ptype==null}">
						<select class="required" name="sysparamconf.ptype" style="display;  width: 178px;height: 24px;">			       
						    <option value="" selected="selected">- 请选择 -</option>		
			                <option value="0">业务参数</option>			       			               
			                <option value="1">其&nbsp;&nbsp;&nbsp;他</option>		          
		                </select>
		                </c:if>
					    <c:if test="${sysparamconf.ptype==0}">
					    <select class="required" name="sysparamconf.ptype" style="display;  width: 178px;height: 24px;">		
						    <option value="" >- 请选择 -</option>			       
			                <option value="0" selected="selected">业务参数</option>			       			               
			                <option value="1">其&nbsp;&nbsp;&nbsp;他</option>		          
		                </select>
		                </c:if>
						<c:if test="${sysparamconf.ptype==1}">
						<select class="required" name="sysparamconf.ptype" style="display;  width: 178px;height: 24px;">		
						    <option value="" >- 请选择 -</option>			       
			                <option value="0" >业务参数</option>			       			               
			                <option value="1" selected="selected">其&nbsp;&nbsp;&nbsp;他</option>		          
		                </select>
		                </c:if>
						<span style="color: red">&nbsp;*</span></td>
					</tr>
				
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">备&nbsp;&nbsp;注：</td>
						<td width="80%" class="pn-fcontent">
						<textarea  class=" maxlength150" name="sysparamconf.remark" rows="5" cols="50">${sysparamconf.remark}</textarea></td>
					</tr>
					<tr>
						<td colspan="2" class="pn-fbutton">
							<input style="padding-left: 5px;padding-right: 5px;" type="submit" value=" 保 存 "/> &nbsp;
						    <input style="padding-left: 5px;padding-right: 5px;" type="reset"" value=" 重 置 " /> &nbsp;
						    <input style="padding-left: 5px;padding-right: 5px;" type="button" value=" 返 回 " onclick="return back()"/>
						    </td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>