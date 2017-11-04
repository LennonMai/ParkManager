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
				alert("ɾ��ʧ�ܣ��ý�ɫ��������ʹ�õ��û���");
			}
			if("${result}"=="SUCCESS") {
				alert("ɾ����ɫ�ɹ���");
			}
			function del(id){
				if(confirm("ȷ��Ҫɾ����")){
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
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<form class="ropt" method="post" action="role_add.do">
					<input type="submit" value=" �� �� "/>
				</form>
				<div class="clear"></div>
			</div>
			<form name="tableForm" action="role_list.do" method="post">
			<table id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">���</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��ɫ����</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��ע</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">����</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center" onclick="getRowIndex(this)">
							<td>${item.id}</td>
							<td>${item.name}</td>
							<td>${item.remark}</td>
							<td class="pn-lopt"><a href="javascript:edit(${item.id},${pager.pageSize},${pager.currentPage});" class="pn-loperator">�޸�</a>
							�� <a href="javascript:del(${item.id});" class="pn-loperator">ɾ��</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../include/pager.jsp"/>
			</form>
		</div>
	</body>
</html>