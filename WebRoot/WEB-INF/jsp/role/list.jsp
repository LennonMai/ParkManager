<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
	<head>
		<title>list</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script language="javascript">
			if("${result}"=="FAIL") {
				alert("删除失败，该角色存在正在使用的用户！");
			}
			if("${result}"=="SUCCESS") {
				alert("删除角色成功！");
			}
			function del(id){
				if(confirm("确认要删除吗？")){
					window.location.href = "role_delete.do?role.id="+id;
				}
			}
			function getRowIndex(obj){
				get("pager.rowIndex").value=obj.rowIndex;
			}
			function edit(id,pageSize,currentPage) {														
				window.location = "role_edit.do?role.id="+id+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage+"&pager.rowIndex="+get("pager.rowIndex").value;		
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
				<form class="ropt" method="post" action="role_add.do">
					<input type="submit" value=" 添 加 "/>
				</form>
				<div class="clear"></div>
			</div>
			<form name="tableForm" action="role_list.do" method="post">
			<table id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">编号</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">角色名称</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">备注</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">操作</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center" onclick="getRowIndex(this)">
							<td>${item.id}</td>
							<td>${item.name}</td>
							<td>${item.remark}</td>
							<td class="pn-lopt"><a href="javascript:edit(${item.id},${pager.pageSize},${pager.currentPage});" class="pn-loperator">修改</a>
							┆ <a href="javascript:del(${item.id});" class="pn-loperator">删除</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../include/pager.jsp"/>
			</form>
		</div>
	</body>
</html>