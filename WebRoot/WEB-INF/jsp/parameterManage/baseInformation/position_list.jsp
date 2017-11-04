<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
	<head>
		<title>λ����Ϣ�б�</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script language="javascript">
		if("${result}"=="SUCCESS"){
			alert("λ����Ϣ��ӳɹ���");
			}
		if("${message}"=="updateSuccess"){
			alert("�޸ĳɹ���");
			}
		if("${message}"=="deleteSuccess"){
			alert("ɾ���ɹ���");
			}
			function del(id,class_,name_,pageSize,currentPage){
				if(confirm("ȷ��Ҫɾ����")){
					window.location.href = "baseInfo_position_delete.do?positionInformation.no="+id+"&positionInformation.class_="+class_+"&positionInformation.name="+name_+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage;
				}
			}
			
			function add(){
				window.location.href = "baseInfo_position_add.do";
				}
			function getRowIndex(obj){
				get("pager.rowIndex").value=obj.rowIndex;
				}
			function edit(no,class_,pageSize,currentPage){
				window.location.href ="baseInfo_position_edit.do?positionInformation.no="+no+"&positionInformation.class_="+class_+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage+"&pager.rowIndex="+get("pager.rowIndex").value;
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
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form  name="tableForm"  method="post" action="baseInfo_position_list.do" >
			<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
				  <tr align="right">
						<td style="background-color:#FFFFFF;text-align:right;padding-right: 20px;padding-top: 2px;padding-bottom: 2px;">				
						<input style="height: 22px;" type="button"  value="&nbsp;���λ����Ϣ&nbsp;"  onclick="add();"/>
						</td>
					</tr>
				</table>		
			<table id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">λ�ñ���</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">λ������</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">����</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">Ψһ���</th>
				    	<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��&nbsp;&nbsp;��</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center"  onclick="getRowIndex(this)">
							<td  style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.no}</td>
							<td  style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.name}</td>
							<td  style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">
							<c:if test="${item.class_==1}">����</c:if>
							<c:if test="${item.class_==2}">վ�����ţ�</c:if>
							<c:if test="${item.class_==3}">����</c:if>
							<c:if test="${item.class_==9}">����</c:if></td>
							<td  style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.iid}</td>

							<td class="pn-lopt" style="white-space:nowrap;padding-left:5px;padding-right:5px;">
							<!--<a href="baseInfo_position_edit.do?positionInformation.no=${item.no}&positionInformation.class_=${item.class_}" class="pn-loperator">�޸�</a>-->
							<a href="javascript:edit(${item.no},${item.class_},${pager.pageSize},${pager.currentPage})" class="pn-loperator">�޸�</a>
							�� <a href="javascript:del(${item.no},${item.class_},'${item.name}',${pager.pageSize},${pager.currentPage});" class="pn-loperator">ɾ��</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../../include/pager.jsp"/>
			</form>
		
		</div>
		
	</body>
</html>