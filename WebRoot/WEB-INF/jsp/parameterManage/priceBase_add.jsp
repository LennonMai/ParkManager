<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
	<head>
		<title>添加费率配置</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<%@include file="../include/common.jsp" %>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<script type="text/javascript">
		if("${message}"=="hasPriceBase"){
			alert("已存在该费率！");
		    }
		function back(){
			window.location.href = "priceBase_list.do";
			}
		</script>

	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="priceBase_savePriceBase.do">
				<br/><span style="color: red">&nbsp;*必填项</span>
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
                  
					 <tr>
						<td class="pn-flabel pn-flabel-h">费率版本：</td>
						<td colspan="4" class="pn-fcontent"><input type="text" class="required versonNoFormat" name="priceBase.verNo" value="${priceBase.verNo}" size="28"/><span style="color: red">&nbsp;*</span></td>
					</tr>
					 <tr>
						<td class="pn-flabel pn-flabel-h">车&nbsp;&nbsp;&nbsp;&nbsp;型：</td>
						<td colspan="4" class="pn-fcontent"><select style="width: 206px;height: 22px;" name="priceBase.vehTypeNo" class="required ">
						<option value="">- 请选择 -</option>
						<option value="1">摩托车</option>
						<option value="2">小车</option>
						<option value="3">大型车</option>
						<option value="4">超大型车</option>
						<option value="0">所有车型</option>
						</select><span style="color: red">&nbsp;*</span></td>
					 </tr>
					 <tr>
						<td class="pn-flabel pn-flabel-h">免费停留：</td>
						<td colspan="4" class="pn-fcontent"><input class="required isNo_NotOverValueInt" type="text" name="priceBase.allowStayTime" value="${priceBase.allowStayTime}" size="28"/>&nbsp;分钟<span style="color: red">&nbsp;*</span></td>
					</tr>	
					<tr>
						<td class="pn-flabel pn-flabel-h">每：</td>
						<td colspan="4" class="pn-fcontent"><input class="required isNo_NotOverValueInt" type="text" name="priceBase.stayAdd" value="${priceBase.stayAdd}" size="8"/>&nbsp;小时，收费
						<input class="required isNo_NotOverValueInt" type="text" name="priceBase.addFee" value="${priceBase.addFee}" size="8"/>&nbsp;元<span style="color: red">&nbsp;*</span></td>
					</tr>
					
					<tr>
						<td class="pn-flabel pn-flabel-h">12小时最多收费：</td>
						<td colspan="4" class="pn-fcontent"><input class="required isNo_NotOverValueInt" type="text" name="priceBase.maxFee" value="${priceBase.maxFee}" size="28"/>&nbsp;元<span style="color: red">&nbsp;*</span></td>
		            </tr>    
					<tr>
						<td class="pn-flabel pn-flabel-h">启用时间：</td>
						<td colspan="4" class="pn-fcontent"><input class="required " style="width: 201px;" type="text" name="priceBase.startTime" value="<fmt:formatDate value="${priceBase.startTime }" pattern="yyyy-MM-dd HH:mm:ss" />" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly"/><span style="color: red">&nbsp;*</span></td>
				    </tr>    	
				</table>
								<br/><span style="color: red">&nbsp;&nbsp;可选项（为空则默认赋初始值，修改页面可见）</span>
					<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<tr>
					    <td class="pn-flabel pn-flabel-h">优惠类型：</td>
						<td class="pn-fcontent"><!--<input type="text" class=" isNo_NotOverValueInt" name="priceBase.rebateType" value="${priceBase.rebateType}" size="22"/></td>
						-->
						<select class="required " id="priceBase.rebateType" name="priceBase.rebateType" style="width: 164px;height: 22px;">
						<option value="0">无优惠</option>
						</select></td>
						 <td class="pn-flabel pn-flabel-h">进出口标志：</td>
						<td class="pn-fcontent"><input type="text" class=" isNo_NotOverValueInt" name="priceBase.inOutSign" value="${priceBase.inOutSign}" size="22"/></td>		
						</tr>
	     			<tr>
	     			    <td class="pn-flabel pn-flabel-h">首段停留时间：</td>
						<td class="pn-fcontent"><input type="text" class=" isNo_NotOverValueInt" name="priceBase.baseFeeTime" value="${priceBase.baseFeeTime}" size="22"/>&nbsp;分钟</td>
					    <td class="pn-flabel pn-flabel-h">时间段标志：</td>
						<td class="pn-fcontent"><input type="text" class=" isNo_NotOverValueInt" name="priceBase.timesSign" value="${priceBase.timesSign}" size="22"/></td>
						</tr>	
					<tr>
						<td class="pn-flabel pn-flabel-h">首段收费金额：</td>
						<td class="pn-fcontent"><input type="text" class=" isNo_NotOverValueInt" name="priceBase.baseFee" value="${priceBase.baseFee}" size="22"/>&nbsp;分</td>
						<td class="pn-flabel pn-flabel-h">单位起算时间：</td>
						<td class="pn-fcontent"><input type="text" class=" isNo_NotOverValueInt" name="priceBase.addStart" value="${priceBase.addStart}" size="22"/></td>
					</tr>	
					<tr>
						<td class="pn-flabel pn-flabel-h">最大停留时间：</td>
						<td class="pn-fcontent"><input type="text" class=" isNo_NotOverValueInt" name="priceBase.maxTime" value="${priceBase.maxTime}" size="22"/>&nbsp;分钟</td>
						<td class="pn-flabel pn-flabel-h">计算费率控制：</td>
						<td class="pn-fcontent"><input type="text" class=" isNo_NotOverValueInt" name="priceBase.sumFeeCtr" value="${priceBase.sumFeeCtr}" size="22"/></td>
					</tr>	
					<tr>
					    <td class="pn-flabel pn-flabel-h">备&nbsp;用1：</td>
						<td class="pn-fcontent"><input type="text" class=" maxlength16" name="priceBase.backup1" value="${priceBase.backup1}" size="22"/></td>
					    <td class="pn-flabel pn-flabel-h">每个计费周期最大收费时间：</td>
						<td class="pn-fcontent"><input type="text" class=" isNo_NotOverValueInt" name="priceBase.maxFeeTime" value="${priceBase.maxFeeTime}" size="22"/></td>
					</tr>
					<tr>
					    <td class="pn-flabel pn-flabel-h">备&nbsp;用2：</td>
						<td colspan="4" class="pn-fcontent"><input class=" maxlength16" type="text" name="priceBase.backup2" value="${priceBase.backup2}" size="22"/></td>
					   </tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">备&nbsp;注&nbsp;：</td>
						<td colspan="4"  width="80%" class="pn-fcontent">
						<textarea class=" maxlength50" name="priceBase.remark" rows="3" cols="48">${priceBase.remark}</textarea></td>
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