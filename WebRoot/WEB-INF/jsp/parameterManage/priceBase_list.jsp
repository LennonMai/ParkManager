<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
	<head>
		<title>费率配置列表</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script language="javascript">

		if("${result}"=="SUCCESS"){
			alert("费率配置成功！");
			}
		if("${message}"=="updateSuccess"){
			alert("修改成功！");
			}
		if("${message}"=="deleteSuccess"){
			alert("删除成功！");
			}
		function del(verNo,feeNo,rebateType,inOutSign,timesSign,vehTypeNo,pageSize,currentPage){
			if(confirm("确认要删除吗？")){
				window.location.href = "priceBase_delete.do?priceBase.verNo="+verNo+"&priceBase.feeNo="+feeNo+"&priceBase.rebateType="+rebateType+"&priceBase.inOutSign="+inOutSign+"&priceBase.timesSign="+timesSign+"&priceBase.vehTypeNo="+vehTypeNo+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage;
			}
		}			
		function add(){
			window.location.href = "priceBase_add.do";
			}
		function getRowIndex(obj){
			get("pager.rowIndex").value=obj.rowIndex;
			}
		function edit(verNo,feeNo,rebateType,inOutSign,timesSign,vehTypeNo,pageSize,currentPage){
			window.location.href ="priceBase_edit.do?priceBase.verNo="+verNo+"&priceBase.feeNo="+feeNo+"&priceBase.rebateType="+rebateType+"&priceBase.inOutSign="+inOutSign+"&priceBase.timesSign="+timesSign+"&priceBase.vehTypeNo="+vehTypeNo+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage+"&pager.rowIndex="+get("pager.rowIndex").value;
		}
		function setRowBGcolor(){
			var rowIndex="${rowIndex}";
			var pageSize="${pageSize}";
			var currentPage="${currentPage}";
			if(rowIndex!=""&&pageSize!=""&&currentPage!=""){
				var trs=document.getElementById("tb").getElementsByTagName("tr");
				for(var i=0;i<trs.length;i++){
					if(i==rowIndex&&get("pager.pageSize").value==pageSize&&get("pager.currentPage").value==currentPage){
						trs[i].style.backgroundColor="#E6E6E6";
					}
				}
			}
		}	
		</script>
	</head> 
	<body onload="setRowBGcolor();">
		<div class="body-box">
            <div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}
				</div>
				<div class="clear"></div>
			</div>
			<form  name="tableForm"  method="post" action="priceBase_query.do">
			<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
				    <tr>
						<td  class="pn-flabel pn-flabel-h">费率版本：</td>
						<td  class="pn-fcontent"> <input type="text" name="priceBase.verNo" value="${priceBase.verNo}" size="24"/></td>
					    <td class="pn-flabel pn-flabel-h">车&nbsp;&nbsp;&nbsp;&nbsp;型：</td>
						<td class="pn-fcontent">
						<select class="required " style="width: 178px;height: 22px;"  name="priceBase.vehTypeNo" >			       
						    <option value="" <c:if test="${priceBase.vehTypeNo==null}">selected="selected"</c:if>>- 请选择 -</option>
						    <option value="1"  <c:if test="${priceBase.vehTypeNo==1}">selected="selected"</c:if>>摩托车</option>
							<option value="2"  <c:if test="${priceBase.vehTypeNo==2}">selected="selected"</c:if>>小车</option>
		 					<option value="3"  <c:if test="${priceBase.vehTypeNo==3}">selected="selected"</c:if>>大型车</option>
							<option value="4"  <c:if test="${priceBase.vehTypeNo==4}">selected="selected"</c:if>>超大型车</option>
		                </select>
						</td>
						</tr>
					<tr>
					    <td  class="pn-flabel pn-flabel-h">费率编号：</td>
						<td  colspan="3" class="pn-fcontent"> <input type="text" name="priceBase.feeNo" value="${priceBase.feeNo}" size="24"/></td>
					</tr>
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input style="padding-left: 5px;padding-right: 5px;" type="submit"   value=" 查 询 " />&nbsp;
						<input style="padding-left: 5px;padding-right: 5px;" type="button"  value=" 添 加 "  onclick="add();"/> &nbsp;
						<input style="padding-left: 5px;padding-right: 5px;" type="reset" value=" 重 置 " />	
						</td>
					</tr>
			
			</table>		
			<table id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">费率版本</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">费率编号</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">车&nbsp;&nbsp;型</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">免费停留时间（分钟）</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">单位收费时间（分钟）</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">单位收费金额（分）</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">最多收费金额（分）</th>					
				    	<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">启用时间</th>
				    	<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">备&nbsp;&nbsp;注</th>
				    	<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">操&nbsp;&nbsp;作</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center" onclick="getRowIndex(this)">
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.verNo}</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;" >${item.feeNo}</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">
							<c:if test="${item.vehTypeNo==1}">摩托车</c:if>
							<c:if test="${item.vehTypeNo==2}">小车</c:if>
							<c:if test="${item.vehTypeNo==3}">大型车</c:if>
							<c:if test="${item.vehTypeNo==4}">超大型车</c:if>
							</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.allowStayTime}</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.stayAdd}</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.addFee}</td>					
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.maxFee}</td>						
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.startTime}</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.remark}</td>
							
							<td class="pn-lopt" style="white-space:nowrap;padding-left:5px;padding-right:5px;">
							<!--<a href="priceBase_edit.do?priceBase.verNo=${item.verNo}&priceBase.feeNo=${item.feeNo}&priceBase.rebateType=${item.rebateType}&priceBase.inOutSign=${item.inOutSign}&priceBase.timesSign=${item.timesSign}&priceBase.vehTypeNo=${item.vehTypeNo}" class="pn-loperator">修改</a>-->
							<a href="javascript:edit(${item.verNo},${item.feeNo},${item.rebateType},${item.inOutSign},${item.timesSign},${item.vehTypeNo},${pager.pageSize},${pager.currentPage})" class="pn-loperator">修改</a>
							┆ <a href="javascript:del(${item.verNo},${item.feeNo},${item.rebateType},${item.inOutSign},${item.timesSign},${item.vehTypeNo},${pager.pageSize},${pager.currentPage});" class="pn-loperator">删除</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../include/pager.jsp"/>
			</form>

		</div>

	</body>
</html>