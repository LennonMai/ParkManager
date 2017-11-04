<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
	<head>
		<title>车辆类型列表</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<%@include file="../../include/common.jsp" %>
		<script language="javascript">
		if("${result}"=="SUCCESS"){
			alert("车辆类型添加成功！");
			}
		if("${message}"=="updateSuccess"){
			alert("修改成功！");
			}
		if("${message}"=="deleteSuccess"){
			alert("删除成功！");
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
			
			function add(){
				window.location.href="carType_add.do";
			}
			
			function del(carType){
				jQuery.post("carType_isCarTypeInUse.do?carType.carType="+carType,function(data) {
					if(data == "UseInUserCarInfo") {
						alert("该车辆类型已在校园卡用户信息中使用，不可删除！");
						return false;
					}else if(data == "UseInSmallType"){
						alert("该车辆类型已在停车位信息中使用，不可删除！");
						return false;
					}else if(data == "noUse"){
						if(confirm("确定删除车辆类型信息？")){
							window.location.href="carType_delete.do?carType.carType="+carType;
						}
					}
				});
				
				
				
			}
			
			function edit(carType){
				window.location.href="carType_edit.do?carType.carType="+carType;
			}
			
		</script>
	</head> 
	<body   onload="setRowBGcolor();">
		<div class="body-box">
            <div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form  name="tableForm"  method="post" action="carType_getCarTypeList.do" >
			<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
				  <tr align="right">
						<td style="background-color:#FFFFFF;text-align:right;padding-right: 20px;padding-top: 2px;padding-bottom: 2px;">				
						<input style="height: 22px" type="button"  value="&nbsp;添加车辆类型&nbsp;"  onclick="add();"/>
						</td>
					</tr>
				</table>		
			<table id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">车辆类型编码</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">车辆类型名称</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">操作</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="carType">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
							<td  style="word-break:break-all;padding-left:5px;padding-right:5px;">${carType.carType}</td>
							<td  style="word-break:break-all;padding-left:5px;padding-right:5px;">${carType.carTypeName}</td>
							<td class="pn-lopt" style="white-space:nowrap;padding-left:5px;padding-right:5px;">
							<a href="javascript:edit('${carType.carType}');" class="pn-loperator">修改</a>
							┆ <a href="javascript:del('${carType.carType}');" class="pn-loperator">删除</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../../include/pager.jsp"/>
			</form>
		
		</div>
		
	</body>
</html>