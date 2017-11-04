<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
	<head>
		<title>区域信息列表</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script language="javascript">
		if("${result}"=="SUCCESS"){
			alert("区域信息添加成功！");
			}
		if("${message}"=="updateSuccess"){
			alert("修改成功！");
			}
		if("${message}"=="deleteSuccess"){
			alert("删除成功！");
			}
			function del(id,pageSize,currentPage){	
				if(confirm("！您删除["+id+"]区域信息的同时将删除关联该区域的信息：\n  小区信息、大门信息、车道信息、车位信息，  \n\n  确认要删除吗？")){
					window.location.href = "baseInfo_area_delete.do?areaInformation.areaNo="+id+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage;
				}
			}
			
			function add(){
				window.location.href = "baseInfo_area_add.do";
				}
			function getRowIndex(obj){
				get("pager.rowIndex").value=obj.rowIndex;
				}
			function edit(areaNo,pageSize,currentPage){
				window.location.href ="baseInfo_area_edit.do?areaInformation.areaNo="+areaNo+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage+"&pager.rowIndex="+get("pager.rowIndex").value;
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
	<body   onload="setRowBGcolor();">
		<div class="body-box">
            <div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form  name="tableForm"  method="post" action="baseInfo_area_list.do" >
			<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
				  <tr align="right">
						<td style="background-color:#FFFFFF;text-align:right;padding-right: 20px;padding-top: 2px;padding-bottom: 2px;">				
						<input style="height: 22px" type="button"  value="&nbsp;添加区域信息&nbsp;"  onclick="add();"/>
						</td>
					</tr>
				</table>		
			<table id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">城市编码</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">区域编码</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">区域名称</th>
						 <th style="white-space:nowrap;padding-left:5px;padding-right:5px;">域名</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">服务器IP</th>
				    	<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">服务器名称</th>
					   	<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">数据库名</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">数据库用户名</th>
				    	<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">数据库密码</th>
				    	<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">操&nbsp;&nbsp;作</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center"  onclick="getRowIndex(this)">
							<td  style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.cityNo}</td>
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.areaNo}</td>
							<td  style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.areaName}</td>
							<td  style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.areaDomain}</td>
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.areaServerIp}</td>
							<td  style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.areaServerName}</td>

							<td  style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.areaDbname}</td>
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.areaDbuserName}</td>
							<td  style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.areaDbpassword}</td>

							<td class="pn-lopt" style="white-space:nowrap;padding-left:5px;padding-right:5px;">
							<a href="javascript:edit(${item.areaNo},${pager.pageSize},${pager.currentPage})" class="pn-loperator">修改</a>
							┆ <a href="javascript:del(${item.areaNo},${pager.pageSize},${pager.currentPage});" class="pn-loperator">删除</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../../include/pager.jsp"/>
			</form>
		
		</div>
		
	</body>
</html>