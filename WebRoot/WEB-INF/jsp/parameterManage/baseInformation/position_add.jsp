<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<title>添加位置信息</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<%@include file="../../include/common.jsp" %>
		<script type="text/javascript"> 
		if("${message}"=="hasNoandClass"){
			alert("已存在该位置编码和类型！");
			}
		function ishasIid() {
	    	var Iid = $("#Iid").val();
	    	jQuery.post("baseInfo_ishasIid.do?positionInformation.iid="+Iid, function(data){
	    		if(data == "hasIid") {
	    			alert("唯一编码已经存在！");
	    			$("#Iid").val("");
		    		$("#Iid").focus();
	    		}	
	    	});
	    }
		function back(){
			window.location.href = "baseInfo_position_list.do";
			}
		</script>

	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="baseInfo_savePositionInfo.do">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
                    <tr>
						<td class="pn-flabel pn-flabel-h">位置编码：</td>
						<td class="pn-fcontent"><input id="positionNo" type="text" class="required isNo_NotOverValueInt" name="positionInformation.no" value="${positionInformation.no}" size="28" /><span style="color: red">&nbsp;*</span></td>
			    		<td class="pn-flabel pn-flabel-h">类&nbsp;&nbsp;&nbsp;&nbsp;型：</td>
						<td class="pn-fcontent"><c:if test="${positionInformation.class_==null}">
						<select class="required" id="class_"  name="positionInformation.class_" style="width: 206px;height: 22px;">
						   <option value="" selected="selected">请选择</option>
			               <option value="1">车道</option>
			               <option value="2">站（大门）</option>		
			               <option value="3">中心</option>
			               <option value="9">其他</option>			          
		                </select>
		                </c:if>
		                <c:if test="${positionInformation.class_==1}">
						<select class="required" id="class_"  name="positionInformation.class_" style="width: 206px;height: 22px;">
						   <option value="" >请选择</option>
			               <option value="1" selected="selected">车道</option>
			               <option value="2">站（大门）</option>		
			               <option value="3">中心</option>
			               <option value="9">其他</option>			          
		                </select>
		                </c:if>
		                <c:if test="${positionInformation.class_==2}">
						<select class="required" id="class_"  name="positionInformation.class_" style="width: 206px;height: 22px;">
						   <option value="" >请选择</option>
			               <option value="1">车道</option>
			               <option value="2" selected="selected">站（大门）</option>		
			               <option value="3">中心</option>
			               <option value="9">其他</option>			          
		                </select>
		                </c:if>
		                <c:if test="${positionInformation.class_==3}">
						<select class="required" id="class_"  name="positionInformation.class_" style="width: 206px;height: 22px;">
						   <option value="" >请选择</option>
			               <option value="1">车道</option>
			               <option value="2">站（大门）</option>		
			               <option value="3" selected="selected">中心</option>
			               <option value="9">其他</option>			          
		                </select>
		                </c:if>
		                <c:if test="${positionInformation.class_==9}">
						<select class="required" id="class_"  name="positionInformation.class_" style="width: 206px;height: 22px;">
						   <option value="" >请选择</option>
			               <option value="1">车道</option>
			               <option value="2">站（大门）</option>		
			               <option value="3">中心</option>
			               <option value="9" selected="selected">其他</option>			          
		                </select>
		                </c:if>
		                <span style="color: red">&nbsp;*</span></td></tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">位置名称：</td>
						<td class="pn-fcontent"><input type="text" class="maxlength20" name="positionInformation.name" value="${positionInformation.name}" size="28"/></td>
						<td class="pn-flabel pn-flabel-h">唯一编号：</td>
						<td class="pn-fcontent"><input id="Iid" type="text" class="required isNo_NotOverValueInt" name="positionInformation.iid" value="${positionInformation.iid}" size="28" onblur="ishasIid();"/><span style="color: red">&nbsp;*</span></td>
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