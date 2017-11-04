<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
	<head>
		<title>添加收费类型</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<%@include file="../../include/common.jsp" %>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<script type="text/javascript">

	    //jquery异步验证收费类型是否存在
	    function ishasFeeRuleType() {
	    	var feeRuleType = $("#feeRuleType").val();
	    	jQuery.post("zjuPriceConfig_ishasFeeRuleType.do?feeRuleTypeDef.feeRuleType="+feeRuleType, function(data){
	    		if(data == "hasFeeRuleType") {
	    			alert("收费类型已存在！");
	    			//$("#feeRuleType")[0].value="";
	    		    $("#feeRuleType").val("");
	    			$("#feeRuleType").focus();
	    		}	
	    	});
	    }
	    //jquery异步验证车辆类别名是否存在
	    function ishasName() {
	    	var _name = $("#_name").val();
	    	jQuery.post("zjuPriceConfig_ishasName.do?feeRuleTypeDef.name="+_name, function(data){
	    		if(data == "hasName") {
	    			alert("车辆类别名已存在！");
	    			$("#_name").val("");
		    		$("#_name").focus();
		    		
	    		}	
	    	});
	    }
		function back(){
			window.location.href = "zjuPriceConfig_feeRuleTypeDef_list.do";
			}
		
		</script>

	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="zjuPriceConfig_saveFeeRuleTypeDef.do" >
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<tr>
						<td class="pn-flabel pn-flabel-h">收费类型：</td>
						<td class="pn-fcontent"><input type="text" class="required isNo_NotOverValueInt" id="feeRuleType" name="feeRuleTypeDef.feeRuleType" value="${feeRuleTypeDef.feeRuleType}" size="24" onblur="ishasFeeRuleType();"/><span style="color: red">&nbsp;*</span></td>
						<td class="pn-flabel pn-flabel-h">车辆类别名：</td>
						<td class="pn-fcontent"><input type="text" class="required maxlength20" id="_name" name="feeRuleTypeDef.name" value="${feeRuleTypeDef.name}" size="24" onblur="ishasName();"/><span style="color: red">&nbsp;*</span></td>
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