<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
	<head>
		<title>模块信息列表</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
			
		<script language="javascript">
		if("${result}"=="SUCCESS"){
			alert("模块信息添加成功！");
			}
		if("${message}"=="updateSuccess"){
			alert("修改成功！");
			}
		if("${message}"=="deleteSuccess"){
			alert("删除成功！");
			}
		function del(moduleNo,pageSize,currentPage){
			if(confirm("确认要删除吗？")){
				window.location.href = "laneModule_delete.do?laneModule.moduleNo="+moduleNo+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage;
			}
		}
		function add(){
			window.location.href = "laneModule_add.do";
			}
		function getRowIndex(obj){
			get("pager.rowIndex").value=obj.rowIndex;
			}
		function edit(moduleNo,pageSize,currentPage){
			window.location.href ="laneModule_edit.do?laneModule.moduleNo="+moduleNo+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage+"&pager.rowIndex="+get("pager.rowIndex").value;
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
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form  name="tableForm"  method="post" action="laneModule_query.do" onsubmit="">
			<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
					<tr>
					    <td  class="pn-flabel pn-flabel-h">模块编码：</td>
						<td  class="pn-fcontent"> <input type="text" name="laneModule.moduleNo" value="${laneModule.moduleNo}" size="24"/></td>
						<td  class="pn-flabel pn-flabel-h">模块名称：</td>
						<td  class="pn-fcontent"> <input type="text" name="laneModule.moduleName" value="${laneModule.moduleName}" size="24"/></td>
					</tr>
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input style="padding-left: 5px;padding-right: 5px;" type="submit"value=" 查 询 " />&nbsp;
						<input style="padding-left: 5px;padding-right: 5px;" type="reset" value=" 重 置 " />&nbsp;
						<input style="padding-left: 5px;padding-right: 5px;" type="button" value=" 添加 " onclick="add();"/>	
						</td>
					</tr>
			</table>		
			<table  id="tb"  class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">模块编码</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">模块名称</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">备&nbsp;&nbsp;注</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">操&nbsp;&nbsp;作</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center" onclick="getRowIndex(this)">
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.moduleNo}</td>
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.moduleName}</td>
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.remark}</td>
							<td class="pn-lopt" style="white-space:nowrap;padding-left:5px;padding-right:5px;">
							
							<a href="javascript:edit('${item.moduleNo}',${pager.pageSize},${pager.currentPage})" class="pn-loperator">修改</a>
							<!--<a href="laneModule_edit.do?laneModule.moduleNo=${item.moduleNo}&pager.pageSize=${pager.pageSize}&pager.currentPage=${pager.currentPage}" class="pn-loperator">修改</a>-->
							┆ <a href="javascript:del('${item.moduleNo}',${pager.pageSize},${pager.currentPage})" class="pn-loperator">删除</a>							
							</td>
							</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../../include/pager.jsp"/>
			</form>
		</div>		
	</body>
</html>