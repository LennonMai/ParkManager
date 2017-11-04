<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
	<head>
		<title>工班信息列表</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script language="javascript">
		if("${result}"=="SUCCESS"){
			alert("工班信息添加成功！");
			}
		if("${message}"=="updateSuccess"){
			alert("修改成功！");
			}
		if("${message}"=="deleteSuccess"){
			alert("删除成功！");
			}
			function del(id,pageSize,currentPage){
				if(confirm("确认要删除吗？")){
					window.location.href = "baseInfo_squad_delete.do?squadInformation.squadNo="+id+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage;
				}
			}
			
			function add(){
				window.location.href = "baseInfo_squad_add.do";
				}
			function getRowIndex(obj){
				get("pager.rowIndex").value=obj.rowIndex;
				}
			function edit(squadNo,pageSize,currentPage){
				window.location.href ="baseInfo_squad_edit.do?squadInformation.squadNo="+squadNo+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage+"&pager.rowIndex="+get("pager.rowIndex").value;
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
	<body  onload="setRowBGcolor();">
		<div class="body-box">
            <div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form  name="tableForm"  method="post" action="baseInfo_squad_list.do" >
			<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
				    <tr align="right">
						<td style="background-color:#FFFFFF;text-align:right;padding-right: 20px;padding-top: 2px;padding-bottom: 2px;">				
						<input style="height: 22px;" type="button"  value="&nbsp;添加工班信息&nbsp;"  onclick="add();"/>
						</td>
					</tr>
			
				</table>		
			<table id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">工班编号</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">工班名称</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">开始时间</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">结束时间</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">生效日期</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">日期偏移</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">描&nbsp;&nbsp;述</th>
				    	<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">操&nbsp;&nbsp;作</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center"  onclick="getRowIndex(this)">
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.squadNo}</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.squadName}</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.startTime}</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.endTime}</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.startDate}</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.timeDiff}</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.remark}</td>
							<td class="pn-lopt" style="white-space:nowrap;padding-left:5px;padding-right:5px;">
							<!--<a href="baseInfo_squad_edit.do?squadInformation.squadNo=${item.squadNo}" class="pn-loperator">修改</a>-->
							<a href="javascript:edit(${item.squadNo},${pager.pageSize},${pager.currentPage})" class="pn-loperator">修改</a>
							┆ <a href="javascript:del(${item.squadNo},${pager.pageSize},${pager.currentPage});" class="pn-loperator">删除</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../../include/pager.jsp"/>
			</form>
		
		</div>
		
	</body>
</html>